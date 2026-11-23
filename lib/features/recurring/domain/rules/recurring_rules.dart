import 'dart:math';

import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

/// Rules of recurring templates (RF-06). A template must be able to
/// become a valid movement, so it shares the movement rules.
abstract final class RecurringRules {
  static const int minDueDay = 1;
  static const int maxDueDay = 31;

  /// Categories a template can use: any active one of its type, except the
  /// loans, which create debts and never repeat. Debt payment and Loan
  /// repaid pay or collect a debt (RF-09).
  static bool allows(CategoryRole role) =>
      role != CategoryRole.loanReceived && role != CategoryRole.loanGiven;

  /// Trims the note, drops what the type has no use for, and turns the
  /// reminder off without a due day.
  static RecurringTemplate normalize(RecurringTemplate template) {
    final isTransfer = template.type == MovementType.transfer;
    final note = template.note?.trim();
    return template.copyWith(
      toAccountId: isTransfer ? template.toAccountId : null,
      toAmount: isTransfer ? template.toAmount ?? template.amount : null,
      payeeId: isTransfer ? null : template.payeeId,
      note: note == null || note.isEmpty ? null : note,
      remind: template.remind && template.dueDay != null,
    );
  }

  static Set<MovementError> validate(
    RecurringTemplate template, {
    required Account? account,
    required Account? toAccount,
    required Category? category,
    bool hasPayee = false,
  }) => MovementRules.validate(
    MovementRules.normalize(
      template.toMovement(template.createdOn).copyWith(isPending: false),
      account: account,
      toAccount: toAccount,
    ),
    account: account,
    toAccount: toAccount,
    category: category,
    hasPayee: hasPayee,
  );

  static bool isValidDueDay(int? day) =>
      day == null || (day >= minDueDay && day <= maxDueDay);

  /// Date of the movement [template] creates in [period]: the period start,
  /// except an income with a due day, which falls on the first such day of
  /// the period (the month's last day when it is shorter).
  static LocalDate dateIn(RecurringTemplate template, Period period) {
    final day = template.dueDay;
    if (template.type != MovementType.income || day == null) {
      return period.start;
    }
    LocalDate inMonth(LocalDate first) =>
        LocalDate(first.year, first.month, min(day, first.daysInMonth));
    final start = period.start;
    var date = inMonth(LocalDate(start.year, start.month, 1));
    if (date.isBefore(start)) {
      date = inMonth(LocalDate(start.year, start.month + 1, 1));
    }
    return period.contains(date) ? date : start;
  }
}
