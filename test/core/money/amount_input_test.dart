import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';

void main() {
  const cop = CurrencyFormat.cop;
  const usd = CurrencyFormat.usd;

  AmountInput type(List<KeypadKey> keys, CurrencyFormat format) =>
      keys.fold(const AmountInput(), (input, key) => input.press(key, format));

  group('AmountInput.press', () {
    test('types digits, 000 and backspace', () {
      final input = type([
        KeypadKey.d1,
        KeypadKey.d2,
        KeypadKey.triple0,
        KeypadKey.d5,
        KeypadKey.backspace,
      ], cop);

      expect(input.raw, '12000');
      expect(input.display(cop), '12.000');
      expect(const AmountInput().press(KeypadKey.backspace, cop).isEmpty, true);
    });

    test('ignores 000 and operators without a number', () {
      expect(type([KeypadKey.triple0], cop).raw, '');
      expect(type([KeypadKey.d0, KeypadKey.triple0], cop).raw, '0');
      expect(type([KeypadKey.add], cop).raw, '');
    });

    test('replaces a leading zero', () {
      expect(type([KeypadKey.d0, KeypadKey.d7], cop).raw, '7');
    });

    test('limits decimals to the currency', () {
      expect(type([KeypadKey.d1, KeypadKey.decimal], cop).raw, '1');
      final input = type([
        KeypadKey.decimal,
        KeypadKey.d5,
        KeypadKey.decimal,
        KeypadKey.d0,
        KeypadKey.d9,
      ], usd);
      expect(input.raw, '0.50');
      expect(input.display(usd), '0,50');
    });

    test('limits the integer digits', () {
      final input = type(List.filled(15, KeypadKey.d9), cop);
      expect(input.raw, hasLength(13));
      expect(input.press(KeypadKey.triple0, cop), input);
    });

    test('replaces the last operator', () {
      final input = type([
        KeypadKey.d8,
        KeypadKey.add,
        KeypadKey.multiply,
      ], cop);
      expect(input.raw, '8*');
      expect(input.hasOperator, isTrue);
      expect(input.display(cop), '8 × ');
    });
  });

  group('AmountInput.evaluate', () {
    test('respects operator precedence', () {
      expect(const AmountInput('2+3*4').evaluate(cop), 14);
      expect(const AmountInput('10-4/2').evaluate(cop), 8);
      expect(const AmountInput('12000+3500-').evaluate(cop), 15500);
    });

    test('works in minor units and rounds divisions', () {
      expect(const AmountInput('1.5*2').evaluate(usd), 300);
      expect(const AmountInput('10/3').evaluate(usd), 333);
      expect(const AmountInput('2/3').evaluate(cop), 1);
      expect(const AmountInput('0.05').evaluate(usd), 5);
    });

    test('rejects empty, negative and division by zero', () {
      expect(const AmountInput().evaluate(cop), isNull);
      expect(const AmountInput('3-5').evaluate(cop), isNull);
      expect(const AmountInput('3/0').evaluate(cop), isNull);
    });

    test('shows every operator', () {
      expect(
        const AmountInput('1000+2-3*4/5').display(cop),
        '1.000 + 2 − 3 × 4 ÷ 5',
      );
    });
  });

  group('AmountInput.fromMinor', () {
    test('writes stored amounts back', () {
      expect(AmountInput.fromMinor(15500, cop).raw, '15500');
      expect(AmountInput.fromMinor(125050, usd).raw, '1250.5');
      expect(AmountInput.fromMinor(300, usd).raw, '3');
      expect(AmountInput.fromMinor(5, usd).raw, '0.05');
      expect(AmountInput.fromMinor(0, usd).isEmpty, isTrue);
      expect(const AmountInput('1'), const AmountInput('1'));
      expect(const AmountInput('1').hashCode, '1'.hashCode);
      expect(const AmountInput('1').toString(), 'AmountInput(1)');
    });
  });
}
