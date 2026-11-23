import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

Movement linked(
  MovementType type,
  int amount, {
  int debtId = 1,
  bool isPending = false,
}) => movement(
  type: type,
  amount: amount,
  isPending: isPending,
).copyWith(debtId: debtId);

void main() {
  group('DebtStatus', () {
    test('a debt I owe goes down with its payments', () {
      final status = DebtStatus.of(debt(), [
        linked(MovementType.expense, 200000),
        linked(MovementType.expense, 50000, isPending: true),
        // The loan received that created it is already in the initial.
        linked(MovementType.income, 1000000),
        linked(MovementType.expense, 999, debtId: 2),
      ]);

      expect(status.pending, 750000);
      expect(status.paid, 250000);
      expect(status.payments, hasLength(2));
      expect(status.progress, 0.25);
      expect(status.isPaidOff, isFalse);
    });

    test('a debt owed to me grows with loans and goes down when paid', () {
      final status = DebtStatus.of(
        debt(type: DebtType.owedToMe, initialPending: 0),
        [
          linked(MovementType.expense, 300000),
          linked(MovementType.expense, 200000),
          linked(MovementType.income, 100000),
          linked(MovementType.income, 50000, isPending: true),
        ],
      );

      expect(status.pending, 400000);
      expect(status.paid, 100000);
      expect(status.payments, hasLength(3));
    });

    test('paying more than pending turns it negative and paid off', () {
      final status = DebtStatus.of(debt(initialPending: 100), [
        linked(MovementType.expense, 150),
      ]);
      expect(status.pending, -50);
      expect(status.isPaidOff, isTrue);
      expect(status.progress, 1);
    });

    test('a correction moves the pending amount, not the payments', () {
      final d = debt(adjustment: -100000);
      final status = DebtStatus.of(d, [linked(MovementType.expense, 200000)]);
      expect(status.pending, 700000);
      expect(status.adjustmentFor(d, 650000), -150000);
      expect(
        DebtStatus.of(d.copyWith(adjustment: status.adjustmentFor(d, 650000)), [
          linked(MovementType.expense, 200000),
        ]).pending,
        650000,
      );
    });

    test('nothing pending nor paid counts as settled', () {
      final status = DebtStatus.of(debt(initialPending: 0), const []);
      expect(status.isPaidOff, isTrue);
      expect(status.progress, 1);
      expect(debt().iOwe, isTrue);
    });
  });
}
