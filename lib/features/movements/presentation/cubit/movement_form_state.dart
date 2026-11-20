part of 'movement_form_cubit.dart';

enum MovementFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class MovementFormState with _$MovementFormState {
  const factory({
    @Default(MovementFormStatus.loading) MovementFormStatus status,

    /// The stored movement when editing; `null` when creating.
    Movement? original,
    @Default(MovementType.expense) MovementType type,
    int? categoryId,
    int? accountId,
    @Default(AmountInput()) AmountInput amount,

    /// A prefilled amount is replaced by the first digit typed.
    @Default(false) bool amountSelected,
    String? payeeName,
    @Default('') String note,
    LocalDate? date,
    @Default(false) bool startsPeriod,

    /// Whether the user set "Starts period"; then the date no longer
    /// changes it.
    @Default(false) bool startsPeriodTouched,

    /// A pending movement shows "Confirm" instead of "Save" (RF-06).
    @Default(false) bool isPending,
    @Default(<Account>[]) List<Account> accounts,
    @Default(<Category>[]) List<Category> categories,
    @Default(<Currency>[]) List<Currency> currencies,
    @Default(<Payee>[]) List<Payee> payees,
    @Default(<MovementError>{}) Set<MovementError> errors,
    @Default(false) bool showErrors,

    /// Last failure of a save or delete, shown once by the UI.
    Failure? failure,
  }) = _MovementFormState;

  const new _();

  bool get isEditing => original != null;

  Category? get category => categories.byId(categoryId);

  bool get isSalary => category?.role == CategoryRole.salary;

  Account? get account => accounts.byId(accountId);

  Currency? get currency {
    final code = account?.currencyCode;
    return currencies.where((c) => c.code == code).firstOrNull;
  }

  CurrencyFormat get format => currency?.format ?? CurrencyFormat.cop;

  /// Active accounts, pockets included, plus the stored account of an
  /// edited movement even if it is archived now.
  List<Account> get accountOptions => [
    for (final a in accounts)
      if (!a.isArchived || a.id == original?.accountId) a,
  ];

  /// Active categories of the movement's type, plus the stored one.
  List<Category> get categoryOptions {
    final categoryType = type == MovementType.income
        ? CategoryType.income
        : CategoryType.expense;
    return [
      for (final c in categories)
        if (c.type == categoryType && !c.isArchived && !c.role.needsDebt ||
            c.id == original?.categoryId)
          c,
    ];
  }

  /// Payee names that match what is typed (RF-07).
  List<String> payeeOptions(String typed) {
    final key = TextNormalizer.key(typed);
    if (key.isEmpty) return const [];
    return [
      for (final p in payees)
        if (p.key.contains(key)) p.name,
    ];
  }

  /// The amount once evaluated, when it has operations.
  int? get result => amount.hasOperator ? amount.evaluate(format) : null;
}
