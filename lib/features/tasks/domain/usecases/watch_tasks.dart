import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';

class WatchTasks implements UseCase<Stream<List<Task>>, NoParams> {
  const new(this._repository);

  final TaskRepository _repository;

  @override
  Stream<List<Task>> call(NoParams params) => _repository.watchTasks();
}
