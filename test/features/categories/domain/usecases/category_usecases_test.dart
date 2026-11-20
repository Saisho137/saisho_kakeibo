import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/count_category_movements.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/create_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/delete_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_pillars.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/reorder_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/set_category_archived.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';

import '../../../../helpers/category_fixtures.dart';

class _MockCategoryRepository extends Mock implements CategoryRepository;

void main() {
  late _MockCategoryRepository repository;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final car = category(id: 1, name: 'Car');
  final clothes = category(id: 2, name: 'Clothes', sortOrder: 1);
  final uncategorized = category(
    id: 3,
    name: 'Uncategorized',
    role: CategoryRole.uncategorized,
    sortOrder: 2,
  );
  final salary = category(
    id: 4,
    name: 'Salary',
    type: CategoryType.income,
    role: CategoryRole.salary,
  );
  final stored = [car, clothes, uncategorized, salary];

  Matcher isValidationError() => isA<Err<dynamic>>().having(
    (e) => e.failure,
    'failure',
    isA<ValidationFailure>(),
  );

  setUpAll(() {
    registerFallbackValue(car);
    registerFallbackValue(survival);
  });

  setUp(() {
    repository = _MockCategoryRepository();
    when(() => repository.getCategories()).thenAnswer((_) async => Ok(stored));
    when(() => repository.getPillars())
        .thenAnswer((_) async => const Ok(pillars));
    when(() => repository.create(any())).thenAnswer((_) async => const Ok(9));
    when(() => repository.save(any())).thenAnswer((_) async => const Ok(null));
    when(() => repository.savePillar(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.reorder(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.countMovements(any()))
        .thenAnswer((_) async => const Ok(0));
    when(() => repository.delete(any(), reassignTo: any(named: 'reassignTo')))
        .thenAnswer((_) async => const Ok(null));
  });

  group('reads', () {
    test('delegate to the repository', () async {
      when(() => repository.watchCategories())
          .thenAnswer((_) => Stream.value(stored));
      when(() => repository.watchPillars())
          .thenAnswer((_) => Stream.value(pillars));

      expect(await WatchCategories(repository)(const NoParams()).first, stored);
      expect(await WatchPillars(repository)(const NoParams()).first, pillars);
      expect(
        (await GetCategories(repository)(const NoParams()) as Ok).value,
        stored,
      );
      expect(
        (await GetPillars(repository)(const NoParams()) as Ok).value,
        pillars,
      );
      expect((await CountCategoryMovements(repository)(1) as Ok).value, 0);
      await ReorderCategories(repository)([2, 1]);
      verify(() => repository.reorder([2, 1])).called(1);
    });
  });

  group('CreateCategory', () {
    test('creates a normalized custom category last in its type', () async {
      final result = await CreateCategory(repository)(
        category(
          id: 0,
          name: ' groceries ',
        ).copyWith(role: CategoryRole.salary, isArchived: true),
      );

      expect((result as Ok<int>).value, 9);
      final created =
          verify(() => repository.create(captureAny())).captured.single
              as Category;
      expect(created.name, 'Groceries');
      expect(created.role, CategoryRole.custom);
      expect(created.isArchived, isFalse);
      expect(created.sortOrder, 3);
    });

    test('rejects invalid categories and failed reads', () async {
      expect(
        await CreateCategory(repository)(category(id: 0, name: 'car')),
        isValidationError(),
      );
      when(() => repository.getPillars()).thenAnswer((_) async => dbError);
      expect(
        (await CreateCategory(repository)(category(id: 0)) as Err).failure,
        isA<DatabaseFailure>(),
      );
      verifyNever(() => repository.create(any()));
    });
  });

  group('UpdateCategory', () {
    test('keeps type, role, defaults, order and archive state', () async {
      await UpdateCategory(repository)(
        uncategorized.copyWith(
          name: 'misc',
          type: CategoryType.income,
          role: CategoryRole.custom,
          pillarId: 1,
          sortOrder: 9,
          isArchived: true,
        ),
      );

      final saved =
          verify(() => repository.save(captureAny())).captured.single
              as Category;
      expect(saved, uncategorized.copyWith(name: 'Misc'));
    });

    test('rejects unknown and invalid categories', () async {
      expect(
        await UpdateCategory(repository)(category(id: 99)),
        isValidationError(),
      );
      expect(
        await UpdateCategory(repository)(car.copyWith(name: 'Clothes')),
        isValidationError(),
      );
      when(() => repository.getCategories()).thenAnswer((_) async => dbError);
      expect(
        (await UpdateCategory(repository)(car) as Err).failure,
        isA<DatabaseFailure>(),
      );
      verifyNever(() => repository.save(any()));
    });
  });

  group('SetCategoryArchived', () {
    test('archives and restores custom categories', () async {
      await SetCategoryArchived(repository)(
        const SetCategoryArchivedParams(id: 1, archived: true),
      );

      verify(() => repository.save(car.copyWith(isArchived: true))).called(1);
    });

    test('keeps core categories active', () async {
      for (final id in [3, 99]) {
        expect(
          await SetCategoryArchived(repository)(
            SetCategoryArchivedParams(id: id, archived: true),
          ),
          isValidationError(),
        );
      }
      when(() => repository.getCategories()).thenAnswer((_) async => dbError);
      expect(
        (await SetCategoryArchived(repository)(
          const SetCategoryArchivedParams(id: 1, archived: true),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
      verifyNever(() => repository.save(any()));
    });
  });

  group('DeleteCategory', () {
    test('deletes a category without movements', () async {
      await DeleteCategory(repository)(const DeleteCategoryParams(id: 1));

      verify(() => repository.delete(1)).called(1);
    });

    test('moves the movements to the chosen category', () async {
      when(() => repository.countMovements(1))
          .thenAnswer((_) async => const Ok(4));

      await DeleteCategory(repository)(
        const DeleteCategoryParams(id: 1, reassignTo: 3),
      );

      verify(() => repository.delete(1, reassignTo: 3)).called(1);
    });

    test('needs a valid target when there are movements', () async {
      when(() => repository.countMovements(1))
          .thenAnswer((_) async => const Ok(4));

      for (final target in [null, 1, 4, 99]) {
        expect(
          await DeleteCategory(repository)(
            DeleteCategoryParams(id: 1, reassignTo: target),
          ),
          isValidationError(),
          reason: '$target',
        );
      }
      verifyNever(
        () => repository.delete(any(), reassignTo: any(named: 'reassignTo')),
      );
    });

    test('keeps core and unknown categories', () async {
      for (final id in [3, 99]) {
        expect(
          await DeleteCategory(repository)(DeleteCategoryParams(id: id)),
          isValidationError(),
        );
      }
    });

    test('propagates failures', () async {
      when(() => repository.countMovements(1)).thenAnswer((_) async => dbError);
      expect(
        (await DeleteCategory(repository)(
          const DeleteCategoryParams(id: 1),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
      when(() => repository.getCategories()).thenAnswer((_) async => dbError);
      expect(
        (await DeleteCategory(repository)(
          const DeleteCategoryParams(id: 1),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('UpdatePillar', () {
    test('saves a renamed pillar in its place', () async {
      await UpdatePillar(repository)(
        leisure.copyWith(name: ' fun ', sortOrder: 7),
      );

      verify(() => repository.savePillar(leisure.copyWith(name: 'Fun')))
          .called(1);
    });

    test('rejects unknown, repeated and failed pillars', () async {
      expect(
        await UpdatePillar(repository)(survival.copyWith(id: 99)),
        isValidationError(),
      );
      expect(
        await UpdatePillar(repository)(survival.copyWith(color: leisure.color)),
        isValidationError(),
      );
      when(() => repository.getPillars()).thenAnswer((_) async => dbError);
      expect(
        (await UpdatePillar(repository)(survival) as Err).failure,
        isA<DatabaseFailure>(),
      );
      verifyNever(() => repository.savePillar(any()));
    });
  });
}
