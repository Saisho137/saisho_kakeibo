import 'package:drift/drift.dart';
import 'package:flutter_archetype/core/database/app_database.dart';
import 'package:flutter_archetype/features/tasks/data/datasources/tasks_table.dart';

part 'task_dao.g.dart';

/// Local data source: every SQL query of the feature lives here.
@DriftAccessor(tables: [Tasks])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  new(super.attachedDatabase);

  Stream<List<TaskRow>> watchAll() =>
      (select(tasks)..orderBy([(t) => OrderingTerm.desc(t.id)])).watch();

  Future<TaskRow> insertTask(String title) =>
      into(tasks).insertReturning(TasksCompanion.insert(title: title));

  Future<int> updateDone(int id, {required bool isDone}) =>
      (update(tasks)..where((t) => t.id.equals(id))).write(
        TasksCompanion(isDone: Value(isDone)),
      );

  Future<int> deleteById(int id) =>
      (delete(tasks)..where((t) => t.id.equals(id))).go();
}
