/// A single application action. One class per use case keeps business rules
/// small, discoverable and easy to test.
abstract interface class UseCase<Output, Params> {
  Output call(Params params);
}

/// Parameter placeholder for use cases that take no input.
final class NoParams {
  const new();
}
