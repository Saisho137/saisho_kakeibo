part of 'debts_cubit.dart';

enum DebtsStatus { loading, success, failure }

/// A debt with what is pending on it.
typedef DebtLine = ({Debt debt, DebtStatus status});

@freezed
abstract class DebtsState with _$DebtsState {
  const factory({
    @Default(DebtsStatus.loading) DebtsStatus status,

    /// Every stream's latest value; `null` until it arrives.
    List<Debt>? debts,
    List<Movement>? movements,
    List<Account>? accounts,
    Map<int, int>? balances,
    List<Payee>? payees,
    List<Pillar>? pillars,
    @Default(<Currency>[]) List<Currency> currencies,
    AppSettings? settings,

    /// Currency picked on the screen; the main one until then.
    String? selectedCurrencyCode,
    Failure? failure,
  }) = _DebtsState;

  const new _();

  String? get currencyCode =>
      selectedCurrencyCode ?? settings?.mainCurrencyCode;

  Currency? get currency =>
      currencies.where((c) => c.code == currencyCode).firstOrNull;

  /// Currencies of the debts and the active accounts, plus the shown one.
  List<Currency> get currencyOptions {
    final codes = {
      ?currencyCode,
      for (final d in debts ?? const <Debt>[]) d.currencyCode,
      for (final a in accounts ?? const <Account>[])
        if (!a.isArchived) a.currencyCode,
    };
    return [
      for (final c in currencies)
        if (codes.contains(c.code)) c,
    ];
  }

  List<DebtLine> _lines(DebtType type) => [
    for (final debt in debts ?? const <Debt>[])
      if (debt.type == type && debt.currencyCode == currencyCode)
        (debt: debt, status: DebtStatus.of(debt, movements ?? const [])),
  ];

  /// Debts of [type] still pending, in the shown currency.
  List<DebtLine> active(DebtType type) => [
    for (final line in _lines(type))
      if (!line.status.isPaidOff) line,
  ];

  List<DebtLine> paidOff(DebtType type) => [
    for (final line in _lines(type))
      if (line.status.isPaidOff) line,
  ];

  /// What is left on the active debts of [type].
  int totalPending(DebtType type) =>
      active(type).fold(0, (sum, line) => sum + line.status.pending);

  /// Active credit cards of the shown currency with their balance (RF-09:
  /// they are accounts, shown here read only).
  List<(Account, int)> get cards => [
    for (final a in accounts ?? const <Account>[])
      if (a.type == AccountType.creditCard &&
          !a.isArchived &&
          a.currencyCode == currencyCode)
        (a, balances?[a.id] ?? a.openingBalance),
  ];

  Payee? payeeOf(Debt debt) =>
      payees?.where((p) => p.id == debt.payeeId).firstOrNull;

  Pillar? pillarOf(Debt debt) =>
      pillars?.where((p) => p.id == debt.pillarId).firstOrNull;
}
