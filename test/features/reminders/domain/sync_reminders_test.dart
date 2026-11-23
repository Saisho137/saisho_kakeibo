import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/usecases/sync_reminders.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

class _MockSettings extends Mock implements SettingsRepository;

class _MockRecurring extends Mock implements RecurringRepository;

class _MockAccounts extends Mock implements AccountRepository;

class _MockCategories extends Mock implements CategoryRepository;

class _MockMovements extends Mock implements MovementRepository;

class _MockCurrencies extends Mock implements CurrencyRepository;

class _MockScheduler extends Mock implements ReminderScheduler;

class _MockDebts extends Mock implements GetDebtStatuses;

void main() {
  late _MockSettings settings;
  late _MockRecurring recurring;
  late _MockAccounts accounts;
  late _MockCategories categories;
  late _MockMovements movements;
  late _MockCurrencies currencies;
  late _MockScheduler scheduler;
  late _MockDebts debts;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final today = LocalDate(2026, 1, 20);

  setUpAll(() {
    registerFallbackValue(<Reminder>[]);
    registerFallbackValue(const NoParams());
  });

  setUp(() {
    settings = _MockSettings();
    recurring = _MockRecurring();
    accounts = _MockAccounts();
    categories = _MockCategories();
    movements = _MockMovements();
    currencies = _MockCurrencies();
    scheduler = _MockScheduler();
    debts = _MockDebts();
    when(() => debts(any())).thenAnswer((_) async => const Ok([]));
    when(() => settings.getSettings())
        .thenAnswer((_) async => const Ok(AppSettings(reminderMinutes: 450)));
    when(() => recurring.getTemplates())
        .thenAnswer((_) async => Ok([template(dueDay: 12, remind: true)]));
    when(() => accounts.getAccounts())
        .thenAnswer((_) async => Ok([account(id: 1)]));
    when(() => categories.getCategories())
        .thenAnswer((_) async => const Ok([]));
    when(() => movements.getPayees()).thenAnswer((_) async => const Ok([]));
    when(() => currencies.getCurrencies())
        .thenAnswer((_) async => const Ok([cop]));
    when(() => scheduler.replaceAll(any(), minutes: any(named: 'minutes')))
        .thenAnswer((_) async {});
    when(() => scheduler.cancelAll()).thenAnswer((_) async {});
  });

  SyncReminders sync() => SyncReminders(
    settings: settings,
    recurring: recurring,
    accounts: accounts,
    categories: categories,
    movements: movements,
    currencies: currencies,
    scheduler: scheduler,
    debts: debts,
  );

  group('SyncReminders', () {
    test('schedules every reminder at the global time', () async {
      expect((await sync()(today) as Ok<int>).value, 2);

      final captured = verify(
        () => scheduler.replaceAll(
          captureAny(),
          minutes: captureAny(named: 'minutes'),
        ),
      ).captured;
      expect(captured.first, hasLength(2));
      expect(captured.last, 450);
    });

    test('cancels everything with notifications off', () async {
      when(() => settings.getSettings()).thenAnswer(
        (_) async => const Ok(AppSettings(notificationsEnabled: false)),
      );

      expect((await sync()(today) as Ok<int>).value, 0);
      verify(() => scheduler.cancelAll()).called(1);
      verifyNever(
        () => scheduler.replaceAll(any(), minutes: any(named: 'minutes')),
      );
    });

    test('reports platform and database failures', () async {
      when(() => scheduler.replaceAll(any(), minutes: any(named: 'minutes')))
          .thenThrow(Exception('no plugin'));
      expect((await sync()(today) as Err).failure, isA<UnexpectedFailure>());

      when(() => currencies.getCurrencies())
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      expect((await sync()(today) as Err).failure, isA<DatabaseFailure>());
    });
  });
}
