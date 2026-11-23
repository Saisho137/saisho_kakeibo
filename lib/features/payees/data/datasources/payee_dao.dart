import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debts_table.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_templates_table.dart';

part 'payee_dao.g.dart';

@DriftAccessor(tables: [Payees, Movements, RecurringTemplates, Debts])
class PayeeDao extends DatabaseAccessor<AppDatabase> with _$PayeeDaoMixin {
  new(super.attachedDatabase);

  /// Renames the payee [id] and the debts that are it.
  Future<void> rename(int id, {required String name, required String key}) =>
      transaction(() async {
        await (update(payees)..where((p) => p.id.equals(id))).write(
          PayeesCompanion(name: Value(name), key: Value(key)),
        );
        await (update(debts)..where((d) => d.payeeId.equals(id))).write(
          DebtsCompanion(name: Value(name)),
        );
      });

  /// Moves everything of [from] to [into] and deletes [from].
  Future<void> merge({required int from, required int into}) =>
      transaction(() async {
        final target = await (select(
          payees,
        )..where((p) => p.id.equals(into))).getSingle();
        await (update(movements)..where((m) => m.payeeId.equals(from))).write(
          MovementsCompanion(payeeId: Value(into)),
        );
        await (update(recurringTemplates)..where((t) => t.payeeId.equals(from)))
            .write(RecurringTemplatesCompanion(payeeId: Value(into)));
        await (update(debts)..where((d) => d.payeeId.equals(from))).write(
          DebtsCompanion(payeeId: Value(into), name: Value(target.name)),
        );
        await (delete(payees)..where((p) => p.id.equals(from))).go();
      });

  /// Deletes the payee [id], leaving its movements and templates without
  /// one.
  Future<void> deletePayee(int id) => transaction(() async {
    await (update(movements)..where((m) => m.payeeId.equals(id))).write(
      const MovementsCompanion(payeeId: Value(null)),
    );
    await (update(recurringTemplates)..where((t) => t.payeeId.equals(id)))
        .write(const RecurringTemplatesCompanion(payeeId: Value(null)));
    await (delete(payees)..where((p) => p.id.equals(id))).go();
  });
}
