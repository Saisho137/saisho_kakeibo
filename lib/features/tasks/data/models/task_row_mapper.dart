import 'package:flutter_archetype/core/database/app_database.dart';
import 'package:flutter_archetype/features/tasks/domain/entities/task.dart';

/// Maps persistence models to domain entities, keeping drift out of `domain`.
extension TaskRowMapper on TaskRow {
  Task toEntity() =>
      Task(id: id, title: title, isDone: isDone, createdAt: createdAt);
}
