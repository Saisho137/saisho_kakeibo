import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debts_table.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_templates_table.dart';

part 'debt_dao.g.dart';

@DriftAccessor(tables: [Debts, Movements, Payees, RecurringTemplates])
class DebtDao extends DatabaseAccessor<AppDatabase> with _$DebtDaoMixin {
  new(super.attachedDatabase);

  SimpleSelectStatement<$DebtsTable, DebtRow> _ordered() => select(debts)
    ..orderBy([(d) => OrderingTerm.asc(d.type), (d) => OrderingTerm.asc(d.id)]);

  Stream<List<DebtRow>> watchDebts() => _ordered().watch();

  Future<List<DebtRow>> getDebts() => _ordered().get();

  Future<DebtRow?> findDebt(int id) =>
      (select(debts)..where((d) => d.id.equals(id))).getSingleOrNull();

  /// Inserts the debt when its id is absent, replaces it otherwise. A
  /// payee [payeeName] is found by [payeeKey] or created first, and the
  /// movements and templates of the debt take it too.
  Future<int> saveDebt(
    DebtsCompanion debt, {
    String? payeeName,
    String? payeeKey,
  }) => transaction(() async {
    var row = debt;
    int? payeeId;
    if (payeeName != null && payeeKey != null) {
      final existing = await (select(
        payees,
      )..where((p) => p.key.equals(payeeKey))).getSingleOrNull();
      payeeId =
          existing?.id ??
          await into(payees)
              .insert(PayeesCompanion.insert(name: payeeName, key: payeeKey));
      row = row.copyWith(payeeId: Value(payeeId));
    }
    if (!row.id.present) return await into(debts).insert(row);
    final id = row.id.value;
    await update(debts).replace(row);
    if (payeeId != null) {
      await (update(movements)..where((m) => m.debtId.equals(id))).write(
        MovementsCompanion(payeeId: Value(payeeId)),
      );
      await (update(recurringTemplates)..where((t) => t.debtId.equals(id)))
          .write(RecurringTemplatesCompanion(payeeId: Value(payeeId)));
    }
    return id;
  });

  Future<List<MovementRow>> getMovements(int debtId) =>
      (select(movements)
            ..where((m) => m.debtId.equals(debtId))
            ..orderBy([
              (m) => OrderingTerm.desc(m.date),
              (m) => OrderingTerm.desc(m.id),
            ]))
          .get();

  Future<int> deleteDebt(int id) =>
      (delete(debts)..where((d) => d.id.equals(id))).go();
}
