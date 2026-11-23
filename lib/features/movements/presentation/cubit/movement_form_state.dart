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

    /// Every debt with its status, and the pillars a new debt can take.
    @Default(<DebtWithStatus>[]) List<DebtWithStatus> debts,
    @Default(<Pillar>[]) List<Pillar> pillars,

    /// The debt picked; `null` with [newDebt] or before picking.
    int? debtId,

    /// The movement creates its debt (RF-09).
    @Default(false) bool newDebt,

    /// Whether the user picked the debt; then the payee no longer does.
    @Default(false) bool debtTouched,

    /// Pillar of the debt a loan received creates.
    int? debtPillarId,

    /// What a loan received leaves pending; the amount when empty.
    @Default('') String debtPendingText,
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
        if (c.type == categoryType && !c.isArchived ||
            c.id == original?.categoryId)
          c,
    ];
  }

  /// Type of the debt the category works with, if any (RF-09).
  DebtType? get debtType {
    final role = category?.role;
    return role == null ? null : DebtRules.typeFor(role);
  }

  /// A loan received always creates its debt; it shows no picker.
  bool get alwaysNewDebt =>
      !isEditing && category?.role == CategoryRole.loanReceived;

  /// A loan given may create its debt instead of adding to one.
  bool get mayCreateDebt =>
      !isEditing && category?.role == CategoryRole.loanGiven;

  /// The movement creates its debt: always for a loan received.
  bool get createsDebt => alwaysNewDebt || (mayCreateDebt && newDebt);

  /// Debts of the category's type in the account's currency that are still
  /// open, plus the stored one.
  List<DebtWithStatus> get debtOptions {
    final type = debtType;
    if (type == null) return const [];
    return [
      for (final line in debts)
        if (line.debt.type == type &&
            line.debt.currencyCode == account?.currencyCode &&
            (!line.status.isPaidOff || line.debt.id == original?.debtId))
          line,
    ];
  }

  DebtWithStatus? get debt =>
      debts.where((d) => d.debt.id == debtId).firstOrNull;

  /// A movement on an existing debt takes the debt's payee.
  bool get showsPayee => debtType == null || createsDebt;

  /// What the form tells the save about its debt.
  DebtChoice? get debtChoice {
    if (debtType == null) return null;
    if (createsDebt) {
      final pending = debtPendingText.trim().isEmpty
          ? null
          : AmountParser.parse(debtPendingText, format);
      return NewDebt(pillarId: debtPillarId, initialPending: pending);
    }
    final id = debtId;
    return id == null ? null : ExistingDebt(id);
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
