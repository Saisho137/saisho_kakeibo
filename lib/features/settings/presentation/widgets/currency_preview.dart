import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';

/// Formats a sample amount (1234567 and a fraction) with [format], so the
/// user sees the effect of the separators and decimals.
String currencyPreview(CurrencyFormat format) {
  const fraction = '8901';
  final minor = int.parse('1234567${fraction.substring(0, format.decimals)}');
  return MoneyFormatter.format(Money(minor, ''), format);
}
