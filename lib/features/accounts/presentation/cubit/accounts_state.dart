part of 'accounts_cubit.dart';

enum AccountsStatus { loading, success, failure }

@freezed
abstract class AccountsState with _$AccountsState {
  const factory({
    @Default(AccountsStatus.loading) AccountsStatus status,

    /// Every account, archived included; `null` until loaded.
    List<Account>? accounts,

    /// Own balance by account id; `null` until loaded.
    Map<int, int>? balances,
    @Default(<Currency>[]) List<Currency> currencies,

    /// Currency shown on the Accounts screen.
    String? currencyCode,
    @Default(false) bool showArchived,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _AccountsState;

  const new _();

  Currency? get currency =>
      currencies.where((c) => c.code == currencyCode).firstOrNull;

  /// What the Accounts screen shows; `null` until loaded.
  AccountsOverview? get overview {
    final accounts = this.accounts;
    final balances = this.balances;
    final code = currencyCode;
    if (accounts == null || balances == null || code == null) return null;
    return AccountsOverview.build(
      accounts: accounts,
      balances: balances,
      currencyCode: code,
      showArchived: showArchived,
    );
  }
}
