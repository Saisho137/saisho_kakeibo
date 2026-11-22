import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_occurrences_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_templates_table.dart';

part 'recurring_dao.g.dart';

@DriftAccessor(
  tables: [RecurringTemplates, RecurringOccurrences, Movements, Payees],
)
class RecurringDao extends DatabaseAccessor<AppDatabase>
    with _$RecurringDaoMixin {
  new(super.attachedDatabase);

  SimpleSelectStatement<$RecurringTemplatesTable, RecurringTemplateRow>
  _ordered() => select(recurringTemplates)
    ..orderBy([(t) => OrderingTerm.asc(t.type), (t) => OrderingTerm.asc(t.id)]);

  Stream<List<RecurringTemplateRow>> watchTemplates() => _ordered().watch();

  Future<List<RecurringTemplateRow>> getTemplates() => _ordered().get();

  Future<RecurringTemplateRow?> findTemplate(int id) => (select(
    recurringTemplates,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserts the template when its id is absent, replaces it otherwise.
  /// A payee [payeeName] is found by [payeeKey] or created first.
  Future<int> saveTemplate(
    RecurringTemplatesCompanion template, {
    String? payeeName,
    String? payeeKey,
  }) => transaction(() async {
    var row = template;
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
    if (!row.id.present) return await into(recurringTemplates).insert(row);
    await update(recurringTemplates).replace(row);
    return row.id.value;
  });

  Future<int> updateAmount(int id, int amount, int? toAmount) =>
      (update(recurringTemplates)..where((t) => t.id.equals(id))).write(
        RecurringTemplatesCompanion(
          amount: Value(amount),
          toAmount: Value(toAmount),
        ),
      );

  Future<int> deleteTemplate(int id) =>
      (delete(recurringTemplates)..where((t) => t.id.equals(id))).go();

  Future<List<RecurringOccurrenceRow>> getOccurrences() =>
      select(recurringOccurrences).get();

  /// Inserts each new occurrence with its movement; existing ones are
  /// skipped. Returns the movements created.
  Future<int> materialize(
    List<(int templateId, LocalDate periodStart, MovementsCompanion)> items,
  ) => transaction(() async {
    var created = 0;
    for (final (templateId, periodStart, movement) in items) {
      final existing =
          await (select(recurringOccurrences)..where(
                (o) =>
                    o.templateId.equals(templateId) &
                    o.periodStart.equalsValue(periodStart),
              ))
              .getSingleOrNull();
      if (existing != null) continue;
      await into(recurringOccurrences).insert(
        RecurringOccurrencesCompanion.insert(
          templateId: templateId,
          periodStart: periodStart,
        ),
      );
      await into(movements).insert(movement);
      created++;
    }
    return created;
  });
}
