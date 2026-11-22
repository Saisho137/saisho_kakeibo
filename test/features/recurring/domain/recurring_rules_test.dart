import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  final bank = account(id: 1);
  final cash = account(id: 2);
  final food = category(id: 10);
  final savings = category(id: 11, type: CategoryType.transfer);

  group('RecurringRules', () {
    test('normalize keeps only what the type uses', () {
      final expense = RecurringRules.normalize(
        template(
          toAccountId: 2,
          toAmount: 5,
          payeeId: 3,
          remind: true,
        ).copyWith(note: '  '),
      );
      expect(expense.toAccountId, isNull);
      expect(expense.toAmount, isNull);
      expect(expense.payeeId, 3);
      expect(expense.note, isNull);
      expect(expense.remind, isFalse);

      final transfer = RecurringRules.normalize(
        template(
          type: MovementType.transfer,
          toAccountId: 2,
          payeeId: 3,
          dueDay: 5,
          remind: true,
        ).copyWith(note: ' rent '),
      );
      expect(transfer.toAmount, 1000);
      expect(transfer.payeeId, isNull);
      expect(transfer.note, 'rent');
      expect(transfer.remind, isTrue);
    });

    test('validate uses the movement rules', () {
      expect(
        RecurringRules.validate(
          template(),
          account: bank,
          toAccount: null,
          category: food,
        ),
        isEmpty,
      );
      expect(
        RecurringRules.validate(
          template(amount: 0, categoryId: 99),
          account: null,
          toAccount: null,
          category: null,
        ),
        containsAll([
          MovementError.invalidAmount,
          MovementError.missingAccount,
          MovementError.missingCategory,
        ]),
      );
      expect(
        RecurringRules.validate(
          template(type: MovementType.transfer, categoryId: 11, toAccountId: 1),
          account: bank,
          toAccount: bank,
          category: savings,
        ),
        contains(MovementError.sameAccounts),
      );
      expect(
        RecurringRules.validate(
          template(type: MovementType.transfer, categoryId: 11),
          account: bank,
          toAccount: cash,
          category: savings,
        ),
        isEmpty,
      );
    });

    test('due days go from 1 to 31', () {
      expect(RecurringRules.isValidDueDay(null), isTrue);
      expect(RecurringRules.isValidDueDay(1), isTrue);
      expect(RecurringRules.isValidDueDay(31), isTrue);
      expect(RecurringRules.isValidDueDay(0), isFalse);
      expect(RecurringRules.isValidDueDay(32), isFalse);
    });

    group('dateIn', () {
      final period = Period(
        start: LocalDate(2026, 1, 25),
        end: LocalDate(2026, 2, 24),
      );

      test('expenses and transfers fall on the period start', () {
        expect(
          RecurringRules.dateIn(template(dueDay: 5), period),
          period.start,
        );
        expect(
          RecurringRules.dateIn(
            template(type: MovementType.transfer, dueDay: 5),
            period,
          ),
          period.start,
        );
      });

      test('an income falls on its due day within the period', () {
        LocalDate income(int? day, Period p) => RecurringRules.dateIn(
          template(type: MovementType.income, dueDay: day),
          p,
        );
        expect(income(28, period), LocalDate(2026, 1, 28));
        expect(income(5, period), LocalDate(2026, 2, 5));
        expect(income(null, period), period.start);
        // February has no 30th: its last day.
        expect(
          income(
            30,
            Period(start: LocalDate(2026, 2, 1), end: LocalDate(2026, 2, 28)),
          ),
          LocalDate(2026, 2, 28),
        );
        // A short period without that day keeps the start.
        expect(
          income(
            20,
            Period(start: LocalDate(2026, 1, 25), end: LocalDate(2026, 2, 10)),
          ),
          LocalDate(2026, 1, 25),
        );
        // The open period takes the next such day.
        expect(
          income(20, Period(start: LocalDate(2026, 1, 25))),
          LocalDate(2026, 2, 20),
        );
      });
    });

    test('a template becomes a pending movement', () {
      final m = template(payeeId: 4).toMovement(LocalDate(2026, 3, 5));
      expect(m.isPending, isTrue);
      expect(m.recurringTemplateId, 1);
      expect(m.payeeId, 4);
      expect(m.date, LocalDate(2026, 3, 5));
    });
  });
}
