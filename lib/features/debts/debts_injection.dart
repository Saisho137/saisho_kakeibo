import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/debts/data/repositories/debt_repository_impl.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/delete_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/edit_debt_pending.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/save_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_detail_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_form_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debts_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerDebtsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<DebtRepository>(
      () => DebtRepositoryImpl(getIt<AppDatabase>().debtDao),
    )
    ..registerFactory(() => WatchDebts(getIt()))
    ..registerFactory(() => GetDebt(getIt()))
    ..registerFactory(() => SaveDebt(getIt()))
    ..registerFactory(() => DeleteDebt(getIt()))
    ..registerFactory(() => EditDebtPending(getIt()))
    ..registerFactory(() => GetDebtStatuses(debts: getIt(), movements: getIt()))
    ..registerFactory(
      () => DebtsCubit(
        watchDebts: getIt(),
        watchMovements: getIt(),
        watchAccounts: getIt(),
        watchBalances: getIt(),
        watchPillars: getIt(),
        watchCurrencies: getIt(),
        watchSettings: getIt(),
      ),
    )
    ..registerFactory(
      () => DebtDetailCubit(
        watchDebts: getIt(),
        watchMovements: getIt(),
        watchAccounts: getIt(),
        watchCategories: getIt(),
        watchPayees: getIt(),
        watchPillars: getIt(),
        watchCurrencies: getIt(),
        editPending: getIt(),
        deleteDebt: getIt(),
      ),
    )
    ..registerFactory(
      () => DebtFormCubit(
        getDebt: getIt(),
        getPillars: getIt(),
        getCurrencies: getIt(),
        debts: getIt(),
        saveDebt: getIt(),
      ),
    );
}
