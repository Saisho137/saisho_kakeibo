import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';
import 'package:timezone/timezone.dart' as tz;

/// Schedules the reminders as Android local notifications (RT-11).
///
/// Instants are computed in the device time zone and handed over in UTC,
/// so no time zone database is needed. Alarms are inexact: the system may
/// deliver them a few minutes late, but no exact-alarm permission is asked.
class LocalReminderScheduler implements ReminderScheduler {
  new({FlutterLocalNotificationsPlugin? plugin, DateTime Function()? now})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
      _now = now ?? DateTime.now;

  final FlutterLocalNotificationsPlugin _plugin;
  final DateTime Function() _now;
  bool _initialized = false;

  static const String _channelId = 'reminders';

  /// The app's texts; notifications are built outside the widget tree.
  AppLocalizations get _l10n => lookupAppLocalizations(const Locale('en'));

  Future<void> _init() async {
    if (_initialized) return;
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _initialized = true;
  }

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  @override
  Future<bool> requestPermission() async {
    await _init();
    return await _android?.requestNotificationsPermission() ?? true;
  }

  @override
  Future<void> cancelAll() async {
    await _init();
    await _plugin.cancelAll();
  }

  @override
  Future<void> replaceAll(
    List<Reminder> reminders, {
    required int minutes,
  }) async {
    await _init();
    await _plugin.cancelAll();
    final l10n = _l10n;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        l10n.reminderChannelName,
        channelDescription: l10n.reminderChannelDescription,
      ),
    );
    final now = _now();
    for (final reminder in reminders) {
      final day = reminder.date;
      final at = DateTime(day.year, day.month, day.day, 0, minutes);
      if (!at.isAfter(now)) continue;
      final (title, body) = switch (reminder.kind) {
        ReminderKind.recurring => (
          l10n.reminderRecurringTitle(reminder.name),
          reminder.amount == null
              ? null
              : l10n.reminderRecurringBody(reminder.amount!),
        ),
        ReminderKind.cardPayment => (
          l10n.reminderCardTitle(reminder.name),
          l10n.reminderCardBody,
        ),
      };
      await _plugin.zonedSchedule(
        id: reminder.id,
        scheduledDate: tz.TZDateTime.from(at.toUtc(), tz.UTC),
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: title,
        body: body,
      );
    }
  }
}
