import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/features/categories/data/models/category_row_mapper.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  tearDown(() => db.close());

  Future<List<Category>> stored() async =>
      (await db.categoryDao.getAll()).map((r) => r.toEntity()).toList();

  group('CategoriesSeed', () {
    test('creates the four pillars in order', () async {
      final pillars = (await db.categoryDao.getPillars()).map(
        (r) => r.toEntity(),
      );

      expect(pillars.map((p) => p.name), [
        'Survival',
        'Leisure',
        'Culture',
        'Extras',
      ]);
      expect(pillars.map((p) => p.color).toSet(), hasLength(4));
    });

    test('creates the default categories of each type in order', () async {
      final categories = await stored();
      List<String> names(CategoryType type) => [
        for (final c in categories)
          if (c.type == type) c.name,
      ];

      expect(names(CategoryType.income), [
        'Salary',
        'Bonus',
        'Returns',
        'Extra income',
        'Loan received',
        'Loan repaid',
      ]);
      expect(names(CategoryType.expense), [
        'Eating out',
        'Car',
        'Clothes',
        'Interest & fees',
        'Debt payment',
        'Loan given',
        'Uncategorized',
      ]);
      expect(names(CategoryType.transfer), hasLength(9));
    });

    test('every core role exists once, with its defaults', () async {
      final categories = await stored();
      final core = categories.where((c) => c.isCore);

      expect(
        core.map((c) => c.role).toSet(),
        CategoryRole.values.where((r) => r.isCore).toSet(),
      );
      expect(core, hasLength(CategoryRole.values.length - 1));
      for (final c in core) {
        expect(c.type, c.role.type);
        expect(c.defaultName, c.name);
        expect(c.defaultIconKey, c.iconKey);
        expect(c.pillarId, isNull);
      }
    });

    test('custom expenses get their pillar', () async {
      final pillars = {
        for (final r in await db.categoryDao.getPillars()) r.id: r.name,
      };
      final expenses = {
        for (final c in await stored())
          if (c.hasPillar) c.name: pillars[c.pillarId],
      };

      expect(expenses, {
        'Eating out': 'Leisure',
        'Car': 'Survival',
        'Clothes': 'Leisure',
        'Interest & fees': 'Extras',
      });
    });

    test('icons are in the catalog and colors are unique per type', () async {
      final categories = await stored();

      for (final c in categories) {
        expect(IconCatalog.contains(c.iconKey), isTrue, reason: c.name);
      }
      for (final type in CategoryType.values) {
        final colors = [
          for (final c in categories)
            if (c.type == type) c.color,
        ];
        expect(colors.toSet(), hasLength(colors.length), reason: '$type');
      }
    });
  });
}
