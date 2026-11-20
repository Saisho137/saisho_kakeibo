import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/core/usecase/usecase.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/add_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/delete_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/toggle_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class _MockTaskRepository extends Mock implements TaskRepository;

void main() {
  late _MockTaskRepository repository;

  setUp(() => repository = _MockTaskRepository());

  group('AddTask', () {
    test('rejects a blank title without calling the repository', () async {
      final result = await AddTask(repository)('   ');

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => repository.addTask(any()));
    });

    test('trims the title before adding it', () async {
      final task = buildTask();
      when(() => repository.addTask(any())).thenAnswer((_) async => Ok(task));

      final result = await AddTask(repository)('  Buy milk  ');

      expect((result as Ok).value, task);
      verify(() => repository.addTask('Buy milk')).called(1);
    });
  });

  group('ToggleTask', () {
    test('inverts the done flag', () async {
      when(
        () => repository.setDone(
          id: any(named: 'id'),
          isDone: any(named: 'isDone'),
        ),
      ).thenAnswer((_) async => const Ok(null));

      await ToggleTask(repository)(buildTask(id: 7));

      verify(() => repository.setDone(id: 7, isDone: true)).called(1);
    });
  });

  group('DeleteTask', () {
    test('deletes by id', () async {
      when(() => repository.deleteTask(any()))
          .thenAnswer((_) async => const Ok(null));

      await DeleteTask(repository)(3);

      verify(() => repository.deleteTask(3)).called(1);
    });
  });

  group('WatchTasks', () {
    test('returns the repository stream', () {
      final tasks = [buildTask()];
      when(() => repository.watchTasks())
          .thenAnswer((_) => Stream.value(tasks));

      expect(WatchTasks(repository)(const NoParams()), emits(tasks));
    });
  });
}
