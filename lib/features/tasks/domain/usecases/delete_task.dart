import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';

class DeleteTask implements UseCase<Future<Result<void>>, int> {
  const new(this._repository);

  final TaskRepository _repository;

  @override
  Future<Result<void>> call(int id) => _repository.deleteTask(id);
}
