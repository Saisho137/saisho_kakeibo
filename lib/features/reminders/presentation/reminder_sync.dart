import 'dart:async';
import 'dart:developer';

import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/usecases/sync_reminders.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

/// Keeps the scheduled reminders in step with the data (RT-11): it
/// reschedules them when the app starts and whenever the settings, the
/// recurring templates, the accounts, the debts or the movements change,
/// waiting for a quiet moment so a burst of changes reschedules once. The
/// first time there is something to remind, it asks for the notification
/// permission.
class ReminderSync {
  new({
    required this._watchSettings,
    required this._watchTemplates,
    required this._watchAccounts,
    required this._watchDebts,
    required this._watchMovements,
    required this._syncReminders,
    required this._scheduler,
    this.delay = const Duration(milliseconds: 500),
  });

  final WatchSettings _watchSettings;
  final WatchRecurringTemplates _watchTemplates;
  final WatchAccounts _watchAccounts;
  final WatchDebts _watchDebts;
  final WatchMovements _watchMovements;
  final SyncReminders _syncReminders;
  final ReminderScheduler _scheduler;

  /// How long to wait after the last change before rescheduling.
  final Duration delay;

  final List<StreamSubscription<Object>> _subscriptions = [];
  Timer? _timer;
  bool _askedPermission = false;

  void start() {
    void changed(Object _) => _schedule();
    void failed(Object error) => log('Reminder data failed: $error');
    _subscriptions.addAll([
      _watchSettings(const NoParams()).listen(changed, onError: failed),
      _watchTemplates(const NoParams()).listen(changed, onError: failed),
      _watchAccounts(const NoParams()).listen(changed, onError: failed),
      _watchDebts(const NoParams()).listen(changed, onError: failed),
      // A payment can settle a debt and silence its reminder.
      _watchMovements(const NoParams()).listen(changed, onError: failed),
    ]);
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(delay, () => unawaited(sync()));
  }

  /// Reschedules now.
  Future<void> sync() async {
    switch (await _syncReminders(LocalDate.today())) {
      case Ok(:final value) when value > 0 && !_askedPermission:
        _askedPermission = true;
        try {
          await _scheduler.requestPermission();
        } on Exception catch (e) {
          log('Notification permission failed: $e');
        }
      case Ok():
        break;
      case Err(:final failure):
        log('Rescheduling reminders failed: ${failure.message}');
    }
  }

  Future<void> dispose() async {
    _timer?.cancel();
    final subscriptions = [..._subscriptions];
    _subscriptions.clear();
    await Future.wait(subscriptions.map((s) => s.cancel()));
  }
}
