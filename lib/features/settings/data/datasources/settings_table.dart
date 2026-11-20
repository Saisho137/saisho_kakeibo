import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';

/// The single row of user settings (RT-02). Enums are stored by name.
@DataClassName('SettingsRow')
class SettingsTable extends Table {
  @override
  String get tableName => 'settings';

  /// Always 1: the table holds exactly one row.
  // Drift reads the column reference inside `check` at build time.
  // ignore: recursive_getters
  IntColumn get id => integer().check(id.equals(1))();

  TextColumn get mainCurrencyCode => text().references(Currencies, #code)();

  TextColumn get periodType => textEnum<PeriodType>()();

  IntColumn get cutoffDay => integer()();

  IntColumn get minDaysBetweenPeriods => integer()();

  BoolColumn get notificationsEnabled => boolean()();

  IntColumn get reminderMinutes => integer()();

  TextColumn get themeMode => textEnum<AppThemeMode>()();

  TextColumn get balanceFilter => textEnum<BalanceFilter>()();

  IntColumn get backupsToKeep => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
