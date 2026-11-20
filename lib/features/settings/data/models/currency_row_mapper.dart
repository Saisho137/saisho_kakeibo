import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';

extension CurrencyRowMapper on CurrencyRow {
  Currency toEntity() => Currency(
    code: code,
    symbol: symbol,
    format: CurrencyFormat(
      decimals: decimals,
      thousandsSeparator: thousandsSeparator,
      decimalSeparator: decimalSeparator,
    ),
    isBuiltIn: isBuiltIn,
  );
}

extension CurrencyCompanionMapper on Currency {
  CurrenciesCompanion toCompanion() => CurrenciesCompanion.insert(
    code: code,
    symbol: symbol,
    decimals: format.decimals,
    thousandsSeparator: format.thousandsSeparator,
    decimalSeparator: format.decimalSeparator,
    isBuiltIn: Value(isBuiltIn),
  );
}
