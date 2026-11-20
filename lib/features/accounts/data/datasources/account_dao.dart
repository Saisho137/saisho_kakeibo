import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';

part 'account_dao.g.dart';

@DriftAccessor(tables: [Accounts])
class AccountDao extends DatabaseAccessor<AppDatabase> with _$AccountDaoMixin {
  new(super.attachedDatabase);

  SimpleSelectStatement<$AccountsTable, AccountRow> _ordered() =>
      select(accounts)..orderBy([
        (a) => OrderingTerm.asc(a.sortOrder),
        (a) => OrderingTerm.asc(a.id),
      ]);

  Stream<List<AccountRow>> watchAll() => _ordered().watch();

  Future<List<AccountRow>> getAll() => _ordered().get();

  Future<AccountRow?> findById(int id) =>
      (select(accounts)..where((a) => a.id.equals(id))).getSingleOrNull();

  /// Own balance by account id. Movements join this query in phase 4; for
  /// now it is the opening balance.
  Stream<Map<int, int>> watchBalances() {
    final query = selectOnly(accounts)
      ..addColumns([accounts.id, accounts.openingBalance]);
    return query.watch().map(
      (rows) => {
        for (final row in rows)
          row.read(accounts.id)!: row.read(accounts.openingBalance)!,
      },
    );
  }

  Future<int> create(
    AccountsCompanion account, {
    List<AccountsCompanion> alsoSave = const [],
  }) => transaction(() async {
    await _replaceAll(alsoSave);
    return await into(accounts).insert(account);
  });

  Future<void> saveAll(List<AccountsCompanion> rows) =>
      transaction(() => _replaceAll(rows));

  Future<void> reorder(List<int> ids) => transaction(() async {
    for (final (index, id) in ids.indexed) {
      await (update(accounts)..where((a) => a.id.equals(id))).write(
        AccountsCompanion(sortOrder: Value(index)),
      );
    }
  });

  /// One statement, so pockets and their parent go together.
  Future<int> deleteAll(List<int> ids) =>
      (delete(accounts)..where((a) => a.id.isIn(ids))).go();

  Future<void> _replaceAll(List<AccountsCompanion> rows) async {
    for (final row in rows) {
      await update(accounts).replace(row);
    }
  }
}
