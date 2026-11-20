import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// What makes a movement invalid.
enum MovementError {
  invalidAmount,
  missingAccount,
  missingCategory,
  sameAccounts,

  /// Only incomes and expenses have a payee.
  unexpectedPayee,
  noteTooLong,
}

/// Rules of a movement (RT-04, RT-05).
abstract final class MovementRules {
  static const int maxNoteLength = 200;

  /// Trims the note, drops it if blank, and clears the fields that do not
  /// apply to the type. A transfer between accounts of the same currency
  /// receives what it sends.
  static Movement normalize(
    Movement movement, {
    Account? account,
    Account? toAccount,
  }) {
    final note = movement.note?.trim() ?? '';
    final isTransfer = movement.type == MovementType.transfer;
    final sameCurrency =
        account != null &&
        toAccount != null &&
        account.currencyCode == toAccount.currencyCode;
    return movement.copyWith(
      note: note.isEmpty ? null : note,
      toAccountId: isTransfer ? movement.toAccountId : null,
      toAmount: isTransfer
          ? (sameCurrency ? movement.amount : movement.toAmount)
          : null,
      categoryId: movement.type == MovementType.adjustment
          ? null
          : movement.categoryId,
      payeeId: _hasPayee(movement.type) ? movement.payeeId : null,
      startsPeriod:
          movement.type == MovementType.income && movement.startsPeriod,
    );
  }

  /// Errors of a normalized [movement], given its accounts and category.
  static Set<MovementError> validate(
    Movement movement, {
    required Account? account,
    Account? toAccount,
    Category? category,
    bool hasPayee = false,
  }) {
    final errors = <MovementError>{};
    final type = movement.type;
    if (type == MovementType.adjustment
        ? movement.amount == 0
        : movement.amount <= 0) {
      errors.add(MovementError.invalidAmount);
    }
    if (account == null) errors.add(MovementError.missingAccount);
    if (type == MovementType.transfer) {
      if (toAccount == null) {
        errors.add(MovementError.missingAccount);
      } else if (toAccount.id == account?.id) {
        errors.add(MovementError.sameAccounts);
      }
      if ((movement.toAmount ?? 0) <= 0) {
        errors.add(MovementError.invalidAmount);
      }
    }
    if (type != MovementType.adjustment &&
        (category == null || category.type != _categoryType(type))) {
      errors.add(MovementError.missingCategory);
    }
    if (hasPayee && !_hasPayee(type)) errors.add(MovementError.unexpectedPayee);
    if ((movement.note?.length ?? 0) > maxNoteLength) {
      errors.add(MovementError.noteTooLong);
    }
    return errors;
  }

  static bool _hasPayee(MovementType type) =>
      type == MovementType.income || type == MovementType.expense;

  static CategoryType? _categoryType(MovementType type) => switch (type) {
    MovementType.income => CategoryType.income,
    MovementType.expense => CategoryType.expense,
    MovementType.transfer => CategoryType.transfer,
    MovementType.adjustment => null,
  };
}
