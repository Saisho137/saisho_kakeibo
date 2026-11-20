import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';

part 'currency_dao.g.dart';

@DriftAccessor(tables: [Currencies])
class CurrencyDao extends DatabaseAccessor<AppDatabase>
    with _$CurrencyDaoMixin {
  new(super.attachedDatabase);

  Stream<List<CurrencyRow>> watchAll() =>
      (select(currencies)..orderBy([
            (c) => OrderingTerm.desc(c.isBuiltIn),
            (c) => OrderingTerm.asc(c.code),
          ]))
          .watch();

  Future<CurrencyRow?> findByCode(String code) =>
      (select(currencies)..where((c) => c.code.equals(code))).getSingleOrNull();

  Future<void> insertCurrency(CurrenciesCompanion currency) =>
      into(currencies).insert(currency);

  /// Writes only the editable columns: symbol and separators.
  Future<int> updateFormat(
    String code, {
    required String symbol,
    required String thousandsSeparator,
    required String decimalSeparator,
  }) => (update(currencies)..where((c) => c.code.equals(code))).write(
    CurrenciesCompanion(
      symbol: Value(symbol),
      thousandsSeparator: Value(thousandsSeparator),
      decimalSeparator: Value(decimalSeparator),
    ),
  );

  Future<int> deleteByCode(String code) =>
      (delete(currencies)..where((c) => c.code.equals(code))).go();
}
