part of 'account_detail_cubit.dart';

enum AccountDetailStatus { loading, success, notFound, failure }

@freezed
abstract class AccountDetailState with _$AccountDetailState {
  const factory({
    @Default(AccountDetailStatus.loading) AccountDetailStatus status,
    int? accountId,

    /// The day the screen opened; its period is shown first.
    LocalDate? today,

    /// Every stream's latest value; `null` until it arrives.
    List<Account>? accounts,
    Map<int, int>? balances,
    @Default(<Currency>[]) List<Currency> currencies,
    List<Movement>? movements,
    List<Category>? categories,
    List<Payee>? payees,
    AppSettings? settings,
    List<LocalDate>? periodStarts,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _AccountDetailState;

  const new _();

  Account? get account => accounts?.byId(accountId);

  Currency? get currency {
    final code = account?.currencyCode;
    return currencies.where((c) => c.code == code).firstOrNull;
  }

  List<Account> get pockets {
    final id = accountId;
    if (id == null) return const [];
    return (accounts ?? const <Account>[]).pocketsOf(id).toList();
  }

  int _own(Account a) => balances?[a.id] ?? a.openingBalance;

  /// Own balance plus the pockets', as the bank shows it.
  Money? get balance {
    final account = this.account;
    if (account == null) return null;
    return Money(
      [account, ...pockets].fold(0, (sum, a) => sum + _own(a)),
      account.currencyCode,
    );
  }

  /// Money outside the pockets; `null` without pockets.
  Money? get free {
    final account = this.account;
    if (account == null || pockets.isEmpty) return null;
    return Money(_own(account), account.currencyCode);
  }

  /// Periods from the newest movement or today, whichever is later, back
  /// to the oldest movement, newest first.
  List<Period> get periods {
    final settings = this.settings;
    final today = this.today;
    if (settings == null || today == null) return const [];
    final dates = [today, ...?movements?.map((m) => m.date)];
    return PeriodCalculator(
      type: settings.periodType,
      cutoffDay: settings.cutoffDay,
      starts: periodStarts ?? const [],
    ).range(
      oldest: dates.reduce((a, b) => a.isBefore(b) ? a : b),
      newest: dates.reduce((a, b) => a.isAfter(b) ? a : b),
    );
  }

  /// Index of today's period in [periods].
  int get currentIndex {
    final today = this.today;
    if (today == null) return 0;
    return max(0, periods.indexWhere((p) => p.contains(today)));
  }

  /// Movements of [period] grouped by day, newest day first.
  List<(LocalDate, List<Movement>)> daysIn(Period period) {
    final groups = <LocalDate, List<Movement>>{};
    for (final movement in movements ?? const <Movement>[]) {
      if (!period.contains(movement.date)) continue;
      (groups[movement.date] ??= []).add(movement);
    }
    return [for (final MapEntry(:key, :value) in groups.entries) (key, value)];
  }

  Category? categoryOf(Movement movement) =>
      categories?.where((c) => c.id == movement.categoryId).firstOrNull;

  Payee? payeeOf(Movement movement) =>
      payees?.where((p) => p.id == movement.payeeId).firstOrNull;

  Account? accountById(int? id) => accounts?.byId(id);
}
