import 'package:flutter_archetype/core/database/app_database.dart';
import 'package:flutter_archetype/features/tasks/tasks_injection.dart';
import 'package:get_it/get_it.dart';

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
  registerTasksDependencies(getIt);
}
