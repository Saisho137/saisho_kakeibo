import 'package:flutter_archetype/core/database/app_database.dart';
import 'package:flutter_archetype/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:flutter_archetype/features/tasks/domain/repositories/task_repository.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/add_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/delete_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/toggle_task.dart';
import 'package:flutter_archetype/features/tasks/domain/usecases/watch_tasks.dart';
import 'package:flutter_archetype/features/tasks/presentation/cubit/tasks_cubit.dart';
import 'package:get_it/get_it.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerTasksDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(getIt<AppDatabase>().taskDao),
    )
    ..registerFactory(() => WatchTasks(getIt()))
    ..registerFactory(() => AddTask(getIt()))
    ..registerFactory(() => ToggleTask(getIt()))
    ..registerFactory(() => DeleteTask(getIt()))
    ..registerFactory(
      () => TasksCubit(
        watchTasks: getIt(),
        addTask: getIt(),
        toggleTask: getIt(),
        deleteTask: getIt(),
      ),
    );
}
