import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/add_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/delete_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/toggle_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_cubit.freezed.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  new({
    required this._watchTasks,
    required this._addTask,
    required this._toggleTask,
    required this._deleteTask,
  }) : super(const TasksState());

  final WatchTasks _watchTasks;
  final AddTask _addTask;
  final ToggleTask _toggleTask;
  final DeleteTask _deleteTask;
  StreamSubscription<List<Task>>? _subscription;

  /// Starts listening to the task list. The database pushes every change.
  void load() {
    unawaited(_subscription?.cancel());
    _subscription = _watchTasks(const NoParams()).listen(
      (tasks) =>
          emit(state.copyWith(status: TasksStatus.success, tasks: tasks)),
      onError: (Object error) => emit(
        state.copyWith(
          status: TasksStatus.failure,
          failure: UnexpectedFailure(error.toString()),
        ),
      ),
    );
  }

  Future<void> add(String title) => _run(_addTask(title));

  Future<void> toggle(Task task) => _run(_toggleTask(task));

  Future<void> delete(int id) => _run(_deleteTask(id));

  Future<void> _run(Future<Result<Object?>> action) async {
    if (await action case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
