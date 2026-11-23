import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
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
      expect(DebtRules.validate(debt(), hasPayee: true), isEmpty);
      expect(
        DebtRules.validate(
          debt(
            name: ' ',
            initialPending: -1,
            pillarId: null,
            installment: 0,
            dueDay: 32,
          ),
          hasPayee: false,
        ),
        {
          DebtError.emptyName,
          DebtError.missingPayee,
          DebtError.invalidPending,
          DebtError.missingPillar,
          DebtError.invalidInstallment,
          DebtError.invalidDueDay,
        },
      );
      expect(DebtRules.validate(debt(name: 'x' * 31), hasPayee: true), {
        DebtError.nameTooLong,
      });
      expect(
        DebtRules.validate(
          debt(type: DebtType.owedToMe, installment: 5),
          hasPayee: true,
        ),
        isEmpty,
      );
    });
  });
}
