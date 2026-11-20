import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/pillar_rules.dart';

import '../../../../helpers/category_fixtures.dart';

void main() {
  group('CategoryRole', () {
    test('knows its type and whether it is core', () {
      expect(CategoryRole.custom.isCore, isFalse);
      expect(CategoryRole.custom.type, isNull);
      expect(CategoryRole.salary.type, CategoryType.income);
      expect(CategoryRole.uncategorized.type, CategoryType.expense);
      expect(CategoryRole.betweenAccounts.type, CategoryType.transfer);
      expect(CategoryRole.betweenAccounts.isCore, isTrue);
    });
  });

  group('Category.hasPillar', () {
    test('only custom expenses take a pillar from themselves', () {
      expect(category(id: 1).hasPillar, isTrue);
      expect(
        category(id: 2, role: CategoryRole.debtPayment).hasPillar,
        isFalse,
      );
      expect(category(id: 3, type: CategoryType.income).hasPillar, isFalse);
    });
  });

  group('CategoriesX', () {
    final stored = [
      category(id: 1, color: 1, sortOrder: 4),
      category(id: 2, color: 2, isArchived: true),
      category(id: 3, color: 3, type: CategoryType.income),
      category(id: 4, role: CategoryRole.uncategorized),
    ];

    test('finds by id and role', () {
      expect(stored.byId(3)?.id, 3);
      expect(stored.byId(null), isNull);
      expect(stored.byRole(CategoryRole.uncategorized)?.id, 4);
      expect(stored.byRole(CategoryRole.custom), isNull);
    });

    test('lists active colors of a type and the next order', () {
      expect(stored.colorsInUse(CategoryType.expense, exceptId: 4), [1]);
      expect(stored.nextSortOrder(CategoryType.expense), 5);
      expect(stored.nextSortOrder(CategoryType.transfer), 0);
    });
  });

  group('CategoryRules', () {
    test('normalizes the name and drops pillars that do not apply', () {
      final income = CategoryRules.normalize(
        category(
          id: 1,
          type: CategoryType.income,
        ).copyWith(name: '  gifts   received ', pillarId: 1),
      );

      expect(income.name, 'Gifts received');
      expect(income.pillarId, isNull);
    });

    test('accepts a valid custom expense', () {
      expect(
        CategoryRules.validate(
          category(id: 0, name: 'Groceries'),
          categories: [category(id: 1, name: 'Car')],
          pillars: pillars,
        ),
        isEmpty,
      );
    });

    test('rejects empty, long and repeated names in the same type', () {
      final stored = [
        category(id: 1, name: 'Café'),
        category(id: 2, name: 'Gifts', type: CategoryType.income),
      ];
      Set<CategoryError> errors(String name) => CategoryRules.validate(
        category(id: 0, name: name),
        categories: stored,
        pillars: pillars,
      );

      expect(errors(' '), {CategoryError.emptyName});
      expect(errors('x' * 31), {CategoryError.nameTooLong});
      expect(errors('ca fe'), {CategoryError.duplicateName});
      expect(errors('Gifts'), isEmpty);
    });

    test('a category keeps its own name', () {
      final car = category(id: 1, name: 'Car');

      expect(
        CategoryRules.validate(car, categories: [car], pillars: pillars),
        isEmpty,
      );
    });

    test('a custom expense needs a known pillar', () {
      expect(
        CategoryRules.validate(
          category(id: 0, pillarId: 99),
          categories: const [],
          pillars: pillars,
        ),
        {CategoryError.missingPillar},
      );
    });

    test('default delete targets follow the type', () {
      expect(
        CategoryRules.defaultTargetRole(CategoryType.expense),
        CategoryRole.uncategorized,
      );
      expect(
        CategoryRules.defaultTargetRole(CategoryType.transfer),
        CategoryRole.betweenAccounts,
      );
      expect(CategoryRules.defaultTargetRole(CategoryType.income), isNull);
    });

    test('only active categories of the same type receive movements', () {
      final deleted = category(id: 1);

      expect(
        CategoryRules.canReceive(category(id: 2), deleted: deleted),
        isTrue,
      );
      expect(CategoryRules.canReceive(deleted, deleted: deleted), isFalse);
      expect(
        CategoryRules.canReceive(
          category(id: 3, isArchived: true),
          deleted: deleted,
        ),
        isFalse,
      );
      expect(
        CategoryRules.canReceive(
          category(id: 4, type: CategoryType.income),
          deleted: deleted,
        ),
        isFalse,
      );
    });
  });

  group('PillarRules', () {
    test('accepts a renamed pillar and normalizes it', () {
      final renamed = PillarRules.normalize(
        survival.copyWith(name: '  needs '),
      );

      expect(renamed.name, 'Needs');
      expect(PillarRules.validate(renamed, pillars: pillars), isEmpty);
    });

    test('rejects empty, long and repeated names and colors', () {
      Set<PillarError> errors(String name, int color) => PillarRules.validate(
        survival.copyWith(name: name, color: color),
        pillars: pillars,
      );

      expect(errors('', survival.color), {PillarError.emptyName});
      expect(errors('x' * 21, survival.color), {PillarError.nameTooLong});
      expect(errors('leisure', leisure.color), {
        PillarError.duplicateName,
        PillarError.duplicateColor,
      });
    });
  });
}
