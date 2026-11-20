import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';

class ToggleTask implements UseCase<Future<Result<void>>, Task> {
  const new(this._repository);

  final TaskRepository _repository;

  @override
  Future<Result<void>> call(Task task) =>
      _repository.setDone(id: task.id, isDone: !task.isDone);
}
