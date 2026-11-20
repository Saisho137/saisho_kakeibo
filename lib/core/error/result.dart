import 'package:saisho_kakeibo/core/error/failure.dart';

/// Outcome of an operation that can fail in an expected way.
///
/// Prefer returning a [Result] over throwing for business errors, and handle
/// both cases with pattern matching:
///
/// ```dart
/// switch (await addTask('Buy milk')) {
///   case Ok(:final value): ...
///   case Err(:final failure): ...
/// }
/// ```
sealed class Result<T> {
  const new();

  bool get isOk => this is Ok<T>;
}

final class Ok<T> extends Result<T> {
  const new(this.value);

  final T value;
}

final class Err<T> extends Result<T> {
  const new(this.failure);

  final Failure failure;
}
