import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
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

    test("debt payments are a section of their debt's pillar", () {
      final payment = category(
        id: 15,
        name: 'Debt payment',
        role: CategoryRole.debtPayment,
      );
      final mortgage = debt(pillarId: leisure.id);
      final data = DonutData.of(
        movements: [
          movement(categoryId: 15, amount: 300).copyWith(debtId: 1),
          movement(categoryId: 15, amount: 200).copyWith(debtId: 1),
          movement(categoryId: 15, amount: 100).copyWith(debtId: 9),
        ],
        accounts: [cop],
        categories: [payment],
        pillars: const [leisure, survival],
        currencyCode: 'COP',
        debts: [mortgage],
      );

      expect(data.pillars.map((p) => p.pillar), [leisure, null]);
      final section = data.pillars.first.categories.single;
      expect(section.debt, mortgage);
      expect(section.amount, 500);
      expect(
        (section.name, section.iconKey, section.color),
        (mortgage.name, mortgage.iconKey, mortgage.color),
      );
      final unknown = data.pillars.last.categories.single;
      expect(unknown.debt, isNull);
      expect(unknown.name, 'Debt payment');
    });
  });
}
