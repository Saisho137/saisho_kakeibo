import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';

/// Builds a [Task] with sensible defaults for tests.
Task buildTask({int id = 1, String title = 'Buy milk', bool isDone = false}) =>
    Task(id: id, title: title, isDone: isDone, createdAt: DateTime(2026));
