import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_templates_table.dart';

/// The periods each template already created its movement for. It keeps
/// materializing idempotent, even after a pending movement is cancelled
/// (RT-07).
@DataClassName('RecurringOccurrenceRow')
class RecurringOccurrences extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get templateId => integer().references(
    RecurringTemplates,
    #id,
    onDelete: KeyAction.cascade,
  )();

  TextColumn get periodStart => text().map(const LocalDateConverter())();

  /// The movement it created; `null` once that movement is deleted.
  IntColumn get movementId => integer().nullable().references(
    Movements,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {templateId, periodStart},
  ];
}
