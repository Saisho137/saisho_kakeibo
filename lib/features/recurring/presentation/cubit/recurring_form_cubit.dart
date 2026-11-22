import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
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
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/delete_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/get_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/save_recurring_template.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

part 'recurring_form_cubit.freezed.dart';
part 'recurring_form_state.dart';

/// Creates or edits a recurring template (RF-06), also from a saved
/// movement ("Make recurring").
class RecurringFormCubit extends Cubit<RecurringFormState> {
  new({
    required this._getAccounts,
    required this._getCategories,
    required this._getCurrencies,
    required this._getPayees,
    required this._getMovement,
    required this._getTemplate,
    required this._saveTemplate,
    required this._deleteTemplate,
  }) : super(const RecurringFormState());

  final GetAccounts _getAccounts;
  final GetCategories _getCategories;
  final GetCurrencies _getCurrencies;
  final GetPayees _getPayees;
  final GetMovement _getMovement;
  final GetRecurringTemplate _getTemplate;
  final SaveRecurringTemplate _saveTemplate;
  final DeleteRecurringTemplate _deleteTemplate;

  /// Loads the template [id], or starts one from the movement
  /// [fromMovementId], or an empty expense in the main account.
  Future<void> load({int? id, int? fromMovementId}) async {
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
          state.copyWith(
            status: RecurringFormStatus.notFound,
            failure: failure,
          ),
        );
        return;
    }
    final loaded = state.copyWith(
      status: RecurringFormStatus.editing,
      accounts: accounts,
      categories: categories,
      currencies: currencies,
      payees: payees,
      accountId: accounts.where((a) => a.isMain).firstOrNull?.id,
    );

    if (id != null) {
      final found = await _getTemplate(id);
      if (found case Ok(value: final template?)) {
        emit(_fill(loaded.copyWith(original: template), template));
      } else {
        emit(loaded.copyWith(status: RecurringFormStatus.notFound));
      }
      return;
    }
    if (fromMovementId != null) {
      if (await _getMovement(fromMovementId) case Ok(value: final m?)) {
        final template = RecurringTemplate(
          type: m.type,
          categoryId: m.categoryId ?? 0,
          accountId: m.accountId,
          toAccountId: m.toAccountId,
          amount: m.amount,
          toAmount: m.toAmount,
          payeeId: m.payeeId,
          note: m.note,
          createdOn: LocalDate.today(),
        );
        emit(_fill(loaded, template));
        return;
      }
    }
    emit(loaded);
  }

  RecurringFormState _fill(RecurringFormState form, RecurringTemplate t) {
    final next = form.copyWith(
      type: t.type,
      cadence: t.cadence,
      categoryId: t.categoryId == 0 ? null : t.categoryId,
      accountId: t.accountId,
      toAccountId: t.toAccountId,
      payeeName: form.payees.where((p) => p.id == t.payeeId).firstOrNull?.name,
      note: t.note ?? '',
      dueDay: t.dueDay,
      remind: t.remind,
    );
    String text(int amount, Account? account) => MoneyFormatter.format(
      Money(amount, account?.currencyCode ?? ''),
      next.formatOf(account),
    );
    return next.copyWith(
      amountText: text(t.amount, next.account),
      toAmountText: text(t.toAmount ?? t.amount, next.toAccount),
    );
  }

  void typeChanged(MovementType type) {
    final keepsCategory = state.category?.type == _categoryType(type);
    _change(
      state.copyWith(
        type: type,
        categoryId: keepsCategory ? state.categoryId : null,
      ),
    );
  }

  void cadenceChanged(RecurringCadence cadence) =>
      _change(state.copyWith(cadence: cadence));

  void categoryChanged(int? id) => _change(state.copyWith(categoryId: id));

  void accountChanged(int? id) => _change(state.copyWith(accountId: id));

  void toAccountChanged(int? id) => _change(state.copyWith(toAccountId: id));

  void amountChanged(String text) => _change(state.copyWith(amountText: text));

  void toAmountChanged(String text) =>
      _change(state.copyWith(toAmountText: text));

  void payeeChanged(String name) => _change(state.copyWith(payeeName: name));

  void noteChanged(String note) => _change(state.copyWith(note: note));

  /// A new due day turns the reminder on; no day turns it off (RF-06).
  void dueDayChanged(int? day) =>
      _change(state.copyWith(dueDay: day, remind: day != null));

  void remindChanged({required bool value}) =>
      _change(state.copyWith(remind: value && state.dueDay != null));

  Future<void> submit() async {
    final (template, errors) = _read(state);
    if (template == null) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: RecurringFormStatus.saving));
    final result = await _saveTemplate(
      SaveRecurringTemplateParams(template, payeeName: state.payeeName),
    );
    emit(switch (result) {
      Ok() => state.copyWith(status: RecurringFormStatus.saved),
      Err(:final failure) => state.copyWith(
        status: RecurringFormStatus.editing,
        failure: failure,
      ),
    });
  }

  Future<void> delete() async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: RecurringFormStatus.saving));
    emit(switch (await _deleteTemplate(id)) {
      Ok() => state.copyWith(status: RecurringFormStatus.deleted),
      Err(:final failure) => state.copyWith(
        status: RecurringFormStatus.editing,
        failure: failure,
      ),
    });
  }

  void _change(RecurringFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  static CategoryType _categoryType(MovementType type) => switch (type) {
    MovementType.income => CategoryType.income,
    MovementType.transfer => CategoryType.transfer,
    _ => CategoryType.expense,
  };

  /// The template the form describes and its errors; `null` while it is
  /// not valid.
  static (RecurringTemplate?, Set<MovementError>) _read(
    RecurringFormState form,
  ) {
    final amount = AmountParser.parse(
      form.amountText,
      form.formatOf(form.account),
    );
    final isTransfer = form.type == MovementType.transfer;
    final toAmount = isTransfer && !form.sameCurrency
        ? AmountParser.parse(form.toAmountText, form.formatOf(form.toAccount))
        : amount;
    final template = RecurringRules.normalize(
      (form.original ??
              RecurringTemplate(
                type: form.type,
                categoryId: 0,
                accountId: 0,
                amount: 0,
                createdOn: LocalDate.today(),
              ))
          .copyWith(
            type: form.type,
            cadence: form.cadence,
            categoryId: form.categoryId ?? 0,
            accountId: form.accountId ?? 0,
            toAccountId: form.toAccountId,
            amount: amount ?? 0,
            toAmount: toAmount,
            note: form.note,
            dueDay: form.dueDay,
            remind: form.remind,
          ),
    );
    final errors = RecurringRules.validate(
      template,
      account: form.account,
      toAccount: form.toAccount,
      category: form.category,
    );
    if (amount == null || toAmount == null) {
      errors.add(MovementError.invalidAmount);
    }
    return (errors.isEmpty ? template : null, errors);
  }
}
