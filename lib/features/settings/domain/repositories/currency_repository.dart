import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';

/// Contract implemented by the data layer.
abstract interface class CurrencyRepository {
  /// Built-in currencies first, then by code.
  Stream<List<Currency>> watchCurrencies();

  /// Built-in currencies first, then by code.
  Future<Result<List<Currency>>> getCurrencies();

  Future<Result<Currency?>> findByCode(String code);

  /// Whether any account, archived included, uses the currency.
  Future<Result<bool>> isInUse(String code);

  Future<Result<void>> create(Currency currency);

  /// Saves the symbol and separators; code and decimals never change.
  Future<Result<void>> update(Currency currency);

  Future<Result<void>> delete(String code);
}
