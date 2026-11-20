import 'package:saisho_kakeibo/core/settings/app_settings.dart';

/// Ranges of the numeric settings.
abstract final class SettingsRules {
  static const int minCutoffDay = 1;

  /// Days beyond a month's length fall on its last day (31 in April → 30).
  static const int maxCutoffDay = 31;
  static const int minDaysBetweenPeriods = 1;
  static const int maxDaysBetweenPeriods = 60;
  static const int minBackupsToKeep = 3;
  static const int maxBackupsToKeep = 5;
  static const int minutesPerDay = 24 * 60;

  static bool isValid(AppSettings settings) =>
      _inRange(settings.cutoffDay, minCutoffDay, maxCutoffDay) &&
      _inRange(
        settings.minDaysBetweenPeriods,
        minDaysBetweenPeriods,
        maxDaysBetweenPeriods,
      ) &&
      _inRange(settings.backupsToKeep, minBackupsToKeep, maxBackupsToKeep) &&
      _inRange(settings.reminderMinutes, 0, minutesPerDay - 1);

  static bool _inRange(int value, int min, int max) =>
      value >= min && value <= max;
}
