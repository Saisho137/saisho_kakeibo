import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/periods/presentation/cubit/period_starts_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currencies_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/pages/settings_page.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late MockSettingsCubit settingsCubit;
  late MockCurrenciesCubit currenciesCubit;
  late MockAccountsCubit accountsCubit;
  late MockPeriodStartsCubit periodStartsCubit;
  late MockGoRouter router;

  const currencies = [
    Currency(
      code: 'COP',
      symbol: r'$',
      format: CurrencyFormat.cop,
      isBuiltIn: true,
    ),
    Currency(
      code: 'USD',
      symbol: r'US$',
      format: CurrencyFormat.usd,
      isBuiltIn: true,
    ),
    Currency(
      code: 'EUR',
      symbol: '€',
      format: CurrencyFormat(decimals: 2, thousandsSeparator: ' '),
    ),
  ];
  const ready = SettingsState(status: SettingsStatus.ready);

  setUpAll(() {
    registerFallbackValue((AppSettings s) => s);
    registerFallbackValue(account(id: 0));
    registerFallbackValue(LocalDate(2026, 1, 1));
  });

  setUp(() {
    settingsCubit = MockSettingsCubit();
    currenciesCubit = MockCurrenciesCubit();
    accountsCubit = MockAccountsCubit();
    periodStartsCubit = MockPeriodStartsCubit();
    when(() => periodStartsCubit.state)
        .thenReturn(PeriodStartsState(manualStarts: [LocalDate(2026, 11, 3)]));
    when(() => periodStartsCubit.startNow()).thenAnswer((_) async {});
    when(() => periodStartsCubit.remove(any())).thenAnswer((_) async {});
    when(() => accountsCubit.state).thenReturn(
      AccountsState(
        accounts: [
          account(id: 1, name: 'Lulo', includeInBalance: true),
          account(
            id: 2,
            type: AccountType.pocket,
            name: 'Trip',
            parentAccountId: 1,
          ),
          account(id: 3, name: 'Old bank', isArchived: true),
        ],
      ),
    );
    when(
      () =>
          accountsCubit.setIncludeInBalance(any(), value: any(named: 'value')),
    ).thenAnswer((_) async {});
    router = MockGoRouter();
    when(() => settingsCubit.state).thenReturn(ready);
    when(() => settingsCubit.update(any())).thenAnswer((_) async {});
    when(() => currenciesCubit.state).thenReturn(
      const CurrenciesState(
        status: CurrenciesStatus.success,
        currencies: currencies,
      ),
    );
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
          BlocProvider<CurrenciesCubit>.value(value: currenciesCubit),
          BlocProvider<AccountsCubit>.value(value: accountsCubit),
          BlocProvider<PeriodStartsCubit>.value(value: periodStartsCubit),
        ],
        child: const SettingsView(
          appInfo: AppInfo(version: '1.2.3', buildNumber: '4'),
        ),
      ),
      router: router,
    );
  }

  /// Applies the last change passed to `SettingsCubit.update`.
  AppSettings lastUpdate() {
    final change =
        verify(() => settingsCubit.update(captureAny())).captured.last
            as AppSettings Function(AppSettings);
    return change(const AppSettings());
  }

  group('SettingsView', () {
    testWidgets('shows every section with the stored values', (tester) async {
      await pumpView(tester);

      for (final text in [
        'General',
        'Periods',
        'Currencies',
        'Notifications',
        'About',
        'Main currency',
        '27',
        '21 days',
        '8:00 AM',
        '1.2.3 (4)',
      ]) {
        expect(find.text(text), findsWidgets, reason: text);
      }
    });

    testWidgets('lists currencies with a formatted sample', (tester) async {
      await pumpView(tester);

      expect(find.text(r'$ 1.234.567'), findsOneWidget);
      expect(find.text(r'US$ 1.234.567,89'), findsOneWidget);
      expect(find.text('€ 1 234 567,89'), findsOneWidget);
      expect(find.text('Built-in'), findsNWidgets(2));
    });

    testWidgets('changes the main currency', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Main currency'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('EUR · €'));
      await tester.pumpAndSettle();

      expect(lastUpdate().mainCurrencyCode, 'EUR');
    });

    testWidgets('changes the cutoff day', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Cutoff day'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, '31'));
      await tester.pumpAndSettle();

      expect(lastUpdate().cutoffDay, 31);
    });

    testWidgets('changes the minimum days between periods', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Min days between salary periods'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, '45'));
      await tester.pumpAndSettle();

      expect(lastUpdate().minDaysBetweenPeriods, 45);
    });

    testWidgets('dismissing a picker changes nothing', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Cutoff day'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => settingsCubit.update(any()));
    });

    testWidgets('toggles reminders', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Reminders'));

      expect(lastUpdate().notificationsEnabled, isFalse);
    });

    testWidgets('changes the reminder time', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Reminder time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(lastUpdate().reminderMinutes, 8 * 60);
    });

    testWidgets('opens a currency and the new currency form', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('EUR'));
      await tester.tap(find.text('Add currency'));

      verify(() => router.push<Object?>('/settings/currencies/EUR')).called(1);
      verify(() => router.push<Object?>('/settings/currencies/new')).called(1);
    });

    testWidgets('lists active accounts with their Balance switch', (
      tester,
    ) async {
      await pumpView(tester);

      expect(find.text('Lulo'), findsOneWidget);
      expect(find.text('Trip'), findsNothing);
      expect(find.text('Old bank'), findsNothing);

      await tester.tap(find.text('Lulo'));

      final captured = verify(
        () => accountsCubit.setIncludeInBalance(
          captureAny(),
          value: captureAny(named: 'value'),
        ),
      ).captured;
      expect((captured.first as Account).id, 1);
      expect(captured.last, isFalse);
    });

    testWidgets('shows a snackbar when a change fails', (tester) async {
      whenListen(
        settingsCubit,
        Stream.value(ready.copyWith(failure: const ValidationFailure('x'))),
        initialState: ready,
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });

    testWidgets('starts a period now after confirming', (tester) async {
      await pumpView(tester);
      expect(find.text('Start new period now'), findsNothing);
      await tester.tap(find.text('Advanced'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start new period now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => periodStartsCubit.startNow());

      await tester.tap(find.text('Start new period now'));
      await tester.pumpAndSettle();
      expect(find.text('Start a new period today?'), findsOneWidget);
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      verify(() => periodStartsCubit.startNow()).called(1);
    });

    testWidgets('undoes a manual start after confirming', (tester) async {
      await pumpView(tester);
      await tester.tap(find.text('Advanced'));
      await tester.pumpAndSettle();

      expect(find.text('Manual start · Nov 3, 2026'), findsOneWidget);
      await tester.tap(find.byTooltip('Undo this start'));
      await tester.pumpAndSettle();
      expect(find.text('Undo the start of Nov 3, 2026?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      verify(() => periodStartsCubit.remove(LocalDate(2026, 11, 3))).called(1);
    });

    testWidgets('tells how starting a period went', (tester) async {
      const initial = PeriodStartsState();
      whenListen(
        periodStartsCubit,
        Stream.fromIterable([
          initial.copyWith(notice: PeriodStartNotice.started, notices: 1),
          initial.copyWith(
            notice: PeriodStartNotice.alreadyStarted,
            notices: 2,
          ),
          initial.copyWith(notices: 2, failure: const DatabaseFailure('disk')),
        ]),
        initialState: initial,
      );

      await pumpView(tester);
      await tester.pump();
      expect(find.text('Something went wrong. Please try again.'), findsOne);
      expect(find.text('A period already starts today.'), findsNothing);
    });
  });
}
