import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

/// The Home Balance (RF-17): accounts included in the Balance in
/// [currencyCode], narrowed by the quick menu's [filter]. *Cash* keeps the
/// cash accounts and *Bank* the rest, pockets included.
Money homeBalance({
  required List<Account> accounts,
  required Map<int, int> balances,
  required String currencyCode,
  required BalanceFilter filter,
}) {
  bool passes(Account a) => switch (filter) {
    BalanceFilter.both => true,
    BalanceFilter.cash => a.type == AccountType.cash,
    BalanceFilter.bank => a.type != AccountType.cash,
  };
  return accounts
      .where(
        (a) =>
            a.includeInBalance && a.currencyCode == currencyCode && passes(a),
      )
      .fold(
        Money.zero(currencyCode),
        (sum, a) =>
            sum + Money(balances[a.id] ?? a.openingBalance, currencyCode),
      );
}
