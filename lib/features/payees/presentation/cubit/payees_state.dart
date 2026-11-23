part of 'payees_cubit.dart';

enum PayeesStatus { loading, success, failure }

/// The current period of the Home's view, or every movement.
enum PayeeScope { period, allTime }

/// Most spent, most used or alphabetical.
enum PayeeSort { spent, used, name }

/// An entity with what it adds up to in the shown currency and scope.
typedef PayeeLine = ({Payee payee, PayeeStats stats});

@freezed
abstract class PayeesState with _$PayeesState {
  const factory({
    @Default(PayeesStatus.loading) PayeesStatus status,
    LocalDate? today,

    /// Every stream's latest value; `null` until it arrives.
    List<Payee>? payees,
    List<Movement>? movements,
    List<Account>? accounts,
    List<Category>? categories,
    List<LocalDate>? periodStarts,
    @Default(<Currency>[]) List<Currency> currencies,
    AppSettings? settings,

    /// Currency picked on the screen; the main one until then.
    String? selectedCurrencyCode,
    @Default(PayeeScope.period) PayeeScope scope,
    @Default(PayeeSort.spent) PayeeSort sort,
    @Default('') String query,
    Failure? failure,
  }) = _PayeesState;

  const new _();

  String? get currencyCode =>
      selectedCurrencyCode ?? settings?.mainCurrencyCode;

  Currency? get currency =>
      currencies.where((c) => c.code == currencyCode).firstOrNull;

  /// Currencies of the active accounts, plus the shown one.
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

  /// Today's period in the Home's view.
  Period? get period {
    final settings = this.settings;
    final today = this.today;
    if (settings == null || today == null) return null;
    return PeriodCalculator(
      type: settings.periodType,
      cutoffDay: settings.cutoffDay,
      starts: periodStarts ?? const [],
    ).periodOf(today);
  }

  Category? categoryOf(int? id) => categories?.byId(id);

  /// Entities matching the search, with their totals in the shown currency
  /// and scope, in the chosen order. The period shows the entities with
  /// movements in it; all time also shows those without any, so they can
  /// be cleaned up.
  List<PayeeLine> get lines {
    final accounts = this.accounts ?? const <Account>[];
    final period = this.period;
    final key = TextNormalizer.key(query);
    final used = <int>{};
    final byPayee = <int, List<Movement>>{};
    for (final m in movements ?? const <Movement>[]) {
      final payeeId = m.payeeId;
      if (payeeId == null) continue;
      used.add(payeeId);
      if (accounts.byId(m.accountId)?.currencyCode != currencyCode) continue;
      if (scope == PayeeScope.period && period?.contains(m.date) != true) {
        continue;
      }
      (byPayee[payeeId] ??= []).add(m);
    }
    final lines = [
      for (final p in payees ?? const <Payee>[])
        if (key.isEmpty || p.key.contains(key))
          if (PayeeStats.of(byPayee[p.id] ?? const []) case final stats
              when stats.count > 0 ||
                  (scope == PayeeScope.allTime && !used.contains(p.id)))
            (payee: p, stats: stats),
    ];
    int byName(PayeeLine a, PayeeLine b) => a.payee.key.compareTo(b.payee.key);
    return lines..sort(
      (a, b) => switch (sort) {
        PayeeSort.spent => _then(
          b.stats.expense.compareTo(a.stats.expense),
          () => _then(
            b.stats.income.compareTo(a.stats.income),
            () => byName(a, b),
          ),
        ),
        PayeeSort.used => _then(
          b.stats.count.compareTo(a.stats.count),
          () => byName(a, b),
        ),
        PayeeSort.name => byName(a, b),
      },
    );
  }

  static int _then(int first, int Function() next) =>
      first != 0 ? first : next();
}
