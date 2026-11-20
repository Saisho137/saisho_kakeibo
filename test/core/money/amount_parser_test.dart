import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';

void main() {
  group('AmountParser', () {
    test('reads amounts without decimals', () {
      expect(AmountParser.parse('4.250.000', CurrencyFormat.cop), 4250000);
      expect(AmountParser.parse(' 350000 ', CurrencyFormat.cop), 350000);
    });

    test('reads decimals and pads them to the minor unit', () {
      expect(AmountParser.parse('1.250,5', CurrencyFormat.usd), 125050);
      expect(AmountParser.parse('0,99', CurrencyFormat.usd), 99);
      expect(AmountParser.parse(',5', CurrencyFormat.usd), 50);
      expect(AmountParser.parse('12', CurrencyFormat.usd), 1200);
    });

    test('uses the separators of the format', () {
      const format = CurrencyFormat(
        decimals: 2,
        thousandsSeparator: ' ',
        decimalSeparator: '.',
      );

      expect(AmountParser.parse('1 234.56', format), 123456);
    });

    test('reads empty text as zero', () {
      expect(AmountParser.parse('  ', CurrencyFormat.cop), 0);
    });

    test('rejects what is not an amount of the format', () {
      for (final text in ['abc', '-5', '1,5', ',']) {
        expect(
          AmountParser.parse(text, CurrencyFormat.cop),
          isNull,
          reason: text,
        );
      }
      for (final text in ['1,234', '1,2,3', '12345678901234']) {
        expect(
          AmountParser.parse(text, CurrencyFormat.usd),
          isNull,
          reason: text,
        );
      }
    });
  });
}
