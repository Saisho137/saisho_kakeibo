import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
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
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerCategoriesDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(getIt<AppDatabase>().categoryDao),
    )
    ..registerFactory(() => WatchCategories(getIt()))
    ..registerFactory(() => WatchPillars(getIt()))
    ..registerFactory(() => GetCategories(getIt()))
    ..registerFactory(() => GetPillars(getIt()))
    ..registerFactory(() => CountCategoryMovements(getIt()))
    ..registerFactory(() => CreateCategory(getIt()))
    ..registerFactory(() => UpdateCategory(getIt()))
    ..registerFactory(() => SetCategoryArchived(getIt()))
    ..registerFactory(() => DeleteCategory(getIt()))
    ..registerFactory(() => ReorderCategories(getIt()))
    ..registerFactory(() => UpdatePillar(getIt()))
    ..registerFactory(
      () => CategoriesCubit(
        watchCategories: getIt(),
        watchPillars: getIt(),
        reorderCategories: getIt(),
        updatePillar: getIt(),
      ),
    )
    ..registerFactory(
      () => CategoryFormCubit(
        getCategories: getIt(),
        getPillars: getIt(),
        countMovements: getIt(),
        createCategory: getIt(),
        updateCategory: getIt(),
        setArchived: getIt(),
        deleteCategory: getIt(),
      ),
    );
}
