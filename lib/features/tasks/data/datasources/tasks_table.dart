import 'package:drift/drift.dart';

/// Drift table. Rows are generated as `TaskRow` so they never clash with the
/// domain `Task` entity.
@DataClassName('TaskRow')
class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 200)();

  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
