import 'package:meta/meta.dart';

/// An amount of money in the minor unit of its currency (RT-03).
///
/// The minor unit depends on the currency's decimals: COP has none, so
/// `Money(4250000, 'COP')` is 4.250.000 pesos; USD has two, so
/// `Money(125050, 'USD')` is 1.250,50 dollars. Amounts are never `double`.
///
/// Currencies are never converted: combining amounts of different
/// currencies throws a [CurrencyMismatchError].
@immutable
final class Money implements Comparable<Money> {
  const new(this.minor, this.currency);

  const new zero(this.currency) : minor = 0;

  /// Amount in the currency's minor unit (pesos, cents).
  final int minor;

  /// Currency code, such as `COP` or `USD`.
  final String currency;

  bool get isZero => minor == 0;

  bool get isNegative => minor < 0;

  bool get isPositive => minor > 0;

  Money abs() => Money(minor.abs(), currency);

  Money operator +(Money other) {
    _checkSameCurrency(other);
    return Money(minor + other.minor, currency);
  }

  Money operator -(Money other) {
    _checkSameCurrency(other);
    return Money(minor - other.minor, currency);
  }

  Money operator -() => Money(-minor, currency);

  bool operator <(Money other) => compareTo(other) < 0;

  bool operator >(Money other) => compareTo(other) > 0;

  @override
  int compareTo(Money other) {
    _checkSameCurrency(other);
    return minor.compareTo(other.minor);
  }

  void _checkSameCurrency(Money other) {
    if (other.currency != currency) {
      throw CurrencyMismatchError(currency, other.currency);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Money && other.minor == minor && other.currency == currency;

  @override
  int get hashCode => Object.hash(minor, currency);

  @override
  String toString() => '$currency $minor';
}

/// Thrown when amounts of different currencies are combined. It signals a
/// programming error: callers must group amounts by currency first.
final class CurrencyMismatchError extends Error {
  new(this.left, this.right);

  final String left;
  final String right;

  @override
  String toString() => 'CurrencyMismatchError: cannot combine $left and $right';
}
