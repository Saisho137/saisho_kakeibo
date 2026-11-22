import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/reminders/data/local_reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';
import 'package:timezone/timezone.dart' as tz;

class _MockPlugin extends Mock implements FlutterLocalNotificationsPlugin;

class _MockAndroid extends Mock
    implements AndroidFlutterLocalNotificationsPlugin;

void main() {
  late _MockPlugin plugin;
  late _MockAndroid android;
  late LocalReminderScheduler scheduler;

  final now = DateTime(2026, 1, 20, 9);

  setUpAll(() {
    registerFallbackValue(const InitializationSettings());
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(AndroidScheduleMode.inexactAllowWhileIdle);
    registerFallbackValue(tz.TZDateTime.utc(2026));
  });

  setUp(() {
    plugin = _MockPlugin();
    android = _MockAndroid();
    when(() => plugin.initialize(settings: any(named: 'settings')))
        .thenAnswer((_) async => true);
    when(() => plugin.cancelAll()).thenAnswer((_) async {});
    when(
      () => plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >(),
    ).thenReturn(android);
    when(() => android.requestNotificationsPermission())
        .thenAnswer((_) async => true);
    when(
      () => plugin.zonedSchedule(
        id: any(named: 'id'),
        scheduledDate: any(named: 'scheduledDate'),
        notificationDetails: any(named: 'notificationDetails'),
        androidScheduleMode: any(named: 'androidScheduleMode'),
        title: any(named: 'title'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async {});
    scheduler = LocalReminderScheduler(plugin: plugin, now: () => now);
  });

  group('LocalReminderScheduler', () {
    test('replaces every reminder, skipping past instants', () async {
      await scheduler.replaceAll([
        Reminder(
          id: 1,
          kind: ReminderKind.recurring,
          name: 'Netflix',
          date: LocalDate(2026, 1, 20),
          amount: 'COP 44.900',
        ),
        Reminder(
          id: 2,
          kind: ReminderKind.recurring,
          name: 'Netflix',
          date: LocalDate(2026, 2, 20),
          amount: 'COP 44.900',
        ),
        Reminder(
          id: 3,
          kind: ReminderKind.recurring,
          name: 'Gym',
          date: LocalDate(2026, 2, 21),
        ),
        Reminder(
          id: 4,
          kind: ReminderKind.cardPayment,
          name: 'Visa',
          date: LocalDate(2026, 2, 1),
        ),
      ], minutes: 8 * 60);

      verify(() => plugin.cancelAll()).called(1);
      verify(() => plugin.initialize(settings: any(named: 'settings')))
          .called(1);
      final calls = verify(
        () => plugin.zonedSchedule(
          id: captureAny(named: 'id'),
          scheduledDate: captureAny(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          title: captureAny(named: 'title'),
          body: captureAny(named: 'body'),
        ),
      ).captured;
      // Today at 8:00 already passed at 9:00.
      expect(calls, hasLength(12));
      expect(calls[0], 2);
      expect(
        (calls[1] as tz.TZDateTime).millisecondsSinceEpoch,
        DateTime(2026, 2, 20, 8).millisecondsSinceEpoch,
      );
      expect(calls[2], 'Netflix is due today');
      expect(calls[3], 'COP 44.900 · Confirm it in Saisho Kakeibo.');
      expect(calls[7], isNull);
      expect(calls[10], 'Visa payment day');
      expect(calls[11], 'Pay your credit card today.');
    });

    test('asks for permission and cancels, initializing once', () async {
      expect(await scheduler.requestPermission(), isTrue);
      await scheduler.cancelAll();

      verify(() => android.requestNotificationsPermission()).called(1);
      verify(() => plugin.cancelAll()).called(1);
      verify(() => plugin.initialize(settings: any(named: 'settings')))
          .called(1);
    });

    test('without Android the permission is not needed', () async {
      when(
        () => plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >(),
      ).thenReturn(null);
      expect(await scheduler.requestPermission(), isTrue);
    });

    test('uses the real plugin by default', () {
      expect(LocalReminderScheduler(), isA<LocalReminderScheduler>());
    });
  });
}
