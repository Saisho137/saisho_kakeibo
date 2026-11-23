import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/accounts_injection.dart';
import 'package:saisho_kakeibo/features/categories/categories_injection.dart';
import 'package:saisho_kakeibo/features/debts/debts_injection.dart';
import 'package:saisho_kakeibo/features/home/home_injection.dart';
import 'package:saisho_kakeibo/features/movements/movements_injection.dart';
import 'package:saisho_kakeibo/features/periods/periods_injection.dart';
import 'package:saisho_kakeibo/features/recurring/recurring_injection.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/reminders_injection.dart';
import 'package:saisho_kakeibo/features/settings/settings_injection.dart';

/// Global service locator.
final GetIt getIt = GetIt.instance;

/// Registers app-wide dependencies, then each feature's own.
///
/// Tests can pass an in-memory [database], a fixed [appInfo] and a fake
/// [reminderScheduler].
Future<void> configureDependencies({
  AppDatabase? database,
  AppInfo? appInfo,
  ReminderScheduler? reminderScheduler,
}) async {
  getIt.registerSingleton<AppInfo>(appInfo ?? await AppInfo.load());
  getIt.registerLazySingleton<AppDatabase>(
    () => database ?? AppDatabase(),
    dispose: (db) => db.close(),
  );
  registerSettingsDependencies(getIt);
  registerAccountsDependencies(getIt);
  registerCategoriesDependencies(getIt);
  registerMovementsDependencies(getIt);
  registerPeriodsDependencies(getIt);
  registerRecurringDependencies(getIt);
  registerDebtsDependencies(getIt);
  registerHomeDependencies(getIt);
  registerRemindersDependencies(getIt, scheduler: reminderScheduler);
}
