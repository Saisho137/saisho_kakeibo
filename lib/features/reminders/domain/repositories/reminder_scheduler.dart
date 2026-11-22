import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';

/// Contract implemented with the platform's local notifications (RT-11).
abstract interface class ReminderScheduler {
  /// Asks the system to allow notifications (Android 13+). Returns whether
  /// they are allowed.
  Future<bool> requestPermission();

  /// Cancels every scheduled reminder and schedules [reminders] at
  /// [minutes] after midnight of their day. Past instants are skipped.
  Future<void> replaceAll(List<Reminder> reminders, {required int minutes});

  Future<void> cancelAll();
}
