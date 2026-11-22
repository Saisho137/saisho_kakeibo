part of 'recurring_form_cubit.dart';

enum RecurringFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class RecurringFormState with _$RecurringFormState {
  const factory({
    @Default(RecurringFormStatus.loading) RecurringFormStatus status,

    /// The stored template when editing; `null` when creating.
    RecurringTemplate? original,
    @Default(MovementType.expense) MovementType type,
    @Default(RecurringCadence.period) RecurringCadence cadence,
    int? categoryId,
    int? accountId,
    int? toAccountId,
    @Default('') String amountText,

    /// What a transfer adds to [toAccountId]; only between currencies.
    @Default('') String toAmountText,
    String? payeeName,
    @Default('') String note,
    int? dueDay,
    @Default(false) bool remind,
    @Default(<Account>[]) List<Account> accounts,
    @Default(<Category>[]) List<Category> categories,
    @Default(<Currency>[]) List<Currency> currencies,
    @Default(<Payee>[]) List<Payee> payees,
    @Default(<MovementError>{}) Set<MovementError> errors,
    @Default(false) bool showErrors,

    /// Last failure of a save or delete, shown once by the UI.
    Failure? failure,
  }) = _RecurringFormState;

  const new _();

  bool get isEditing => original != null;

  Category? get category => categories.byId(categoryId);

  Account? get account => accounts.byId(accountId);

  Account? get toAccount => accounts.byId(toAccountId);

  CurrencyFormat formatOf(Account? account) =>
      currencies
          .where((c) => c.code == account?.currencyCode)
          .firstOrNull
          ?.format ??
      CurrencyFormat.cop;

  /// Without a destination yet, a transfer is taken as one currency.
  bool get sameCurrency =>
      toAccount == null || toAccount?.currencyCode == account?.currencyCode;

  /// Active accounts, plus the stored ones of an edited template.
  List<Account> get accountOptions => [
    for (final a in accounts)
      if (!a.isArchived ||
          a.id == original?.accountId ||
          a.id == original?.toAccountId)
        a,
  ];

  /// Active categories of the template's type, plus the stored one. Debt
  /// categories wait for the debts (phase 8).
  List<Category> get categoryOptions {
    final categoryType = switch (type) {
      MovementType.income => CategoryType.income,
      MovementType.transfer => CategoryType.transfer,
      _ => CategoryType.expense,
    };
    return [
      for (final c in categories)
        if (c.type == categoryType && !c.isArchived && !c.role.needsDebt ||
            c.id == original?.categoryId)
          c,
    ];
  }
}
