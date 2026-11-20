import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/features/tasks/data/datasources/task_dao.dart';
import 'package:flutter_archetype/features/tasks/data/models/task_row_mapper.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  const new(this._dao);

  final TaskDao _dao;

  @override
  Stream<List<Task>> watchTasks() => _dao.watchAll().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<Task>> addTask(String title) =>
      _guard(() async => (await _dao.insertTask(title)).toEntity());

  @override
  Future<Result<void>> setDone({required int id, required bool isDone}) =>
      _guard(() => _dao.updateDone(id, isDone: isDone));

  @override
  Future<Result<void>> deleteTask(int id) => _guard(() => _dao.deleteById(id));

  /// Translates infrastructure exceptions into domain failures.
  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Ok(await action());
    } on Exception catch (e) {
      return Err(DatabaseFailure(e.toString()));
    }
  }
}
