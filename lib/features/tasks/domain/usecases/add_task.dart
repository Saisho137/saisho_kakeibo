import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';

/// Adds a task after trimming its title. Blank titles are rejected.
class AddTask implements UseCase<Future<Result<Task>>, String> {
  const new(this._repository);

  final TaskRepository _repository;

  @override
  Future<Result<Task>> call(String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) {
      return const Err(ValidationFailure('Task title cannot be empty.'));
    }
    return await _repository.addTask(trimmed);
  }
}
