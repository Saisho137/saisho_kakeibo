import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';

extension SettingsRowMapper on SettingsRow {
  AppSettings toEntity() => AppSettings(
    mainCurrencyCode: mainCurrencyCode,
    periodType: periodType,
    cutoffDay: cutoffDay,
    minDaysBetweenPeriods: minDaysBetweenPeriods,
    notificationsEnabled: notificationsEnabled,
    reminderMinutes: reminderMinutes,
    themeMode: themeMode,
    balanceFilter: balanceFilter,
    backupsToKeep: backupsToKeep,
  );
}

extension SettingsCompanionMapper on AppSettings {
  SettingsTableCompanion toCompanion() => SettingsTableCompanion(
    mainCurrencyCode: Value(mainCurrencyCode),
    periodType: Value(periodType),
    cutoffDay: Value(cutoffDay),
    minDaysBetweenPeriods: Value(minDaysBetweenPeriods),
    notificationsEnabled: Value(notificationsEnabled),
    reminderMinutes: Value(reminderMinutes),
    themeMode: Value(themeMode),
    balanceFilter: Value(balanceFilter),
    backupsToKeep: Value(backupsToKeep),
  );
}
