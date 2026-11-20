import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// How the Home groups movements over time (RF-14).
enum PeriodType { dynamic, monthly, yearly }

/// Theme choice; [system] follows the device.
enum AppThemeMode { system, light, dark }

/// Accounts summed by the Home Balance (RF-17).
enum BalanceFilter { cash, bank, both }

/// User configuration. It lives in the database so it travels in backups
/// (RT-02).
@freezed
abstract class AppSettings with _$AppSettings {
  const factory({
    @Default('COP') String mainCurrencyCode,
    @Default(PeriodType.dynamic) PeriodType periodType,

    /// Start day of monthly periods and fallback of dynamic ones (RF-05).
    @Default(27) int cutoffDay,

    /// Days since the last period start before Salary suggests a new one.
    @Default(21) int minDaysBetweenPeriods,
    @Default(true) bool notificationsEnabled,

    /// Time of every reminder, in minutes after midnight (RT-11).
    @Default(8 * 60) int reminderMinutes,
    @Default(AppThemeMode.system) AppThemeMode themeMode,
    @Default(BalanceFilter.both) BalanceFilter balanceFilter,
    @Default(3) int backupsToKeep,
  }) = _AppSettings;
}
