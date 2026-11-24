part of 'home_cubit.dart';

enum HomeStatus { loading, success, failure }

@freezed
abstract class HomeState with _$HomeState {
  const factory({
    @Default(HomeStatus.loading) HomeStatus status,

    /// The day the Home opened; its period is shown first.
    LocalDate? today,

    /// Every stream's latest value; `null` until it arrives.
    AppSettings? settings,
    List<Account>? accounts,
    Map<int, int>? balances,
    @Default(<Currency>[]) List<Currency> currencies,
    List<Movement>? movements,
    List<LocalDate>? periodStarts,
    List<Category>? categories,
    List<Pillar>? pillars,
    List<Payee>? payees,
    List<Debt>? debts,

    /// Currency picked in the quick menu; the main one until then.
    String? selectedCurrencyCode,

    /// Period swiped to; today's until then.
    Period? selectedPeriod,
    Failure? failure,
  }) = _HomeState;

  const new _();

  String? get currencyCode =>
      selectedCurrencyCode ?? settings?.mainCurrencyCode;

  Currency? get currency =>
      currencies.where((c) => c.code == currencyCode).firstOrNull;

  /// Currencies of the active accounts, plus the active one, in the order
  /// of [currencies].
  List<Currency> get currencyOptions {
    final codes = {
      ?currencyCode,
      for (final a in accounts ?? const <Account>[])
        if (!a.isArchived) a.currencyCode,
    };
    return [
      for (final c in currencies)
        if (codes.contains(c.code)) c,
    ];
  }

  /// Periods from the newest movement or today, whichever is later, back
  /// to the oldest movement, newest first.
  List<Period> get periods {
    final settings = this.settings;
    final today = this.today;
    if (settings == null || today == null) return const [];
    return PeriodCalculator(
      type: settings.periodType,
      cutoffDay: settings.cutoffDay,
      starts: periodStarts ?? const [],
    ).covering(today, (movements ?? const <Movement>[]).map((m) => m.date));
  }

  /// Index of today's period in [periods].
  int get currentIndex {
    final today = this.today;
    if (today == null) return 0;
    return max(0, periods.indexWhere((p) => p.contains(today)));
  }

  /// The period on screen: the swiped one while it still exists (a new
  /// period type splits time anew), today's otherwise.
  Period? get visiblePeriod {
    final periods = this.periods;
    if (periods.isEmpty) return null;
    final selected = selectedPeriod;
    return selected != null && periods.contains(selected)
        ? selected
        : periods[currentIndex];
  }

  /// Movements of [period] that the quick menu's filter keeps (RF-17).
  Iterable<Movement> _shownIn(Period period) {
    final filter = settings?.balanceFilter ?? BalanceFilter.both;
    final accounts = this.accounts ?? const <Account>[];
    return (movements ?? const <Movement>[]).where(
      (m) => period.contains(m.date) && filter.keepsMovement(m, accounts),
    );
  }

  /// Movements of [period] in the active currency, newest first, each with
  /// the account it is seen from: its own, or the receiver of a transfer
  /// from another currency.
  List<({Movement movement, int accountId})> historyOf(Period period) {
    final code = currencyCode;
    final accounts = this.accounts ?? const <Account>[];
    if (code == null) return const [];
    return [
      for (final m in _shownIn(period))
        if (accounts.byId(m.accountId)?.currencyCode == code)
          (movement: m, accountId: m.accountId)
        else if (accounts.byId(m.toAccountId)?.currencyCode == code)
          (movement: m, accountId: m.toAccountId!),
    ];
  }

  /// [historyOf] grouped by day, newest day first.
  List<(LocalDate, List<({Movement movement, int accountId})>)> daysOf(
    Period period,
  ) {
    final groups = <LocalDate, List<({Movement movement, int accountId})>>{};
    for (final entry in historyOf(period)) {
      (groups[entry.movement.date] ??= []).add(entry);
    }
    return [for (final MapEntry(:key, :value) in groups.entries) (key, value)];
  }

  /// Income less expenses of [movements] in the active currency, as the
  /// totals count them: a day's balance in the history.
  int netOf(Iterable<Movement> movements) {
    final code = currencyCode;
    if (code == null) return 0;
    final totals =
        PeriodTotals.of(movements, accounts ?? const [])[code] ??
        const CurrencyTotals();
    return totals.income - totals.expenses;
  }

  /// Categories of [type] in [period] by amount, largest first, with their
  /// share of the type's total (RF-14).
  List<({Category category, int amount, double share})> categoriesOf(
    Period period,
    MovementType type,
  ) {
    final code = currencyCode;
    if (code == null) return const [];
    final amounts = PeriodTotals.byCategory(
      _shownIn(period),
      accounts ?? const [],
      currencyCode: code,
      type: type,
    );
    final total = amounts.fold(0, (sum, a) => sum + a.amount);
    return [
      for (final (:categoryId, :amount) in amounts)
        if (categories?.byId(categoryId) case final category?)
          (category: category, amount: amount, share: amount / total),
    ];
  }

  Payee? payeeOf(Movement movement) =>
      payees?.where((p) => p.id == movement.payeeId).firstOrNull;

  /// Income, Expenses and Transfers of [period] in the active currency,
  /// over every account of it that the filter keeps (RF-14).
  CurrencyTotals totalsOf(Period period) {
    final code = currencyCode;
    if (code == null) return const CurrencyTotals();
    return PeriodTotals.of(_shownIn(period), accounts ?? const [])[code] ??
        const CurrencyTotals();
  }

  /// Expenses of [period] in the active currency by pillar and category.
  DonutData donutOf(Period period) {
    final code = currencyCode;
    if (code == null) return const DonutData(total: 0, pillars: []);
    return DonutData.of(
      movements: _shownIn(period),
      accounts: accounts ?? const [],
      categories: categories ?? const [],
      pillars: pillars ?? const [],
      currencyCode: code,
      debts: debts ?? const [],
    );
  }

  /// Balance of the main view in the active currency; `null` until loaded.
  Money? get balance {
    final accounts = this.accounts;
    final balances = this.balances;
    final code = currencyCode;
    final settings = this.settings;
    if (accounts == null ||
        balances == null ||
        code == null ||
        settings == null) {
      return null;
    }
    return homeBalance(
      accounts: accounts,
      balances: balances,
      currencyCode: code,
      filter: settings.balanceFilter,
    );
  }
}
