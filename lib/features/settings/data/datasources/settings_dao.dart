import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/settings_table.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [SettingsTable])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  new(super.attachedDatabase);

  static const int rowId = 1;

  SimpleSelectStatement<$SettingsTableTable, SettingsRow> get _row =>
      select(settingsTable)..where((s) => s.id.equals(rowId));

  Stream<SettingsRow> watch() => _row.watchSingle();

  Future<SettingsRow> get() => _row.getSingle();

  Future<void> write(SettingsTableCompanion settings) =>
      into(settingsTable)
          .insertOnConflictUpdate(settings.copyWith(id: const Value(rowId)));
}
