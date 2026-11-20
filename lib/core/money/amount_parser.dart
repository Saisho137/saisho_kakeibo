import 'package:saisho_kakeibo/core/money/currency_format.dart';

/// Reads amounts typed with a currency's separators.
abstract final class AmountParser {
  /// Longest integer part accepted, far below the 64-bit limit.
  static const int maxIntegerDigits = 13;

  static final RegExp _digits = RegExp(r'^\d*$');

  /// `'4.250.000'` with COP → `4250000`; `'1.250,5'` with USD → `125050`.
  /// Empty text is zero. Returns `null` when [text] is not a non-negative
  /// amount in [format], such as decimals in a currency without them.
  static int? parse(String text, CurrencyFormat format) {
    var clean = text.trim();
    if (clean.isEmpty) return 0;
    if (format.thousandsSeparator.isNotEmpty) {
      clean = clean.replaceAll(format.thousandsSeparator, '');
    }
    final parts = clean.split(format.decimalSeparator);
    if (parts.length > 2) return null;
    final integer = parts.first;
    final fraction = parts.length == 2 ? parts.last : '';
    if (parts.length == 2 && format.decimals == 0) return null;
    if (!_digits.hasMatch(integer) || !_digits.hasMatch(fraction)) return null;
    if (integer.isEmpty && fraction.isEmpty) return null;
    if (integer.length > maxIntegerDigits) return null;
    if (fraction.length > format.decimals) return null;
    return int.parse(
      '${integer.isEmpty ? '0' : integer}'
      '${fraction.padRight(format.decimals, '0')}',
    );
  }
}
