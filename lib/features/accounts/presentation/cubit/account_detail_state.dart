part of 'account_detail_cubit.dart';

enum AccountDetailStatus { loading, success, notFound, failure }

@freezed
abstract class AccountDetailState with _$AccountDetailState {
  const factory({
    @Default(AccountDetailStatus.loading) AccountDetailStatus status,
    int? accountId,

    /// Every stream's latest value; `null` until it arrives.
    List<Account>? accounts,
    Map<int, int>? balances,
    @Default(<Currency>[]) List<Currency> currencies,
    List<Movement>? movements,
    List<Category>? categories,
    List<Payee>? payees,

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

  /// Movements grouped by day, newest day first.
  List<(LocalDate, List<Movement>)> get days {
    final groups = <LocalDate, List<Movement>>{};
    for (final movement in movements ?? const <Movement>[]) {
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
