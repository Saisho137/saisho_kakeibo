import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/adjust_account_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payee_suggestions.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/prefill_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_account_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/movement_form_cubit.dart';

/// Registers the feature's dependencies. It uses the accounts, categories
/// and settings features, so it is registered after them.
void registerMovementsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<MovementRepository>(
      () => MovementRepositoryImpl(getIt<AppDatabase>().movementDao),
    )
    ..registerFactory(() => WatchAccountMovements(getIt()))
    ..registerFactory(() => WatchPayees(getIt()))
    ..registerFactory(() => DeleteMovement(getIt()))
    ..registerFactory(
      () => SaveMovement(
        movements: getIt(),
        accounts: getIt(),
        categories: getIt(),
      ),
    )
    ..registerFactory(
      () => AdjustAccountBalance(accounts: getIt(), movements: getIt()),
    )
    ..registerFactory(() => GetMovement(getIt()))
    ..registerFactory(() => GetPayees(getIt()))
    ..registerFactory(() => GetPayeeSuggestions(getIt()))
    ..registerFactory(() => SuggestPeriodStart(getIt()))
    ..registerFactory(
      () => PrefillMovement(movements: getIt(), accounts: getIt()),
    )
    ..registerFactory(
      () => CategoryGridCubit(
        getCategories: getIt(),
        getPayeeSuggestions: getIt(),
      ),
    )
    ..registerFactory(
      () => MovementFormCubit(
        getAccounts: getIt(),
        getCategories: getIt(),
        getCurrencies: getIt(),
        getPayees: getIt(),
        getMovement: getIt(),
        prefill: getIt(),
        suggestPeriodStart: getIt(),
        saveMovement: getIt(),
        deleteMovement: getIt(),
      ),
    )
    ..registerFactory(
      () => AccountDetailCubit(
        watchAccounts: getIt(),
        watchBalances: getIt(),
        watchCurrencies: getIt(),
        watchMovements: getIt(),
        watchCategories: getIt(),
        watchPayees: getIt(),
        adjustBalance: getIt(),
        deleteMovement: getIt(),
      ),
    );
}
