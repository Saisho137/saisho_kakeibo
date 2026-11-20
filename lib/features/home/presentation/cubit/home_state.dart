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

    /// Currency picked in the quick menu; the main one until then.
    String? selectedCurrencyCode,
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

  /// Income, Expenses and Transfers of [period] in the active currency,
  /// over every account of it (RF-14).
  CurrencyTotals totalsOf(Period period) {
    final code = currencyCode;
    if (code == null) return const CurrencyTotals();
    final inPeriod = (movements ?? const <Movement>[]).where(
      (m) => period.contains(m.date),
    );
    return PeriodTotals.of(inPeriod, accounts ?? const [])[code] ??
        const CurrencyTotals();
  }

  /// Expenses of [period] in the active currency by pillar and category.
  DonutData donutOf(Period period) {
    final code = currencyCode;
    if (code == null) return const DonutData(total: 0, pillars: []);
    return DonutData.of(
      movements: (movements ?? const <Movement>[]).where(
        (m) => period.contains(m.date),
      ),
      accounts: accounts ?? const [],
      categories: categories ?? const [],
      pillars: pillars ?? const [],
      currencyCode: code,
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
