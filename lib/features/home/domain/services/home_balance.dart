import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// The quick menu's filter of the whole Home (RF-17): *Cash* keeps the cash
/// accounts and *Bank* the rest, pockets included.
extension HomeFilter on BalanceFilter {
  bool keeps(Account account) => switch (this) {
    BalanceFilter.both => true,
    BalanceFilter.cash => account.type == AccountType.cash,
    BalanceFilter.bank => account.type != AccountType.cash,
  };

  /// Whether [movement] is of a kept account. A transfer is when either
  /// side is, since it moves money in or out of them.
  bool keepsMovement(Movement movement, List<Account> accounts) {
    if (this == BalanceFilter.both) return true;
    bool kept(int? id) => switch (accounts.byId(id)) {
      final account? => keeps(account),
      null => false,
    };
    return kept(movement.accountId) || kept(movement.toAccountId);
  }
}

/// The Home Balance (RF-17): accounts included in the Balance in
/// [currencyCode], narrowed by the quick menu's [filter].
Money homeBalance({
  required List<Account> accounts,
  required Map<int, int> balances,
  required String currencyCode,
  required BalanceFilter filter,
}) {
  return accounts
      .where(
        (a) =>
            a.includeInBalance &&
            a.currencyCode == currencyCode &&
            filter.keeps(a),
      )
      .fold(
        Money.zero(currencyCode),
        (sum, a) =>
            sum + Money(balances[a.id] ?? a.openingBalance, currencyCode),
      );
}
