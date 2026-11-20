import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/count_category_movements.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/create_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/delete_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_pillars.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/set_category_archived.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_category.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';

import '../../../../helpers/category_fixtures.dart';

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetPillars extends Mock implements GetPillars;

class _MockCountMovements extends Mock implements CountCategoryMovements;

class _MockCreateCategory extends Mock implements CreateCategory;

class _MockUpdateCategory extends Mock implements UpdateCategory;

class _MockSetArchived extends Mock implements SetCategoryArchived;

class _MockDeleteCategory extends Mock implements DeleteCategory;

void main() {
  late _MockGetCategories getCategories;
  late _MockGetPillars getPillars;
  late _MockCountMovements countMovements;
  late _MockCreateCategory createCategory;
  late _MockUpdateCategory updateCategory;
  late _MockSetArchived setArchived;
  late _MockDeleteCategory deleteCategory;

  final restaurant = IconCatalog.resolve('restaurant').color.toARGB32();
  final eatingOut = category(
    id: 1,
    name: 'Eating out',
    iconKey: 'restaurant',
    color: restaurant,
  );
  final uncategorized = category(
    id: 2,
    name: 'Uncategorized',
    role: CategoryRole.uncategorized,
    iconKey: 'help',
    sortOrder: 1,
  );
  final between = category(
    id: 3,
    name: 'Between accounts',
    type: CategoryType.transfer,
    role: CategoryRole.betweenAccounts,
  );
  final bonus = category(id: 4, name: 'Bonus', type: CategoryType.income);
  final returns = category(id: 5, name: 'Returns', type: CategoryType.income);
  final categories = [eatingOut, uncategorized, between, bonus, returns];

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(eatingOut);
    registerFallbackValue(
      const SetCategoryArchivedParams(id: 0, archived: true),
    );
    registerFallbackValue(const DeleteCategoryParams(id: 0));
  });

  setUp(() {
    getCategories = _MockGetCategories();
    getPillars = _MockGetPillars();
    countMovements = _MockCountMovements();
    createCategory = _MockCreateCategory();
    updateCategory = _MockUpdateCategory();
    setArchived = _MockSetArchived();
    deleteCategory = _MockDeleteCategory();
    when(() => getCategories(any())).thenAnswer((_) async => Ok(categories));
    when(() => getPillars(any())).thenAnswer((_) async => const Ok(pillars));
    when(() => countMovements(any())).thenAnswer((_) async => const Ok(0));
    when(() => createCategory(any())).thenAnswer((_) async => const Ok(9));
    when(() => updateCategory(any())).thenAnswer((_) async => const Ok(null));
    when(() => setArchived(any())).thenAnswer((_) async => const Ok(null));
    when(() => deleteCategory(any())).thenAnswer((_) async => const Ok(null));
  });

  CategoryFormCubit buildCubit() => CategoryFormCubit(
    getCategories: getCategories,
    getPillars: getPillars,
    countMovements: countMovements,
    createCategory: createCategory,
    updateCategory: updateCategory,
    setArchived: setArchived,
    deleteCategory: deleteCategory,
  );

  Future<CategoryFormCubit> loaded({
    CategoryType type = CategoryType.expense,
    int? id,
  }) async {
    final cubit = buildCubit();
    await cubit.load(type: type, id: id);
    return cubit;
  }

  Category created() =>
      verify(() => createCategory(captureAny())).captured.single as Category;

  Category updated() =>
      verify(() => updateCategory(captureAny())).captured.single as Category;

  group('CategoryFormCubit.load', () {
    test('starts a custom category of the given type', () async {
      final state = (await loaded(type: CategoryType.income)).state;

      expect(state.status, CategoryFormStatus.editing);
      expect(state.isEditing, isFalse);
      expect(state.type, CategoryType.income);
      expect(state.iconKey, CategoryFormCubit.newIconKey);
      expect(state.hasPillar, isFalse);
      expect(state.canArchive, isFalse);
      expect(state.canDelete, isFalse);
      expect(state.canReset, isFalse);
    });

    test('fills the form of a stored category', () async {
      when(() => countMovements(1)).thenAnswer((_) async => const Ok(3));

      final state = (await loaded(id: 1)).state;

      expect(state.original, eatingOut);
      expect(state.name, 'Eating out');
      expect(state.pillarId, survival.id);
      expect(state.movementCount, 3);
      expect(state.hasPillar, isTrue);
      expect(state.canDelete, isTrue);
    });

    test('core categories cannot be archived or deleted', () async {
      final state = (await loaded(id: 2)).state;

      expect(state.isCore, isTrue);
      expect(state.role, CategoryRole.uncategorized);
      expect(state.hasPillar, isFalse);
      expect(state.canArchive, isFalse);
      expect(state.canDelete, isFalse);
    });

    test('reports a missing category and a failed read', () async {
      expect((await loaded(id: 99)).state.status, CategoryFormStatus.notFound);

      when(() => getPillars(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final state = (await loaded()).state;
      expect(state.status, CategoryFormStatus.notFound);
      expect(state.failure, isA<DatabaseFailure>());
    });
  });

  group('CategoryFormCubit fields', () {
    test('an icon brings its color, or a free variant', () async {
      final cubit = await loaded();

      cubit.iconChanged('restaurant');
      expect(cubit.state.iconKey, 'restaurant');
      expect(cubit.state.color, isNot(restaurant));

      cubit.iconChanged('directions_car');
      expect(
        cubit.state.color,
        IconCatalog.resolve('directions_car').color.toARGB32(),
      );
    });

    test('changing the type suggests the color again', () async {
      final cubit = await loaded()
        ..iconChanged('restaurant')
        ..typeChanged(CategoryType.income);

      expect(cubit.state.type, CategoryType.income);
      expect(cubit.state.color, restaurant);
    });

    test('a stored category keeps its type', () async {
      final cubit = (await loaded(id: 1))..typeChanged(CategoryType.income);

      expect(cubit.state.type, CategoryType.expense);
    });

    test('resets a core category to its defaults', () async {
      final cubit = (await loaded(id: 2))
        ..nameChanged('Misc')
        ..iconChanged('star');
      expect(cubit.state.canReset, isTrue);

      cubit.resetToDefault();

      expect(cubit.state.name, 'Uncategorized');
      expect(cubit.state.iconKey, 'help');
      expect(cubit.state.resets, 1);
      expect(cubit.state.canReset, isFalse);
    });

    test('a custom category has nothing to reset', () async {
      final cubit = (await loaded(id: 1))..resetToDefault();

      expect(cubit.state.resets, 0);
    });
  });

  group('CategoryFormCubit.submit', () {
    test('shows errors after the first try and updates them', () async {
      final cubit = await loaded();

      await cubit.submit();
      expect(cubit.state.errors, {
        CategoryError.emptyName,
        CategoryError.missingPillar,
      });

      cubit
        ..nameChanged('eating out')
        ..pillarChanged(leisure.id);
      expect(cubit.state.errors, {CategoryError.duplicateName});
      verifyNever(() => createCategory(any()));
    });

    test('creates a custom expense', () async {
      final cubit = await loaded()
        ..nameChanged(' groceries ')
        ..iconChanged('shopping_cart')
        ..colorChanged(7)
        ..pillarChanged(leisure.id);

      await cubit.submit();

      expect(
        created(),
        const Category(
          name: 'Groceries',
          iconKey: 'shopping_cart',
          color: 7,
          type: CategoryType.expense,
          pillarId: 2,
        ),
      );
      expect(cubit.state.status, CategoryFormStatus.saved);
    });

    test('updates a stored category', () async {
      final cubit = (await loaded(id: 1))..nameChanged('Restaurants');

      await cubit.submit();

      expect(updated(), eatingOut.copyWith(name: 'Restaurants'));
    });

    test('keeps editing and exposes a failed save', () async {
      when(() => updateCategory(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final cubit = await loaded(id: 1);

      await cubit.submit();

      expect(cubit.state.status, CategoryFormStatus.editing);
      expect(cubit.state.failure, isA<DatabaseFailure>());
    });
  });

  group('CategoryFormCubit archive and delete', () {
    test('archives and deletes the edited category', () async {
      final cubit = await loaded(id: 1);

      await cubit.setArchived(archived: true);
      final archived =
          verify(() => setArchived(captureAny())).captured.single
              as SetCategoryArchivedParams;
      expect((archived.id, archived.archived), (1, true));

      await cubit.delete(reassignTo: 2);
      final deleted =
          verify(() => deleteCategory(captureAny())).captured.single
              as DeleteCategoryParams;
      expect((deleted.id, deleted.reassignTo), (1, 2));
      expect(cubit.state.status, CategoryFormStatus.deleted);
    });

    test('does nothing for a new category', () async {
      final cubit = await loaded();

      await cubit.setArchived(archived: true);
      await cubit.delete();

      verifyNever(() => setArchived(any()));
      verifyNever(() => deleteCategory(any()));
    });

    test('offers active categories of the same type as targets', () async {
      final expense = (await loaded(id: 1)).state;
      expect(expense.deleteTargets, [uncategorized]);
      expect(expense.defaultDeleteTarget, uncategorized);

      final income = (await loaded(id: 4)).state;
      expect(income.deleteTargets, [returns]);
      expect(income.defaultDeleteTarget, isNull);

      expect((await loaded()).state.deleteTargets, isEmpty);
    });
  });
}
