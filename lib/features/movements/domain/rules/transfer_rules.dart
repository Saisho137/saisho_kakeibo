import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';

/// Rules of transfers between my accounts (RF-13).
abstract final class TransferRules {
  /// Core transfer category suggested by the account types, in the order
  /// of the vault table: the first rule that applies wins.
  static CategoryRole suggestedRole(Account from, Account to) {
    final f = from.type;
    final t = to.type;
    if (t == AccountType.pocket) return CategoryRole.savings;
    if (f == AccountType.pocket) return CategoryRole.savingsWithdrawal;
    if (t == AccountType.investment) return CategoryRole.investing;
    if (f == AccountType.investment) return CategoryRole.investmentWithdrawal;
    if (f == AccountType.bank && t == AccountType.creditCard) {
      return CategoryRole.cardPayment;
    }
    if (f == AccountType.creditCard &&
        (t == AccountType.cash || t == AccountType.bank)) {
      return CategoryRole.cashAdvance;
    }
    if (f == AccountType.bank && t == AccountType.cash) {
      return CategoryRole.cashWithdrawal;
    }
    if (from.currencyCode != to.currencyCode) {
      return CategoryRole.currencyExchange;
    }
    return CategoryRole.betweenAccounts;
  }

  /// Whether the money stays inside one account: between it and its own
  /// pockets, or between two of its pockets. Such a transfer is recorded
  /// for the Free breakdown but adds nothing to the Transfers total.
  static bool isInternal(Account from, Account to) {
    final fromRoot = from.parentAccountId ?? from.id;
    final toRoot = to.parentAccountId ?? to.id;
    return from.id != to.id && fromRoot == toRoot;
  }
}
