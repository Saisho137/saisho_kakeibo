import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

/// Domain entity. Pure Dart: no Flutter, drift or JSON dependencies.
@freezed
abstract class Task with _$Task {
  const factory({
    required int id,
    required String title,
    required bool isDone,
    required DateTime createdAt,
  }) = _Task;
}
