import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/account_has_movements.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/create_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/delete_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/reorder_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/set_account_archived.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit. It uses
/// `WatchCurrencies` and `GetCurrencies` from the settings feature.
void registerAccountsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(getIt<AppDatabase>().accountDao),
    )
    ..registerFactory(() => WatchAccounts(getIt()))
    ..registerFactory(() => WatchAccountBalances(getIt()))
    ..registerFactory(() => GetAccounts(getIt()))
    ..registerFactory(() => AccountHasMovements(getIt()))
    ..registerFactory(() => CreateAccount(getIt()))
    ..registerFactory(() => UpdateAccount(getIt()))
    ..registerFactory(() => SetAccountArchived(getIt()))
    ..registerFactory(() => DeleteAccount(getIt()))
    ..registerFactory(() => ReorderAccounts(getIt()))
    ..registerFactory(
      () => AccountsCubit(
        watchAccounts: getIt(),
        watchBalances: getIt(),
        watchCurrencies: getIt(),
        updateAccount: getIt(),
        reorderAccounts: getIt(),
      ),
    )
    ..registerFactory(
      () => AccountFormCubit(
        getAccounts: getIt(),
        getCurrencies: getIt(),
        hasMovements: getIt(),
        createAccount: getIt(),
        updateAccount: getIt(),
        setArchived: getIt(),
        deleteAccount: getIt(),
      ),
    );
}
