/// A rule broken by a currency's fields (RF-16).
enum CurrencyError {
  invalidCode,
  duplicateCode,
  invalidSymbol,
  invalidDecimals,
  invalidThousandsSeparator,
  invalidDecimalSeparator,
  sameSeparators,
}

/// Allowed values for a currency's fields.
abstract final class CurrencyRules {
  static const int maxDecimals = 4;
  static const int maxSymbolLength = 4;

  /// Dot, comma, space or none.
  static const List<String> thousandsSeparators = ['.', ',', ' ', ''];

  static const List<String> decimalSeparators = [',', '.'];

  static final RegExp _code = RegExp(r'^[A-Z]{3}$');

  /// Every rule broken by the given fields; empty when they are valid.
  static Set<CurrencyError> validate({
    required String code,
    required String symbol,
    required int decimals,
    required String thousandsSeparator,
    required String decimalSeparator,
    Iterable<String> existingCodes = const [],
  }) {
    final trimmedSymbol = symbol.trim();
    return {
      if (!_code.hasMatch(code)) CurrencyError.invalidCode,
      if (existingCodes.contains(code)) CurrencyError.duplicateCode,
      if (trimmedSymbol.isEmpty || trimmedSymbol.runes.length > maxSymbolLength)
        CurrencyError.invalidSymbol,
      if (decimals < 0 || decimals > maxDecimals) CurrencyError.invalidDecimals,
      if (!thousandsSeparators.contains(thousandsSeparator))
        CurrencyError.invalidThousandsSeparator,
      if (!decimalSeparators.contains(decimalSeparator))
        CurrencyError.invalidDecimalSeparator,
      if (thousandsSeparator == decimalSeparator) CurrencyError.sameSeparators,
    };
  }
}
