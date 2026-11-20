import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

extension AccountsX on Iterable<Account> {
  Account? byId(int? id) =>
      id == null ? null : where((a) => a.id == id).firstOrNull;

  Iterable<Account> pocketsOf(int parentId) =>
      where((a) => a.isPocket && a.parentAccountId == parentId);

  /// Accounts ordered in the same list as [account]: pockets among their
  /// siblings, other accounts inside their group.
  Iterable<Account> sameListAs(Account account) => where(
    (a) => account.isPocket
        ? a.isPocket && a.parentAccountId == account.parentAccountId
        : !a.isPocket && a.type.group == account.type.group,
  );

  /// The [Account.sortOrder] that puts [account] last in its list.
  int nextSortOrder(Account account) =>
      sameListAs(account)
          .fold(-1, (max, a) => a.sortOrder > max ? a.sortOrder : max) +
      1;
}
