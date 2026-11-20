import 'package:meta/meta.dart';

/// How a currency's amounts are written (RF-16). Separators are only
/// formatting; [decimals] also defines the minor unit and never changes
/// after the currency is created.
@immutable
final class CurrencyFormat {
  const new({
    required this.decimals,
    this.thousandsSeparator = '.',
    this.decimalSeparator = ',',
  }) : assert(decimals >= 0, 'decimals cannot be negative'),
       assert(
         thousandsSeparator != decimalSeparator,
         'separators must be different',
       );

  /// Colombian pesos: `4.250.000`.
  static const CurrencyFormat cop = CurrencyFormat(decimals: 0);

  /// US dollars with Colombian separators: `1.250,50`.
  static const CurrencyFormat usd = CurrencyFormat(decimals: 2);

  final int decimals;
  final String thousandsSeparator;
  final String decimalSeparator;

  @override
  bool operator ==(Object other) =>
      other is CurrencyFormat &&
      other.decimals == decimals &&
      other.thousandsSeparator == thousandsSeparator &&
      other.decimalSeparator == decimalSeparator;

  @override
  int get hashCode =>
      Object.hash(decimals, thousandsSeparator, decimalSeparator);
}
