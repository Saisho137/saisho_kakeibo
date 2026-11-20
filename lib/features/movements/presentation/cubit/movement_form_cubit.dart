import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement_draft.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/prefill_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

part 'movement_form_cubit.freezed.dart';
part 'movement_form_state.dart';

/// The quick entry form of an income or expense, new or stored (RF-01).
class MovementFormCubit extends Cubit<MovementFormState> {
  new({
    required this._getAccounts,
    required this._getCategories,
    required this._getCurrencies,
    required this._getPayees,
    required this._getMovement,
    required this._prefill,
    required this._suggestPeriodStart,
    required this._saveMovement,
    required this._deleteMovement,
  }) : super(const MovementFormState());

  final GetAccounts _getAccounts;
  final GetCategories _getCategories;
  final GetCurrencies _getCurrencies;
  final GetPayees _getPayees;
  final GetMovement _getMovement;
  final PrefillMovement _prefill;
  final SuggestPeriodStart _suggestPeriodStart;
  final SaveMovement _saveMovement;
  final DeleteMovement _deleteMovement;

  /// Days between period starts, from Settings.
  int _minDays = 21;

  /// Starts a movement of [type] from a [categoryId] or a [payeeId], or
  /// loads the movement [id] to edit it.
  Future<void> load({
    MovementType type = MovementType.expense,
    int? categoryId,
    int? payeeId,
    int? id,
    int minDays = 21,
  }) async {
    _minDays = minDays;
    final List<Account> accounts;
    final List<Category> categories;
    final List<Currency> currencies;
    final List<Payee> payees;
    switch ((
      await _getAccounts(const NoParams()),
      await _getCategories(const NoParams()),
      await _getCurrencies(const NoParams()),
      await _getPayees(const NoParams()),
    )) {
      case (
        Ok(value: final a),
        Ok(value: final c),
        Ok(value: final cu),
        Ok(value: final p),
      ):
        (accounts, categories, currencies, payees) = (a, c, cu, p);
      case (Err(:final failure), _, _, _) ||
          (_, Err(:final failure), _, _) ||
          (_, _, Err(:final failure), _) ||
          (_, _, _, Err(:final failure)):
        emit(
          state.copyWith(status: MovementFormStatus.notFound, failure: failure),
        );
        return;
    }
    final loaded = state.copyWith(
      accounts: accounts,
      categories: categories,
      currencies: currencies,
      payees: payees,
    );

    if (id != null) {
      final found = await _getMovement(id);
      final movement = found is Ok<Movement?> ? found.value : null;
      if (movement == null ||
          movement.type == MovementType.transfer ||
          movement.type == MovementType.adjustment) {
        emit(loaded.copyWith(status: MovementFormStatus.notFound));
        return;
      }
      final next = loaded.copyWith(
        original: movement,
        type: movement.type,
        categoryId: movement.categoryId,
        accountId: movement.accountId,
        date: movement.date,
        payeeName: payees
            .where((p) => p.id == movement.payeeId)
            .firstOrNull
            ?.name,
        note: movement.note ?? '',
        startsPeriod: movement.startsPeriod,
        isPending: movement.isPending,
      );
      emit(
        next.copyWith(
          status: MovementFormStatus.editing,
          amount: AmountInput.fromMinor(movement.amount, next.format),
        ),
      );
      return;
    }

    final drafted = await _prefill(
      PrefillMovementParams(
        type: type,
        categoryId: categoryId,
        payeeId: payeeId,
      ),
    );
    final draft = drafted is Ok<MovementDraft> ? drafted.value : null;
    final next = loaded.copyWith(
      type: type,
      categoryId: draft?.categoryId ?? categoryId,
      accountId: draft?.accountId,
      payeeName: draft?.payeeName,
      date: LocalDate.today(),
    );
    final amount = draft?.amount;
    emit(
      next.copyWith(
        status: MovementFormStatus.editing,
        amount: amount == null
            ? const AmountInput()
            : AmountInput.fromMinor(amount, next.format),
        amountSelected: amount != null,
      ),
    );
    await _suggestStart();
  }

  /// A digit replaces a prefilled amount; an operator keeps it.
  void keyPressed(KeypadKey key) {
    final replace = state.amountSelected && !key.isOperator;
    final base = replace ? const AmountInput() : state.amount;
    _change(
      state.copyWith(
        amount: key == KeypadKey.backspace && replace
            ? base
            : base.press(key, state.format),
        amountSelected: false,
      ),
    );
  }

  void categoryChanged(int id) => _change(state.copyWith(categoryId: id));

  /// An account in a currency with other decimals clears the amount, so it
  /// is never read with the wrong number of decimals.
  void accountChanged(int id) {
    final before = state.format.decimals;
    final next = state.copyWith(accountId: id);
    _change(
      next.format.decimals == before
          ? next
          : next.copyWith(amount: const AmountInput(), amountSelected: false),
    );
  }

  void payeeChanged(String name) => _change(state.copyWith(payeeName: name));

  void noteChanged(String note) => _change(state.copyWith(note: note));

  Future<void> dateChanged(LocalDate date) async {
    _change(state.copyWith(date: date));
    if (!state.startsPeriodTouched) await _suggestStart();
  }

  void startsPeriodChanged({required bool value}) =>
      _change(state.copyWith(startsPeriod: value, startsPeriodTouched: true));

  /// Validates and saves. A pending movement is confirmed by saving it.
  Future<void> submit() async {
    final (movement, errors) = _read(state);
    if (movement == null || errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: MovementFormStatus.saving, errors: {}));
    final result = await _saveMovement(
      SaveMovementParams(movement, payeeName: state.payeeName),
    );
    emit(switch (result) {
      Ok() => state.copyWith(status: MovementFormStatus.saved),
      Err(:final failure) => state.copyWith(
        status: MovementFormStatus.editing,
        failure: failure,
      ),
    });
  }

  Future<void> delete() async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: MovementFormStatus.saving));
    emit(switch (await _deleteMovement(id)) {
      Ok() => state.copyWith(status: MovementFormStatus.deleted),
      Err(:final failure) => state.copyWith(
        status: MovementFormStatus.editing,
        failure: failure,
      ),
    });
  }

  /// Checks "Starts period" on a new salary when N days have passed since
  /// the last period start (RF-05).
  Future<void> _suggestStart() async {
    if (state.isEditing || !state.isSalary) return;
    final date = state.date ?? LocalDate.today();
    final suggested = await _suggestPeriodStart(
      SuggestPeriodStartParams(date: date, minDays: _minDays),
    );
    if (suggested case Ok(:final value)) {
      emit(state.copyWith(startsPeriod: value));
    }
  }

  void _change(MovementFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  /// The movement the form describes and its errors; `null` while the
  /// amount can't be read.
  static (Movement?, Set<MovementError>) _read(MovementFormState form) {
    final amount = form.amount.evaluate(form.format);
    final accountId = form.accountId;
    final movement =
        (form.original ??
                Movement(
                  type: form.type,
                  date: LocalDate.today(),
                  accountId: 0,
                  amount: 0,
                ))
            .copyWith(
              date: form.date ?? LocalDate.today(),
              accountId: accountId ?? 0,
              amount: amount ?? 0,
              categoryId: form.categoryId,
              note: form.note,
              startsPeriod: form.isSalary && form.startsPeriod,
              isPending: false,
            );
    final errors = MovementRules.validate(
      MovementRules.normalize(movement),
      account: form.accounts.byId(accountId),
      category: form.category,
    );
    if (amount == null) errors.add(MovementError.invalidAmount);
    return (errors.isEmpty ? movement : null, errors);
  }
}
