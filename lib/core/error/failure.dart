/// Expected errors that cross layer boundaries.
///
/// Repositories catch infrastructure exceptions and translate them into a
/// [Failure], so the domain and presentation layers never depend on drift,
/// HTTP clients or platform exceptions.
sealed class Failure {
  const new(this.message);

  final String message;
}

/// A local database read or write failed.
final class DatabaseFailure extends Failure {
  const new(super.message);
}

/// Input did not pass a business rule.
final class ValidationFailure extends Failure {
  const new(super.message);
}

/// Anything not covered by a more specific failure.
final class UnexpectedFailure extends Failure {
  const new(super.message);
}
