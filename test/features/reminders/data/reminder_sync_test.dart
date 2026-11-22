import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/usecases/sync_reminders.dart';
import 'package:saisho_kakeibo/features/reminders/presentation/reminder_sync.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

class _MockWatchSettings extends Mock implements WatchSettings;

class _MockWatchTemplates extends Mock implements WatchRecurringTemplates;

class _MockWatchAccounts extends Mock implements WatchAccounts;

class _MockSync extends Mock implements SyncReminders;

class _MockScheduler extends Mock implements ReminderScheduler;

void main() {
  late _MockWatchSettings watchSettings;
  late _MockWatchTemplates watchTemplates;
  late _MockWatchAccounts watchAccounts;
  late _MockSync syncReminders;
  late _MockScheduler scheduler;
  late StreamController<AppSettings> settings;
  late StreamController<List<RecurringTemplate>> templates;
  late StreamController<List<Account>> accounts;

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(LocalDate(2026, 1, 1));
  });

  setUp(() {
    watchSettings = _MockWatchSettings();
    watchTemplates = _MockWatchTemplates();
    watchAccounts = _MockWatchAccounts();
    syncReminders = _MockSync();
    scheduler = _MockScheduler();
    settings = StreamController();
    templates = StreamController();
    accounts = StreamController();
    when(() => watchSettings(any())).thenAnswer((_) => settings.stream);
    when(() => watchTemplates(any())).thenAnswer((_) => templates.stream);
    when(() => watchAccounts(any())).thenAnswer((_) => accounts.stream);
    when(() => syncReminders(any())).thenAnswer((_) async => const Ok(2));
    when(() => scheduler.requestPermission()).thenAnswer((_) async => true);
  });

  ReminderSync build() => ReminderSync(
    watchSettings: watchSettings,
    watchTemplates: watchTemplates,
    watchAccounts: watchAccounts,
    syncReminders: syncReminders,
    scheduler: scheduler,
    delay: const Duration(milliseconds: 20),
  );

  Future<void> wait([int ms = 100]) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  group('ReminderSync', () {
    test('reschedules once after a burst of changes', () async {
      final sync = build()..start();
      settings.add(const AppSettings());
      templates.add(const []);
      accounts.add(const []);
      await wait(5);
      accounts.add(const []);
      await wait();

      verify(() => syncReminders(LocalDate.today())).called(1);
      verify(() => scheduler.requestPermission()).called(1);

      settings.add(const AppSettings(reminderMinutes: 9 * 60));
      await wait();
      verify(() => syncReminders(any())).called(1);
      // The permission is asked only once.
      verifyNever(() => scheduler.requestPermission());
      await sync.dispose();
    });

    test('asks nothing without reminders and logs failures', () async {
      when(() => syncReminders(any())).thenAnswer((_) async => const Ok(0));
      final sync = build();
      await sync.sync();
      verifyNever(() => scheduler.requestPermission());

      when(() => syncReminders(any()))
          .thenAnswer((_) async => const Err(UnexpectedFailure('no plugin')));
      await sync.sync();
      verifyNever(() => scheduler.requestPermission());
    });

    test('a failed permission request does not break', () async {
      when(() => scheduler.requestPermission())
          .thenThrow(Exception('no plugin'));
      await build().sync();
      verify(() => scheduler.requestPermission()).called(1);
    });

    test('stream errors are only logged', () async {
      final sync = build()..start();
      settings.addError(Exception('disk'));
      await wait();
      verifyNever(() => syncReminders(any()));
      await sync.dispose();
    });
  });
}
