import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';

part 'account_dao.g.dart';

@DriftAccessor(tables: [Accounts, Movements])
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

  /// Own balance by account id: opening balance plus movements (RT-04).
  /// Pending incomes do not count until confirmed (RF-06).
  Stream<Map<int, int>> watchBalances() => _balances().watch().map(_toMap);

  Future<Map<int, int>> getBalances() async => _toMap(await _balances().get());

  Selectable<QueryRow> _balances() => customSelect(
    """
    SELECT a.id AS id, a.opening_balance
      + COALESCE((
          SELECT SUM(CASE m.type
            WHEN 'income' THEN CASE WHEN m.is_pending THEN 0 ELSE m.amount END
            WHEN 'adjustment' THEN m.amount
            ELSE -m.amount END)
          FROM movements m WHERE m.account_id = a.id), 0)
      + COALESCE((
          SELECT SUM(m.to_amount)
          FROM movements m
          WHERE m.to_account_id = a.id AND m.type = 'transfer'), 0)
      AS balance
    FROM accounts a
    """,
    readsFrom: {accounts, movements},
  );

  static Map<int, int> _toMap(List<QueryRow> rows) => {
    for (final row in rows) row.read<int>('id'): row.read<int>('balance'),
  };

  /// Whether any movement uses [id] on either side.
  Future<bool> hasMovements(int id) async {
    final query = selectOnly(movements)
      ..addColumns([movements.id])
      ..where(movements.accountId.equals(id) | movements.toAccountId.equals(id))
      ..limit(1);
    return (await query.get()).isNotEmpty;
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
