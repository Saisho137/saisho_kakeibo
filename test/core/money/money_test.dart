import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/money.dart';

void main() {
  const cop = 'COP';
  const usd = 'USD';

  group('Money', () {
    test('adds and subtracts amounts of the same currency', () {
      expect(
        const Money(300, cop) + const Money(200, cop),
        const Money(500, cop),
      );
      expect(
        const Money(300, cop) - const Money(500, cop),
        const Money(-200, cop),
      );
    });

    test('negates and takes the absolute value', () {
      expect(-const Money(150, usd), const Money(-150, usd));
      expect(const Money(-150, usd).abs(), const Money(150, usd));
    });

    test('zero has no amount', () {
      const zero = Money.zero(cop);

      expect(zero.isZero, isTrue);
      expect(zero, const Money(0, cop));
    });

    test('reports its sign', () {
      expect(const Money(-1, cop).isNegative, isTrue);
      expect(const Money(1, cop).isPositive, isTrue);
      expect(const Money(0, cop).isPositive, isFalse);
      expect(const Money(0, cop).isNegative, isFalse);
    });

    test('compares amounts of the same currency', () {
      expect(const Money(1, cop) < const Money(2, cop), isTrue);
      expect(const Money(2, cop) > const Money(1, cop), isTrue);
      expect(const Money(2, cop).compareTo(const Money(2, cop)), 0);
    });

    test('never combines different currencies', () {
      const pesos = Money(100, cop);
      const dollars = Money(100, usd);

      expect(() => pesos + dollars, throwsA(isA<CurrencyMismatchError>()));
      expect(() => pesos - dollars, throwsA(isA<CurrencyMismatchError>()));
      expect(() => pesos < dollars, throwsA(isA<CurrencyMismatchError>()));
      expect(
        CurrencyMismatchError(cop, usd).toString(),
        contains('cannot combine COP and USD'),
      );
    });

    test('has value equality including the currency', () {
      expect(const Money(100, cop), const Money(100, cop));
      expect(const Money(100, cop).hashCode, const Money(100, cop).hashCode);
      expect(const Money(100, cop), isNot(const Money(100, usd)));
      expect(const Money(100, cop).toString(), 'COP 100');
    });
  });
}
