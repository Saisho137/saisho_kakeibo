import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

/// A field of the account form that does not pass the rules.
enum AccountError {
  emptyName,
  nameTooLong,

  /// The amount text could not be read with the currency format. Forms set
  /// it; [AccountRules.validate] never does.
  invalidOpeningBalance,
  missingParent,
  invalidParent,
  invalidCreditLimit,
  invalidPaymentDay,
}

/// Rules of an account (RF-04, RF-15).
abstract final class AccountRules {
  static const int maxNameLength = 40;
  static const int minPaymentDay = 1;
  static const int maxPaymentDay = 31;

  /// Clears the fields that do not apply to the account's type, and copies
  /// currency and Balance inclusion from a pocket's [parent].
  static Account normalize(Account account, {Account? parent}) {
    final type = account.type;
    var result = account.copyWith(
      name: TextNormalizer.display(account.name),
      isMain: type == AccountType.bank && account.isMain,
      parentAccountId: type == AccountType.pocket
          ? account.parentAccountId
          : null,
      creditLimit: type == AccountType.creditCard ? account.creditLimit : null,
      paymentDay: type == AccountType.creditCard ? account.paymentDay : null,
    );
    if (type == AccountType.pocket && parent != null) {
      result = result.copyWith(
        currencyCode: parent.currencyCode,
        includeInBalance: parent.includeInBalance,
      );
    }
    return result;
  }

  /// Errors of a normalized [account]. A pocket's [parent] must be a bank
  /// account other than the pocket itself, and active unless
  /// [parentMayBeArchived] (a pocket edited under its archived parent).
  static Set<AccountError> validate(
    Account account, {
    Account? parent,
    bool parentMayBeArchived = false,
  }) {
    final errors = <AccountError>{};
    final name = account.name.trim();
    if (name.isEmpty) errors.add(AccountError.emptyName);
    if (name.length > maxNameLength) errors.add(AccountError.nameTooLong);
    if (account.isPocket) {
      if (account.parentAccountId == null) {
        errors.add(AccountError.missingParent);
      } else if (!canBeParent(
        parent,
        of: account,
        mayBeArchived: parentMayBeArchived,
      )) {
        errors.add(AccountError.invalidParent);
      }
    }
    if (account.type == AccountType.creditCard) {
      final limit = account.creditLimit;
      if (limit == null || limit <= 0) {
        errors.add(AccountError.invalidCreditLimit);
      }
      final day = account.paymentDay;
      if (day == null || day < minPaymentDay || day > maxPaymentDay) {
        errors.add(AccountError.invalidPaymentDay);
      }
    }
    return errors;
  }

  /// Whether [candidate] can hold the pocket [of]: only active bank
  /// accounts have pockets.
  static bool canBeParent(
    Account? candidate, {
    required Account of,
    bool mayBeArchived = false,
  }) =>
      candidate != null &&
      candidate.type == AccountType.bank &&
      (mayBeArchived || !candidate.isArchived) &&
      candidate.id != of.id;
}
