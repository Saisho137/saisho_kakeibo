import 'package:drift/native.dart';
import 'package:flutter_archetype/core/database/app_database.dart';
import 'package:flutter_archetype/core/error/failure.dart';
import 'package:flutter_archetype/core/error/result.dart';
import 'package:flutter_archetype/features/tasks/data/datasources/task_dao.dart';
import 'package:flutter_archetype/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockTaskDao extends Mock implements TaskDao;

void main() {
  group('TaskRepositoryImpl', () {
    late AppDatabase db;
    late TaskRepositoryImpl repository;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repository = TaskRepositoryImpl(db.taskDao);
    });

    tearDown(() => db.close());

    test('addTask persists the task and watchTasks emits it', () async {
      final result = await repository.addTask('Buy milk');

      expect(result, isA<Ok<Object?>>());
      final tasks = await repository.watchTasks().first;
      expect(tasks.single.title, 'Buy milk');
      expect(tasks.single.isDone, isFalse);
    });

    test('watchTasks lists the newest task first', () async {
      await repository.addTask('First');
      await repository.addTask('Second');

      final tasks = await repository.watchTasks().first;

      expect(tasks.map((t) => t.title), ['Second', 'First']);
    });

    test('setDone updates the task', () async {
      final added = await repository.addTask('Buy milk') as Ok<Task>;
      final id = added.value.id;

      await repository.setDone(id: id, isDone: true);

      final tasks = await repository.watchTasks().first;
      expect(tasks.single.isDone, isTrue);
    });

    test('deleteTask removes the task', () async {
      await repository.addTask('Buy milk');
      final id = (await repository.watchTasks().first).single.id;

      await repository.deleteTask(id);

      expect(await repository.watchTasks().first, isEmpty);
    });

    test('translates data source exceptions into a DatabaseFailure', () async {
      final dao = _MockTaskDao();
      when(() => dao.insertTask(any())).thenThrow(Exception('disk full'));

      final result = await TaskRepositoryImpl(dao).addTask('Buy milk');

      expect(result, isA<Err<Object?>>());
      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });
}
