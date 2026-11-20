import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/reorder_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';

import '../../../../helpers/category_fixtures.dart';

class _MockWatchCategories extends Mock implements WatchCategories;

class _MockWatchPillars extends Mock implements WatchPillars;

class _MockReorderCategories extends Mock implements ReorderCategories;

class _MockUpdatePillar extends Mock implements UpdatePillar;

void main() {
  late _MockWatchCategories watchCategories;
  late _MockWatchPillars watchPillars;
  late _MockReorderCategories reorderCategories;
  late _MockUpdatePillar updatePillar;

  final car = category(id: 1, name: 'Car');
  final clothes = category(id: 2, name: 'Clothes', sortOrder: 1);
  final old = category(id: 3, name: 'Old', isArchived: true, sortOrder: 2);
  final loan = category(id: 4, role: CategoryRole.loanGiven, sortOrder: 3);
  final salary = category(id: 5, type: CategoryType.income);
  final categories = [car, clothes, old, loan, salary];

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(survival);
  });

  setUp(() {
    watchCategories = _MockWatchCategories();
    watchPillars = _MockWatchPillars();
    reorderCategories = _MockReorderCategories();
    updatePillar = _MockUpdatePillar();
    when(() => watchCategories(any()))
        .thenAnswer((_) => Stream.value(categories));
    when(() => watchPillars(any())).thenAnswer((_) => Stream.value(pillars));
    when(() => reorderCategories(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => updatePillar(any())).thenAnswer((_) async => const Ok(null));
  });

  CategoriesCubit buildCubit() => CategoriesCubit(
    watchCategories: watchCategories,
    watchPillars: watchPillars,
    reorderCategories: reorderCategories,
    updatePillar: updatePillar,
  );

  final loaded = CategoriesState(
    status: CategoriesStatus.success,
    categories: categories,
    pillars: pillars,
  );

  group('CategoriesCubit', () {
    blocTest<CategoriesCubit, CategoriesState>(
      'shows the screen once categories and pillars arrive',
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [CategoriesState(categories: categories), loaded],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchPillars(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      skip: 1,
      expect: () => [
        isA<CategoriesState>()
            .having((s) => s.status, 'status', CategoriesStatus.failure)
            .having((s) => s.failure, 'failure', isA<UnexpectedFailure>()),
      ],
    );

    test('splits active and archived categories and finds pillars', () {
      expect(loaded.active(CategoryType.expense), [car, clothes, loan]);
      expect(loaded.archived(CategoryType.expense), [old]);
      expect(loaded.pillarOf(car), survival);
      expect(loaded.pillarOf(loan), isNull);
      expect(const CategoriesState().active(CategoryType.income), isEmpty);
    });

    blocTest<CategoriesCubit, CategoriesState>(
      'reorders the active categories and keeps archived ones last',
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.reorder(CategoryType.expense, 2, 0),
      verify: (_) => verify(() => reorderCategories([4, 1, 2, 3])).called(1),
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'ignores a move from outside the list',
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.reorder(CategoryType.transfer, 0, 1),
      verify: (_) => verifyNever(() => reorderCategories(any())),
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'updates a pillar and exposes a failure',
      setUp: () =>
          when(() => updatePillar(any()))
              .thenAnswer((_) async => const Err(DatabaseFailure('disk'))),
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.updatePillar(survival.copyWith(name: 'Needs')),
      expect: () => [
        isA<CategoriesState>().having(
          (s) => s.failure,
          'failure',
          isA<DatabaseFailure>(),
        ),
      ],
      verify: (_) =>
          verify(() => updatePillar(survival.copyWith(name: 'Needs')))
              .called(1),
    );
  });
}
