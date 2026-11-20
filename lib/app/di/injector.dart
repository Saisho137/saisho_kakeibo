import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/settings/settings_injection.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies, then each feature's own.
///
/// Tests can pass an in-memory [database].
Future<void> configureDependencies({AppDatabase? database}) async {
  getIt.registerLazySingleton<AppDatabase>(
    () => database ?? AppDatabase(),
    dispose: (db) => db.close(),
  );
  registerSettingsDependencies(getIt);
}
