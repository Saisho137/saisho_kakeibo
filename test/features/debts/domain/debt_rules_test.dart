import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';

import '../../../helpers/debt_fixtures.dart';

void main() {
  group('DebtRules', () {
    test('normalize cleans the name and the fields of the other type', () {
      final owed = DebtRules.normalize(
        debt(
          type: DebtType.owedToMe,
          name: '  loan   to ana ',
          dueDay: 5,
          dueDate: LocalDate(2026, 6, 1),
        ).copyWith(pillarId: 3),
      );
      expect(owed.name, 'Loan to ana');
      expect(owed.pillarId, isNull);
      expect(owed.dueDay, isNull);
      expect(owed.dueDate, LocalDate(2026, 6, 1));

      final mine = DebtRules.normalize(
        debt(dueDay: 5, dueDate: LocalDate(2026, 6, 1)),
      );
      expect(mine.dueDay, 5);
      expect(mine.dueDate, isNull);
    });

    test('validate checks every field', () {
      expect(DebtRules.validate(debt()), isEmpty);
      expect(
        DebtRules.validate(
          debt(
            name: ' ',
            initialPending: -1,
            pillarId: null,
            installment: 0,
            dueDay: 32,
          ),
        ),
        {
          DebtError.emptyName,
          DebtError.invalidPending,
          DebtError.missingPillar,
          DebtError.invalidInstallment,
          DebtError.invalidDueDay,
        },
      );
      expect(DebtRules.validate(debt(name: 'x' * 41)), {DebtError.nameTooLong});
      expect(
        DebtRules.validate(debt(type: DebtType.owedToMe, installment: 5)),
        isEmpty,
      );
    });

    test('each debt category works with its type of debt', () {
      expect(DebtRules.typeFor(CategoryRole.loanReceived), DebtType.iOwe);
      expect(DebtRules.typeFor(CategoryRole.debtPayment), DebtType.iOwe);
      expect(DebtRules.typeFor(CategoryRole.loanGiven), DebtType.owedToMe);
      expect(DebtRules.typeFor(CategoryRole.loanRepaid), DebtType.owedToMe);
      expect(DebtRules.typeFor(CategoryRole.custom), isNull);
      expect(DebtRules.createsDebt(CategoryRole.loanReceived), isTrue);
      expect(DebtRules.createsDebt(CategoryRole.loanGiven), isTrue);
      expect(DebtRules.createsDebt(CategoryRole.debtPayment), isFalse);
      expect(DebtRules.needsExistingDebt(CategoryRole.debtPayment), isTrue);
      expect(DebtRules.needsExistingDebt(CategoryRole.loanRepaid), isTrue);
      expect(DebtRules.needsExistingDebt(CategoryRole.loanGiven), isFalse);
    });
  });
}
