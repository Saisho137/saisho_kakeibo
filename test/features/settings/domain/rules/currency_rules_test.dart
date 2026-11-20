import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';

void main() {
  Set<CurrencyError> validate({
    String code = 'EUR',
    String symbol = '€',
    int decimals = 2,
    String thousandsSeparator = '.',
    String decimalSeparator = ',',
    List<String> existingCodes = const [],
  }) => CurrencyRules.validate(
    code: code,
    symbol: symbol,
    decimals: decimals,
    thousandsSeparator: thousandsSeparator,
    decimalSeparator: decimalSeparator,
    existingCodes: existingCodes,
  );

  group('CurrencyRules.validate', () {
    test('accepts a valid currency', () {
      expect(validate(), isEmpty);
    });

    test('requires a code of three uppercase letters', () {
      for (final code in ['EU', 'EURO', 'eur', 'E1R', '']) {
        expect(validate(code: code), {CurrencyError.invalidCode}, reason: code);
      }
    });

    test('rejects an existing code', () {
      expect(validate(existingCodes: ['EUR']), {CurrencyError.duplicateCode});
    });

    test('requires a symbol of one to four characters', () {
      expect(validate(symbol: '  '), {CurrencyError.invalidSymbol});
      expect(validate(symbol: 'EURO€'), {CurrencyError.invalidSymbol});
      expect(validate(symbol: r' US$ '), isEmpty);
    });

    test('allows zero to four decimals', () {
      expect(validate(decimals: 0), isEmpty);
      expect(validate(decimals: 4), isEmpty);
      expect(validate(decimals: 5), {CurrencyError.invalidDecimals});
      expect(validate(decimals: -1), {CurrencyError.invalidDecimals});
    });

    test('allows only the listed separators', () {
      for (final separator in ['.', ',', ' ', '']) {
        expect(
          validate(
            thousandsSeparator: separator,
            decimalSeparator: '|',
          ).difference({CurrencyError.invalidDecimalSeparator}),
          isEmpty,
          reason: 'thousands "$separator"',
        );
      }
      expect(validate(thousandsSeparator: "'"), {
        CurrencyError.invalidThousandsSeparator,
      });
      expect(validate(decimalSeparator: ' '), {
        CurrencyError.invalidDecimalSeparator,
      });
    });

    test('requires different separators', () {
      expect(validate(thousandsSeparator: ','), {CurrencyError.sameSeparators});
    });
  });
}
