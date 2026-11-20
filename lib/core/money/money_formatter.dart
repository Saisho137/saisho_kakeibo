import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';

/// Writes amounts with their currency's separators and decimals. It only
/// formats the number: the UI decides where the currency code goes.
abstract final class MoneyFormatter {
  /// `Money(4250000, 'COP')` → `4.250.000`;
  /// `Money(-125050, 'USD')` → `-1.250,50`.
  static String format(Money money, CurrencyFormat format) {
    final digits = money.minor.abs().toString().padLeft(
      format.decimals + 1,
      '0',
    );
    final integerEnd = digits.length - format.decimals;
    final integer = _groupThousands(
      digits.substring(0, integerEnd),
      format.thousandsSeparator,
    );
    final sign = money.isNegative ? '-' : '';
    if (format.decimals == 0) return '$sign$integer';
    final fraction = digits.substring(integerEnd);
    return '$sign$integer${format.decimalSeparator}$fraction';
  }

  static String _groupThousands(String digits, String separator) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(separator);
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
