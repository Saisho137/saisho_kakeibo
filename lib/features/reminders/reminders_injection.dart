import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/features/reminders/data/local_reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/usecases/sync_reminders.dart';
import 'package:saisho_kakeibo/features/reminders/presentation/reminder_sync.dart';

/// Registers the reminders. They read the other features, so they go last.
/// Tests can pass a [scheduler] instead of the platform one.
void registerRemindersDependencies(
  GetIt getIt, {
  ReminderScheduler? scheduler,
}) {
  getIt
    ..registerLazySingleton<ReminderScheduler>(
      () => scheduler ?? LocalReminderScheduler(),
    )
    ..registerFactory(
      () => SyncReminders(
        settings: getIt(),
        recurring: getIt(),
        accounts: getIt(),
        categories: getIt(),
        movements: getIt(),
        currencies: getIt(),
        scheduler: getIt(),
      ),
    )
    ..registerLazySingleton(
      () => ReminderSync(
        watchSettings: getIt(),
        watchTemplates: getIt(),
        watchAccounts: getIt(),
        syncReminders: getIt(),
        scheduler: getIt(),
      ),
      dispose: (sync) => sync.dispose(),
    );
}
