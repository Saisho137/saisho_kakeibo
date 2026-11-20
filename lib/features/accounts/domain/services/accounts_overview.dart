import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';

/// An account in the Accounts list with its computed amounts.
@immutable
final class AccountLine {
  const new({
    required this.account,
    required this.balance,
    this.pockets = const [],
    this.free,
    this.available,
  });

  final Account account;

  /// Own balance plus every pocket's balance.
  final Money balance;

  /// Visible pockets, in order.
  final List<AccountLine> pockets;

  /// Money outside the pockets; set when the account has pockets.
  final Money? free;

  /// Credit limit left (limit − debt); set for credit cards.
  final Money? available;
}

/// What the Accounts screen shows for one currency (RF-03, RF-04).
@immutable
final class AccountsOverview {
  const new({
    required this.totalBalance,
    required this.balance,
    required this.groups,
  });

  /// Builds the overview of [currencyCode]. [balances] holds each account's
  /// own balance by id; missing ids count as their opening balance.
  /// Archived accounts always count in the totals but are listed only with
  /// [showArchived].
  factory build({
    required List<Account> accounts,
    required Map<int, int> balances,
    required String currencyCode,
    bool showArchived = false,
  }) {
    final inCurrency = accounts
        .where((a) => a.currencyCode == currencyCode)
        .toList();
    Money own(Account a) =>
        Money(balances[a.id] ?? a.openingBalance, currencyCode);
    bool visible(Account a) => showArchived || !a.isArchived;
    List<Account> sorted(Iterable<Account> list) => list.toList()
      ..sort((a, b) {
        final byOrder = a.sortOrder.compareTo(b.sortOrder);
        return byOrder != 0 ? byOrder : a.id.compareTo(b.id);
      });

    var total = Money.zero(currencyCode);
    var balance = Money.zero(currencyCode);
    for (final account in inCurrency) {
      total += own(account);
      if (account.includeInBalance) balance += own(account);
    }

    AccountLine line(Account account) {
      final pockets = inCurrency.pocketsOf(account.id).toList();
      final pocketsTotal = pockets.fold(
        Money.zero(currencyCode),
        (sum, p) => sum + own(p),
      );
      final balance = own(account) + pocketsTotal;
      final limit = account.creditLimit;
      return AccountLine(
        account: account,
        balance: balance,
        pockets: [
          for (final pocket in sorted(pockets.where(visible)))
            AccountLine(account: pocket, balance: own(pocket)),
        ],
        free: pockets.isEmpty ? null : own(account),
        available: limit == null ? null : Money(limit, currencyCode) + balance,
      );
    }

    final parents = sorted(inCurrency.where((a) => !a.isPocket && visible(a)));
    return AccountsOverview(
      totalBalance: total,
      balance: balance,
      groups: {
        for (final group in AccountGroup.values)
          if (parents.where((a) => a.type.group == group) case final list
              when list.isNotEmpty)
            group: [for (final account in list) line(account)],
      },
    );
  }

  /// Sum of every account of the currency, pockets and archived included.
  final Money totalBalance;

  /// Sum of the accounts included in the Balance.
  final Money balance;

  /// Visible accounts by group, in [AccountGroup] order. Empty groups are
  /// left out.
  final Map<AccountGroup, List<AccountLine>> groups;

  bool get isEmpty => groups.isEmpty;
}
