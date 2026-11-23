import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/services/payee_stats.dart';

import '../../../helpers/movement_fixtures.dart';

void main() {
  group('PayeeStats', () {
    test('adds the expenses and charts them oldest first', () {
      final stats = PayeeStats.of([
        movement(id: 2, amount: 12000, date: LocalDate(2026, 3, 5)),
        movement(id: 1, amount: 10000, date: LocalDate(2026, 3, 1)),
        movement(
          id: 3,
          amount: 11000,
          date: LocalDate(2026, 3, 5),
          categoryId: 7,
        ),
        movement(
          type: MovementType.income,
          amount: 500,
          date: LocalDate(2026, 3, 1),
        ),
        movement(type: MovementType.transfer, toAccountId: 2),
      ]);

      expect(stats.count, 4);
      expect(stats.expense, 33000);
      expect(stats.income, 500);
      expect(stats.net, -32500);
      expect(stats.lastCategoryId, 7);
      expect(stats.prices.map((p) => p.amount), [10000, 12000, 11000]);
      expect(stats.averagePrice, 11000);
      expect(stats.lastPrice, 11000);
    });

    test('an entity that only pays me charts its incomes', () {
      final stats = PayeeStats.of([
        movement(type: MovementType.income, amount: 5000000),
        movement(type: MovementType.income, amount: 9, isPending: true),
      ]);
      expect(stats.count, 1);
      expect(stats.net, 5000000);
      expect(stats.prices.single.amount, 5000000);
    });

    test('is empty without movements', () {
      expect(PayeeStats.of(const []).count, 0);
      expect(PayeeStats.empty.averagePrice, isNull);
      expect(PayeeStats.empty.lastPrice, isNull);
      expect(PayeeStats.empty.lastCategoryId, isNull);
    });
  });
}
