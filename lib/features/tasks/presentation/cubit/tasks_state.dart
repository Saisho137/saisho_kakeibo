part of 'tasks_cubit.dart';

enum TasksStatus { loading, success, failure }

@freezed
abstract class TasksState with _$TasksState {
  const factory({
    @Default(TasksStatus.loading) TasksStatus status,
    @Default(<Task>[]) List<Task> tasks,

    /// Last failure of a user action, shown once by the UI.
    Failure? failure,
  }) = _TasksState;
}
