import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';

/// Records what would be scheduled, instead of the platform plugin.
class FakeReminderScheduler implements ReminderScheduler {
  List<Reminder> scheduled = const [];
  int? minutes;
  int permissionRequests = 0;

  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }

  @override
  Future<void> replaceAll(
    List<Reminder> reminders, {
    required int minutes,
  }) async {
    scheduled = reminders;
    this.minutes = minutes;
  }

  @override
  Future<void> cancelAll() async => scheduled = const [];
}
