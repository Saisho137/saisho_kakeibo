import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  final cop = account(id: 1);
  final usd = account(id: 2, currencyCode: 'USD');
  final food = category(id: 10, name: 'Food');
  final rent = category(id: 11, name: 'Rent', sortOrder: 1);
  final movies = category(id: 12, name: 'Movies', pillarId: leisure.id);
  final uncategorized = category(
    id: 13,
    role: CategoryRole.uncategorized,
    name: 'Uncategorized',
  );
  final orphan = category(id: 14, pillarId: 99);
  final categories = [food, rent, movies, uncategorized, orphan];

  DonutData donut(List<Movement> movements) => DonutData.of(
    movements: movements,
    accounts: [cop, usd],
    categories: categories,
    pillars: const [leisure, survival],
    currencyCode: 'COP',
  );

  group('DonutData', () {
    test('is empty without expenses in the currency', () {
      final data = donut([
        movement(type: MovementType.income, categoryId: 10),
        movement(type: MovementType.transfer, categoryId: 10, toAccountId: 2),
        movement(accountId: 2, categoryId: 10),
        movement(categoryId: 99),
        movement(),
      ]);

      expect(data.isEmpty, isTrue);
      expect(data.pillars, isEmpty);
    });

    test('groups by pillar in order, No pillar last', () {
      final data = donut([
        movement(categoryId: 13, amount: 100),
        movement(categoryId: 12, amount: 300),
        movement(categoryId: 10, amount: 400),
        movement(categoryId: 10, amount: 100),
        movement(categoryId: 11, amount: 100),
      ]);

      expect(data.total, 1000);
      expect(data.pillars.map((p) => p.pillar), [survival, leisure, null]);
      expect(data.pillars.map((p) => p.amount), [600, 300, 100]);
      expect(data.pillars.map((p) => p.share), [0.6, 0.3, 0.1]);
      final survivalCategories = data.pillars.first.categories;
      expect(survivalCategories.map((c) => c.category), [food, rent]);
      expect(survivalCategories.map((c) => c.amount), [500, 100]);
      expect(survivalCategories.first.share, 0.5);
    });

    test('a pillar without expenses is hidden', () {
      final data = donut([movement(categoryId: 10)]);
      expect(data.pillars.single.pillar, survival);
    });

    test('equal amounts follow the category order', () {
      final data = donut([
        movement(categoryId: 11, amount: 100),
        movement(categoryId: 10, amount: 100),
      ]);
      expect(data.pillars.single.categories.map((c) => c.category), [
        food,
        rent,
      ]);
    });

    test('a category of a missing pillar goes to No pillar', () {
      final data = donut([movement(categoryId: 14)]);
      expect(data.pillars.single.pillar, isNull);
    });
  });
}
