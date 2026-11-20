import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';

part 'currency_dao.g.dart';

@DriftAccessor(tables: [Currencies, Accounts])
class CurrencyDao extends DatabaseAccessor<AppDatabase>
    with _$CurrencyDaoMixin {
  new(super.attachedDatabase);

  SimpleSelectStatement<$CurrenciesTable, CurrencyRow> _ordered() =>
      select(currencies)..orderBy([
        (c) => OrderingTerm.desc(c.isBuiltIn),
        (c) => OrderingTerm.asc(c.code),
      ]);

  Stream<List<CurrencyRow>> watchAll() => _ordered().watch();

  Future<List<CurrencyRow>> getAll() => _ordered().get();

  Future<CurrencyRow?> findByCode(String code) =>
      (select(currencies)..where((c) => c.code.equals(code))).getSingleOrNull();

  /// Whether any account, archived included, uses [code].
  Future<bool> isUsedByAccounts(String code) async {
    final count = accounts.id.count();
    final query = selectOnly(accounts)
      ..addColumns([count])
      ..where(accounts.currencyCode.equals(code));
    return (await query.getSingle()).read(count)! > 0;
  }

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
