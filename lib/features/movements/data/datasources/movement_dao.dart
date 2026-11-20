import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';

part 'movement_dao.g.dart';

@DriftAccessor(tables: [Movements, Payees])
class MovementDao extends DatabaseAccessor<AppDatabase>
    with _$MovementDaoMixin {
  new(super.attachedDatabase);

  /// Movements on either side of [accountId], newest first.
  Stream<List<MovementRow>> watchByAccount(int accountId) =>
      (select(movements)
            ..where(
              (m) =>
                  m.accountId.equals(accountId) |
                  m.toAccountId.equals(accountId),
            )
            ..orderBy([
              (m) => OrderingTerm.desc(m.date),
              (m) => OrderingTerm.desc(m.id),
            ]))
          .watch();

  Future<MovementRow?> findById(int id) =>
      (select(movements)..where((m) => m.id.equals(id))).getSingleOrNull();

  Stream<List<PayeeRow>> watchPayees() =>
      (select(payees)..orderBy([(p) => OrderingTerm.asc(p.key)])).watch();

  /// Inserts the movement when its id is absent, replaces it otherwise.
  /// A payee [payeeName] is found by [payeeKey] or created first.
  Future<int> save(
    MovementsCompanion movement, {
    String? payeeName,
    String? payeeKey,
  }) => transaction(() async {
    var row = movement;
    if (payeeName != null && payeeKey != null) {
      final existing = await (select(
        payees,
      )..where((p) => p.key.equals(payeeKey))).getSingleOrNull();
      final payeeId =
          existing?.id ??
          await into(payees)
              .insert(PayeesCompanion.insert(name: payeeName, key: payeeKey));
      row = row.copyWith(payeeId: Value(payeeId));
    }
    if (!row.id.present) return await into(movements).insert(row);
    await update(movements).replace(row);
    return row.id.value;
  });

  Future<int> deleteById(int id) =>
      (delete(movements)..where((m) => m.id.equals(id))).go();
}
