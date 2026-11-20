import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/accounts_injection.dart';
import 'package:saisho_kakeibo/features/categories/categories_injection.dart';
import 'package:saisho_kakeibo/features/home/home_injection.dart';
import 'package:saisho_kakeibo/features/movements/movements_injection.dart';
import 'package:saisho_kakeibo/features/periods/periods_injection.dart';
import 'package:saisho_kakeibo/features/settings/settings_injection.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies, then each feature's own.
///
/// Tests can pass an in-memory [database] and a fixed [appInfo].
Future<void> configureDependencies({
  AppDatabase? database,
  AppInfo? appInfo,
}) async {
  getIt.registerSingleton<AppInfo>(appInfo ?? await AppInfo.load());
  getIt.registerLazySingleton<AppDatabase>(
    () => database ?? AppDatabase(),
    dispose: (db) => db.close(),
  );
  registerSettingsDependencies(getIt);
  registerAccountsDependencies(getIt);
  registerCategoriesDependencies(getIt);
  registerMovementsDependencies(getIt);
  registerPeriodsDependencies(getIt);
  registerHomeDependencies(getIt);
}
