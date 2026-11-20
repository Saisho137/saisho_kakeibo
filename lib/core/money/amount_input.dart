import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';

/// A key of the amount keypad (RF-01).
enum KeypadKey {
  d0,
  d1,
  d2,
  d3,
  d4,
  d5,
  d6,
  d7,
  d8,
  d9,

  /// Shown instead of [decimal] for currencies without decimals.
  triple0,
  decimal,
  add,
  subtract,
  multiply,
  divide,
  backspace;

  bool get isOperator =>
      this == add || this == subtract || this == multiply || this == divide;
}

/// What the user typed on the keypad: numbers and the operations between
/// them, such as `12000+3500`. It is kept as text with `.` as the decimal
/// point and evaluated in the minor unit of the currency.
@immutable
final class AmountInput {
  const new([this.raw = '']);

  /// The typed amount of [minor], ready to keep typing.
  factory fromMinor(int minor, CurrencyFormat format) {
    if (minor <= 0) return const AmountInput();
    if (format.decimals == 0) return AmountInput('$minor');
    final digits = '$minor'.padLeft(format.decimals + 1, '0');
    final cut = digits.length - format.decimals;
    final fraction = digits.substring(cut).replaceFirst(RegExp(r'0+$'), '');
    final integer = digits.substring(0, cut);
    return AmountInput(fraction.isEmpty ? integer : '$integer.$fraction');
  }

  final String raw;

  static const String _operators = '+-*/';

  // Splits `12+3.5` into `12`, `+` and `3.5`.
  static final RegExp _tokens = RegExp('(?=[+*/-])|(?<=[+*/-])');

  bool get isEmpty => raw.isEmpty;

  bool get hasOperator => raw.split('').any(_operators.contains);

  /// The number being typed, after the last operator.
  String get _current {
    final last = raw.lastIndexOf(RegExp('[+*/-]'));
    return raw.substring(last + 1);
  }

  AmountInput press(KeypadKey key, CurrencyFormat format) {
    final current = _current;
    final dot = current.indexOf('.');
    switch (key) {
      case KeypadKey.backspace:
        return isEmpty ? this : AmountInput(raw.substring(0, raw.length - 1));
      case KeypadKey.decimal:
        if (format.decimals == 0 || dot >= 0) return this;
        return AmountInput('$raw${current.isEmpty ? '0' : ''}.');
      case KeypadKey.triple0:
        if (current.isEmpty || current == '0') return this;
        return _withDigits('000', current, dot, format);
      case _ when key.isOperator:
        if (isEmpty) return this;
        final symbol = switch (key) {
          KeypadKey.add => '+',
          KeypadKey.subtract => '-',
          KeypadKey.multiply => '*',
          _ => '/',
        };
        final trimmed = current.isEmpty
            ? raw.substring(0, raw.length - 1)
            : raw;
        return AmountInput('$trimmed$symbol');
      case _:
        return _withDigits('${key.index}', current, dot, format);
    }
  }

  AmountInput _withDigits(
    String digits,
    String current,
    int dot,
    CurrencyFormat format,
  ) {
    if (dot >= 0) {
      final room = format.decimals - (current.length - dot - 1);
      if (room < digits.length) return this;
    } else {
      final integer = current == '0' ? '' : current;
      if (integer.length + digits.length > AmountParser.maxIntegerDigits) {
        return this;
      }
      if (current == '0') {
        return AmountInput('${raw.substring(0, raw.length - 1)}$digits');
      }
    }
    return AmountInput('$raw$digits');
  }

  /// Result in minor units, rounding divisions half up. A trailing
  /// operator is ignored. `null` when empty, dividing by zero or below
  /// zero.
  int? evaluate(CurrencyFormat format) {
    var text = raw;
    if (text.isNotEmpty && _operators.contains(text[text.length - 1])) {
      text = text.substring(0, text.length - 1);
    }
    if (text.isEmpty) return null;
    final scale = BigInt.from(10).pow(format.decimals);
    final numbers = <BigInt>[];
    final operators = <String>[];
    for (final part in text.split(_tokens)) {
      if (part.length == 1 && _operators.contains(part)) {
        operators.add(part);
      } else {
        numbers.add(_toMinor(part, format.decimals));
      }
    }
    // Multiplications and divisions first, then sums and subtractions.
    final terms = [numbers.first];
    final signs = <String>[];
    for (final (i, op) in operators.indexed) {
      final next = numbers[i + 1];
      if (op == '*' || op == '/') {
        final left = terms.removeLast();
        if (op == '/' && next == BigInt.zero) return null;
        terms.add(
          op == '*' ? _round(left * next, scale) : _round(left * scale, next),
        );
      } else {
        terms.add(next);
        signs.add(op);
      }
    }
    var total = terms.first;
    for (final (i, sign) in signs.indexed) {
      total = sign == '+' ? total + terms[i + 1] : total - terms[i + 1];
    }
    if (total < BigInt.zero || !total.isValidInt) return null;
    return total.toInt();
  }

  static BigInt _toMinor(String number, int decimals) {
    final parts = number.split('.');
    final fraction = (parts.length > 1 ? parts[1] : '').padRight(decimals, '0');
    return BigInt.parse('${parts[0].isEmpty ? '0' : parts[0]}$fraction');
  }

  static BigInt _round(BigInt numerator, BigInt denominator) =>
      (numerator * BigInt.two + denominator) ~/ (denominator * BigInt.two);

  /// The typed text with the currency's separators and the keypad symbols:
  /// `12000+3,5` → `12.000 + 3,5`.
  String display(CurrencyFormat format) {
    final buffer = StringBuffer();
    for (final part in raw.split(_tokens)) {
      if (part.isEmpty) continue;
      if (part.length == 1 && _operators.contains(part)) {
        buffer.write(switch (part) {
          '+' => ' + ',
          '-' => ' − ',
          '*' => ' × ',
          _ => ' ÷ ',
        });
        continue;
      }
      final [integer, ...fraction] = part.split('.');
      buffer.write(_group(integer, format.thousandsSeparator));
      if (fraction.isNotEmpty) {
        buffer.write('${format.decimalSeparator}${fraction.first}');
      }
    }
    return buffer.toString();
  }

  static String _group(String digits, String separator) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(separator);
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  bool operator ==(Object other) => other is AmountInput && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => 'AmountInput($raw)';
}
