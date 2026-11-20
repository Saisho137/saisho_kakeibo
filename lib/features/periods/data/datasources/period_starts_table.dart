import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';

/// Manual period starts, from Settings → Periods → Advanced (RF-05).
/// Salaries that start a period are flagged on their movement instead.
@DataClassName('PeriodStartRow')
class PeriodStarts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get date => text().map(const LocalDateConverter()).unique()();
}
