import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currency_dao.dart';
import 'package:saisho_kakeibo/features/settings/data/models/currency_row_mapper.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  const new(this._dao);

  final CurrencyDao _dao;

  @override
  Stream<List<Currency>> watchCurrencies() => _dao.watchAll().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<List<Currency>>> getCurrencies() => guardDatabase(
    () async => (await _dao.getAll())
        .map((row) => row.toEntity())
        .toList(growable: false),
  );

  @override
  Future<Result<Currency?>> findByCode(String code) =>
      guardDatabase(() async => (await _dao.findByCode(code))?.toEntity());

  @override
  Future<Result<bool>> isInUse(String code) =>
      guardDatabase(() => _dao.isUsedByAccounts(code));

  @override
  Future<Result<void>> create(Currency currency) =>
      guardDatabase(() => _dao.insertCurrency(currency.toCompanion()));

  @override
  Future<Result<void>> update(Currency currency) => guardDatabase(
    () => _dao.updateFormat(
      currency.code,
      symbol: currency.symbol,
      thousandsSeparator: currency.format.thousandsSeparator,
      decimalSeparator: currency.format.decimalSeparator,
    ),
  );

  @override
  Future<Result<void>> delete(String code) =>
      guardDatabase(() => _dao.deleteByCode(code));
}
