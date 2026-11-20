import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
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

  SimpleSelectStatement<$PayeesTable, PayeeRow> _payeesByKey() =>
      select(payees)..orderBy([(p) => OrderingTerm.asc(p.key)]);

  Stream<List<PayeeRow>> watchPayees() => _payeesByKey().watch();

  Future<List<PayeeRow>> getPayees() => _payeesByKey().get();

  /// Latest movement of [categoryId], for prefilling its form.
  Future<MovementRow?> lastOfCategory(int categoryId) =>
      (select(movements)
            ..where((m) => m.categoryId.equals(categoryId))
            ..orderBy([
              (m) => OrderingTerm.desc(m.date),
              (m) => OrderingTerm.desc(m.id),
            ])
            ..limit(1))
          .getSingleOrNull();

  /// Latest movement of [type] of every payee that has one.
  Future<List<MovementRow>> lastOfEachPayee(String type) => customSelect(
    '''
    SELECT m.* FROM movements m
    WHERE m.type = ?1 AND m.payee_id IS NOT NULL AND m.id = (
      SELECT l.id FROM movements l
      WHERE l.payee_id = m.payee_id AND l.type = ?1
      ORDER BY l.date DESC, l.id DESC LIMIT 1)
    ''',
    variables: [Variable.withString(type)],
    readsFrom: {movements},
  ).map((row) => movements.map(row.data)).get();

  /// Date of the latest movement that started a period (RF-05).
  Future<LocalDate?> lastPeriodStart() async {
    final latest = movements.date.max();
    final query = selectOnly(movements)
      ..addColumns([latest])
      ..where(movements.startsPeriod.equals(true));
    final row = await query.getSingle();
    final value = row.read(latest);
    return value == null ? null : LocalDate.parse(value);
  }

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
