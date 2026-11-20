import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';

/// Contract implemented by the data layer.
abstract interface class TaskRepository {
  Stream<List<Task>> watchTasks();

  Future<Result<Task>> addTask(String title);

  Future<Result<void>> setDone({required int id, required bool isDone});

  Future<Result<void>> deleteTask(int id);
}
