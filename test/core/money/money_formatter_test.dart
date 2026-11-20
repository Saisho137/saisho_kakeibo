import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';

void main() {
  String format(int minor, CurrencyFormat currencyFormat) =>
      MoneyFormatter.format(Money(minor, 'X'), currencyFormat);

  group('MoneyFormatter', () {
    test('formats COP without decimals', () {
      expect(format(4250000, CurrencyFormat.cop), '4.250.000');
    });

    test('formats USD with two decimals', () {
      expect(format(125050, CurrencyFormat.usd), '1.250,50');
    });

    test('groups thousands only where needed', () {
      expect(format(0, CurrencyFormat.cop), '0');
      expect(format(999, CurrencyFormat.cop), '999');
      expect(format(1000, CurrencyFormat.cop), '1.000');
      expect(format(123456789, CurrencyFormat.cop), '123.456.789');
    });

    test('pads amounts smaller than one unit', () {
      expect(format(5, CurrencyFormat.usd), '0,05');
      expect(format(50, CurrencyFormat.usd), '0,50');
      expect(format(0, CurrencyFormat.usd), '0,00');
    });

    test('writes negative amounts with a leading minus', () {
      expect(format(-1200000, CurrencyFormat.cop), '-1.200.000');
      expect(format(-5, CurrencyFormat.usd), '-0,05');
    });

    test('uses custom separators and decimals', () {
      const custom = CurrencyFormat(
        decimals: 3,
        thousandsSeparator: ',',
        decimalSeparator: '.',
      );

      expect(format(1234567, custom), '1,234.567');
    });

    test('supports an empty thousands separator', () {
      const plain = CurrencyFormat(decimals: 2, thousandsSeparator: '');

      expect(format(123456789, plain), '1234567,89');
    });
  });

  group('CurrencyFormat', () {
    test('defaults follow RF-16', () {
      expect(CurrencyFormat.cop.decimals, 0);
      expect(CurrencyFormat.usd.decimals, 2);
      expect(CurrencyFormat.usd.thousandsSeparator, '.');
      expect(CurrencyFormat.usd.decimalSeparator, ',');
    });

    test('has value equality', () {
      // Built at runtime so it is not the same const instance.
      final usdLike = CurrencyFormat(decimals: CurrencyFormat.usd.decimals);

      expect(usdLike, CurrencyFormat.usd);
      expect(usdLike.hashCode, CurrencyFormat.usd.hashCode);
      expect(CurrencyFormat.cop, isNot(CurrencyFormat.usd));
    });
  });
}
