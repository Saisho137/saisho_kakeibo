import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

/// Local SQLite database. Each feature declares its tables and DAOs in its
/// `data/datasources` folder and registers them here. Every schema change
/// bumps [schemaVersion] and adds a migration step.
@DriftDatabase()
class AppDatabase extends _$AppDatabase {
  new([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const String databaseName = 'saisho_kakeibo';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(name: databaseName);
}
