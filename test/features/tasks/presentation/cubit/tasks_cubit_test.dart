import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/add_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/delete_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/toggle_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:flutter_archetype/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class _MockWatchTasks extends Mock implements WatchTasks;

class _MockAddTask extends Mock implements AddTask;

class _MockToggleTask extends Mock implements ToggleTask;

class _MockDeleteTask extends Mock implements DeleteTask;

void main() {
  late _MockWatchTasks watchTasks;
  late _MockAddTask addTask;
  late _MockToggleTask toggleTask;
  late _MockDeleteTask deleteTask;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    watchTasks = _MockWatchTasks();
    addTask = _MockAddTask();
    toggleTask = _MockToggleTask();
    deleteTask = _MockDeleteTask();
  });

  TasksCubit buildCubit() => TasksCubit(
    watchTasks: watchTasks,
    addTask: addTask,
    toggleTask: toggleTask,
    deleteTask: deleteTask,
  );

  group('TasksCubit', () {
    test('starts loading', () {
      expect(buildCubit().state, const TasksState());
    });

    final tasks = [buildTask()];

    blocTest<TasksCubit, TasksState>(
      'emits success with the tasks pushed by the stream',
      setUp: () =>
          when(() => watchTasks(any())).thenAnswer((_) => Stream.value(tasks)),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [TasksState(status: TasksStatus.success, tasks: tasks)],
    );

    blocTest<TasksCubit, TasksState>(
      'emits failure when the stream errors',
      setUp: () =>
          when(() => watchTasks(any()))
              .thenAnswer((_) => Stream.error(Exception('boom'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<TasksState>()
            .having((s) => s.status, 'status', TasksStatus.failure)
            .having((s) => s.failure, 'failure', isA<UnexpectedFailure>()),
      ],
    );

    blocTest<TasksCubit, TasksState>(
      'exposes the failure of a rejected action',
      setUp: () =>
          when(() => addTask(any()))
              .thenAnswer((_) async => const Err(ValidationFailure('empty'))),
      build: buildCubit,
      act: (cubit) => cubit.add(''),
      expect: () => [
        isA<TasksState>().having(
          (s) => s.failure,
          'failure',
          isA<ValidationFailure>(),
        ),
      ],
    );

    blocTest<TasksCubit, TasksState>(
      'emits nothing when an action succeeds',
      setUp: () =>
          when(() => deleteTask(any())).thenAnswer((_) async => const Ok(null)),
      build: buildCubit,
      act: (cubit) => cubit.delete(1),
      expect: () => <TasksState>[],
      verify: (_) => verify(() => deleteTask(1)).called(1),
    );
  });
}
