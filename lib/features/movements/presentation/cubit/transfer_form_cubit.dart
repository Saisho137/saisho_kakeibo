import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/transfer_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_transfer_category.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

part 'transfer_form_cubit.freezed.dart';
part 'transfer_form_state.dart';

/// A transfer between two of my accounts, new or stored (RT-04, RT-05).
class TransferFormCubit extends Cubit<TransferFormState> {
  new({
    required this._getAccounts,
    required this._getCategories,
    required this._getCurrencies,
    required this._getMovement,
    required this._suggestCategory,
    required this._saveMovement,
    required this._deleteMovement,
  }) : super(const TransferFormState());

  final GetAccounts _getAccounts;
  final GetCategories _getCategories;
  final GetCurrencies _getCurrencies;
  final GetMovement _getMovement;
  final SuggestTransferCategory _suggestCategory;
  final SaveMovement _saveMovement;
  final DeleteMovement _deleteMovement;

  /// Starts a transfer from [fromAccountId] (the main account by default),
  /// or loads the transfer [id] to edit it.
  Future<void> load({int? fromAccountId, int? id}) async {
    final List<Account> accounts;
    final List<Category> categories;
    final List<Currency> currencies;
    switch ((
      await _getAccounts(const NoParams()),
      await _getCategories(const NoParams()),
      await _getCurrencies(const NoParams()),
    )) {
      case (Ok(value: final a), Ok(value: final c), Ok(value: final cu)):
        (accounts, categories, currencies) = (a, c, cu);
      case (Err(:final failure), _, _) ||
          (_, Err(:final failure), _) ||
          (_, _, Err(:final failure)):
        emit(
          state.copyWith(status: TransferFormStatus.notFound, failure: failure),
        );
        return;
    }
    final loaded = state.copyWith(
      accounts: accounts,
      categories: categories,
      currencies: currencies,
    );

    if (id != null) {
      final found = await _getMovement(id);
      final movement = found is Ok<Movement?> ? found.value : null;
      if (movement == null || movement.type != MovementType.transfer) {
        emit(loaded.copyWith(status: TransferFormStatus.notFound));
        return;
      }
      final next = loaded.copyWith(
        original: movement,
        fromAccountId: movement.accountId,
        toAccountId: movement.toAccountId,
        categoryId: movement.categoryId,
        categoryTouched: true,
        note: movement.note ?? '',
        date: movement.date,
      );
      emit(
        next.copyWith(
          status: TransferFormStatus.editing,
          amount: AmountInput.fromMinor(movement.amount, next.fromFormat),
          toAmount: next.sameCurrency
              ? const AmountInput()
              : AmountInput.fromMinor(
                  movement.toAmount ?? movement.amount,
                  next.toFormat,
                ),
        ),
      );
      return;
    }

    final active = accounts.where((a) => !a.isArchived);
    final from =
        active.byId(fromAccountId) ??
        active.where((a) => a.isMain).firstOrNull ??
        active.firstOrNull;
    emit(
      loaded.copyWith(
        status: TransferFormStatus.editing,
        fromAccountId: from?.id,
        date: LocalDate.today(),
      ),
    );
  }

  void keyPressed(KeypadKey key) {
    if (state.editingTo && !state.sameCurrency) {
      _change(
        state.copyWith(toAmount: state.toAmount.press(key, state.toFormat)),
      );
    } else {
      _change(
        state.copyWith(amount: state.amount.press(key, state.fromFormat)),
      );
    }
  }

  /// Chooses which amount the keypad types: what leaves or what arrives.
  void editingToChanged({required bool value}) =>
      emit(state.copyWith(editingTo: value && !state.sameCurrency));

  Future<void> fromChanged(int id) async {
    final before = state.fromFormat.decimals;
    final next = state.copyWith(fromAccountId: id);
    await _accountsChanged(
      next.fromFormat.decimals == before
          ? next
          : next.copyWith(amount: const AmountInput()),
    );
  }

  Future<void> toChanged(int id) async {
    final before = state.toFormat.decimals;
    final next = state.copyWith(toAccountId: id);
    await _accountsChanged(
      next.toFormat.decimals == before
          ? next
          : next.copyWith(toAmount: const AmountInput()),
    );
  }

  void categoryChanged(int id) =>
      _change(state.copyWith(categoryId: id, categoryTouched: true));

  void noteChanged(String note) => _change(state.copyWith(note: note));

  void dateChanged(LocalDate date) => _change(state.copyWith(date: date));

  Future<void> submit() async {
    final (movement, errors) = _read(state);
    if (movement == null || errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: TransferFormStatus.saving, errors: {}));
    final result = await _saveMovement(SaveMovementParams(movement));
    emit(switch (result) {
      Ok() => state.copyWith(status: TransferFormStatus.saved),
      Err(:final failure) => state.copyWith(
        status: TransferFormStatus.editing,
        failure: failure,
      ),
    });
  }

  Future<void> delete() async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: TransferFormStatus.saving));
    emit(switch (await _deleteMovement(id)) {
      Ok() => state.copyWith(status: TransferFormStatus.deleted),
      Err(:final failure) => state.copyWith(
        status: TransferFormStatus.editing,
        failure: failure,
      ),
    });
  }

  /// Applies new accounts and, until the user picks a category, suggests
  /// one for the pair.
  Future<void> _accountsChanged(TransferFormState next) async {
    _change(next.copyWith(editingTo: next.editingTo && !next.sameCurrency));
    final from = next.from;
    final to = next.to;
    if (next.categoryTouched || from == null || to == null) return;
    final suggested = await _suggestCategory(
      SuggestTransferCategoryParams(from: from, to: to),
    );
    if (suggested case Ok(:final value?)) {
      _change(state.copyWith(categoryId: value));
    }
  }

  void _change(TransferFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  /// The transfer the form describes and its errors; `null` while an
  /// amount can't be read.
  static (Movement?, Set<MovementError>) _read(TransferFormState form) {
    final amount = form.amount.evaluate(form.fromFormat);
    final toAmount = form.sameCurrency
        ? amount
        : form.toAmount.evaluate(form.toFormat);
    final movement =
        (form.original ??
                Movement(
                  type: MovementType.transfer,
                  date: LocalDate.today(),
                  accountId: 0,
                  amount: 0,
                ))
            .copyWith(
              date: form.date ?? LocalDate.today(),
              accountId: form.fromAccountId ?? 0,
              toAccountId: form.toAccountId,
              amount: amount ?? 0,
              toAmount: toAmount ?? 0,
              categoryId: form.categoryId,
              note: form.note,
              isPending: false,
            );
    final errors = MovementRules.validate(
      movement,
      account: form.from,
      toAccount: form.to,
      category: form.categories.byId(form.categoryId),
    );
    if (amount == null || toAmount == null) {
      errors.add(MovementError.invalidAmount);
    }
    return (errors.isEmpty ? movement : null, errors);
  }
}
