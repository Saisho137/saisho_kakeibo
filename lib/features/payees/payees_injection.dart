import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/payees/data/repositories/payee_repository_impl.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/delete_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/merge_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/rename_payee.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payee_detail_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payees_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerPayeesDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<PayeeRepository>(
      () => PayeeRepositoryImpl(getIt<AppDatabase>().payeeDao),
    )
    ..registerFactory(() => RenamePayee(payees: getIt(), movements: getIt()))
    ..registerFactory(() => MergePayee(payees: getIt(), movements: getIt()))
    ..registerFactory(() => DeletePayee(payees: getIt(), debts: getIt()))
    ..registerFactory(
      () => PayeesCubit(
        watchPayees: getIt(),
        watchMovements: getIt(),
        watchAccounts: getIt(),
        watchCategories: getIt(),
        watchPeriodStarts: getIt(),
        watchCurrencies: getIt(),
        watchSettings: getIt(),
      ),
    )
    ..registerFactory(
      () => PayeeDetailCubit(
        watchPayees: getIt(),
        watchMovements: getIt(),
        watchAccounts: getIt(),
        watchCategories: getIt(),
        watchDebts: getIt(),
        watchPeriodStarts: getIt(),
        watchCurrencies: getIt(),
        watchSettings: getIt(),
        rename: getIt(),
        merge: getIt(),
        delete: getIt(),
      ),
    );
}
