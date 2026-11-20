import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/settings/data/repositories/currency_repository_impl.dart';
import 'package:saisho_kakeibo/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/create_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/delete_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerSettingsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepositoryImpl(getIt<AppDatabase>().currencyDao),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<AppDatabase>().settingsDao),
    )
    ..registerFactory(() => WatchCurrencies(getIt()))
    ..registerFactory(() => CreateCurrency(getIt()))
    ..registerFactory(() => UpdateCurrency(getIt()))
    ..registerFactory(() => DeleteCurrency(getIt(), getIt()))
    ..registerFactory(() => WatchSettings(getIt()))
    ..registerFactory(() => UpdateSettings(getIt()))
    ..registerFactory(
      () => SettingsCubit(watchSettings: getIt(), updateSettings: getIt()),
    );
}
