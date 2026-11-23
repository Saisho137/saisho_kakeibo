import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';

/// A field of the debt form that does not pass the rules.
enum DebtError {
  emptyName,
  nameTooLong,
  missingPayee,
  invalidPending,
  missingPillar,
  invalidInstallment,
  invalidDueDay,
}

/// Rules of a debt (RF-09).
abstract final class DebtRules {
  static const int maxNameLength = 30;
  static const int minDueDay = 1;
  static const int maxDueDay = 31;

  /// Cleans the name and drops the fields of the other type: a debt owed
  /// to me has no pillar nor monthly day; one I owe has no single date.
  static Debt normalize(Debt debt) => debt.copyWith(
    name: TextNormalizer.display(debt.name),
    pillarId: debt.iOwe ? debt.pillarId : null,
    dueDay: debt.iOwe ? debt.dueDay : null,
    dueDate: debt.iOwe ? null : debt.dueDate,
  );

  /// [hasPayee] says whether a payee was picked or typed.
  static Set<DebtError> validate(Debt debt, {required bool hasPayee}) {
    final errors = <DebtError>{};
    final name = debt.name.trim();
    if (name.isEmpty) errors.add(DebtError.emptyName);
    if (name.length > maxNameLength) errors.add(DebtError.nameTooLong);
    if (!hasPayee) errors.add(DebtError.missingPayee);
    if (debt.initialPending < 0) errors.add(DebtError.invalidPending);
    if (debt.iOwe && debt.pillarId == null) errors.add(DebtError.missingPillar);
    if (debt.installment case final i? when i <= 0) {
      errors.add(DebtError.invalidInstallment);
    }
    if (debt.dueDay case final d? when d < minDueDay || d > maxDueDay) {
      errors.add(DebtError.invalidDueDay);
    }
    return errors;
  }
}
