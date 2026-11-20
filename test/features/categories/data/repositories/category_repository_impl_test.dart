import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/category_dao.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

import '../../../../helpers/category_fixtures.dart';

class _MockCategoryDao extends Mock implements CategoryDao;

void main() {
  late AppDatabase db;
  late CategoryRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = CategoryRepositoryImpl(db.categoryDao);
  });

  tearDown(() => db.close());

  Future<List<Category>> all() async =>
      (await repository.getCategories() as Ok<List<Category>>).value;

  Future<List<Pillar>> allPillars() async =>
      (await repository.getPillars() as Ok<List<Pillar>>).value;

  group('CategoryRepositoryImpl', () {
    test('creates a category with every field', () async {
      final pillar = (await allPillars()).first;
      final created = category(
        id: 0,
        name: 'Groceries',
        pillarId: pillar.id,
        sortOrder: 9,
      );

      final id = (await repository.create(created) as Ok<int>).value;

      expect(
        (await all()).firstWhere((c) => c.id == id),
        created.copyWith(id: id),
      );
    });

    test('saves, reorders and streams categories', () async {
      final income = [
        for (final c in await all())
          if (c.type == CategoryType.income) c,
      ];
      await repository.save(income.first.copyWith(name: 'Paycheck'));
      await repository.reorder([for (final c in income.reversed) c.id]);

      final streamed = await repository.watchCategories().first;
      final names = [
        for (final c in streamed)
          if (c.type == CategoryType.income) c.name,
      ];

      expect(names.first, 'Loan repaid');
      expect(names.last, 'Paycheck');
    });

    test('deletes a category without movements', () async {
      final car = (await all()).firstWhere((c) => c.name == 'Car');

      expect((await repository.countMovements(car.id) as Ok<int>).value, 0);
      await repository.delete(car.id);

      expect((await all()).where((c) => c.name == 'Car'), isEmpty);
    });

    test('saves and streams pillars', () async {
      final first = (await allPillars()).first;

      await repository.savePillar(first.copyWith(name: 'Needs', color: 1));

      expect(
        (await repository.watchPillars().first).first,
        first.copyWith(name: 'Needs', color: 1),
      );
    });

    test('translates database errors into failures', () async {
      final dao = _MockCategoryDao();
      when(dao.getAll).thenThrow(Exception('disk'));
      when(dao.getPillars).thenThrow(Exception('disk'));

      final broken = CategoryRepositoryImpl(dao);

      expect(
        (await broken.getCategories() as Err).failure,
        isA<DatabaseFailure>(),
      );
      expect(
        (await broken.getPillars() as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });
}
