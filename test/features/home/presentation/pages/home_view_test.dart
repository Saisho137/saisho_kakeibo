import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_chart.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/debt_fixtures.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/movement_fixtures.dart';

void main() {
  late MockHomeCubit homeCubit;
  late MockSettingsCubit settingsCubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final today = LocalDate.today();
  final cash = account(id: 1, type: AccountType.cash, includeInBalance: true);
  final bank = account(id: 2, includeInBalance: true);
  final dollars = account(id: 3, currencyCode: 'USD');

  final ready = HomeState(
    status: HomeStatus.success,
    today: today,
    settings: const AppSettings(),
    accounts: [cash, bank, dollars],
    balances: const {1: 4250000, 2: 0, 3: 0},
    currencies: const [cop, usd],
    categories: [category(id: 10, name: 'Food')],
    pillars: pillars,
    // Two periods: since yesterday, and from 2025 to the day before.
    periodStarts: [LocalDate(2025, 1, 1), today.addDays(-1)],
    movements: [
      movement(type: MovementType.income, amount: 5000000, date: today),
      movement(amount: 2040000, date: today, categoryId: 10),
      movement(
        type: MovementType.transfer,
        toAccountId: 2,
        amount: 1200000,
        date: today,
      ),
      movement(amount: 777, date: LocalDate(2025, 1, 5)),
    ],
  );

  setUpAll(() => registerFallbackValue((AppSettings s) => s));

  setUp(() {
    homeCubit = MockHomeCubit();
    settingsCubit = MockSettingsCubit();
    router = MockGoRouter();
    when(() => homeCubit.state).thenReturn(ready);
    when(() => settingsCubit.state)
        .thenReturn(const SettingsState(status: SettingsStatus.ready));
    when(() => settingsCubit.update(any())).thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>.value(value: homeCubit),
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
        ],
        child: const HomeView(),
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

  group('HomeView', () {
    testWidgets('shows loading', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows a failed load', (tester) async {
      when(() => homeCubit.state)
          .thenReturn(const HomeState(status: HomeStatus.failure));
      await pumpView(tester);
      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });

    testWidgets('shows the period totals and the Balance', (tester) async {
      await pumpView(tester);

      expect(find.textContaining('Since '), findsOneWidget);
      expect(find.text('5.000.000'), findsOneWidget);
      expect(find.text('2.040.000'), findsOneWidget);
      expect(find.text('1.200.000'), findsOneWidget);
      expect(
        find.text('Balance COP 4.250.000', findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('a category of the donut starts an expense of it', (
      tester,
    ) async {
      await pumpView(tester);

      final donut = find.byType(DonutChart);
      final box = tester.getSize(donut);
      // Middle of the ring: half the square less the icons (44), the
      // border (8), the separation (2) and half the ring (18).
      final radius = min(box.width, box.height) / 2 - 72;
      await tester.tapAt(tester.getCenter(donut) + Offset(radius, 0));
      verify(
        () => router.push<Object?>('/movements/new?type=expense&category=10'),
      ).called(1);
    });

    testWidgets("a debt's section starts a payment of that debt", (
      tester,
    ) async {
      when(() => homeCubit.state).thenReturn(
        ready.copyWith(
          categories: [category(id: 12, role: CategoryRole.debtPayment)],
          debts: [debt()],
          movements: [
            movement(
              amount: 500,
              date: today,
              categoryId: 12,
            ).copyWith(debtId: 1),
          ],
        ),
      );
      await pumpView(tester);

      final donut = find.byType(DonutChart);
      final box = tester.getSize(donut);
      final radius = min(box.width, box.height) / 2 - 72;
      await tester.tapAt(tester.getCenter(donut) + Offset(radius, 0));
      verify(
        () => router.push<Object?>(
          '/movements/new?type=expense&category=12&debt=1',
        ),
      ).called(1);
    });

    testWidgets('swiping right shows the previous period', (tester) async {
      await pumpView(tester);

      await tester.fling(find.byType(PageView), const Offset(800, 0), 2000);
      await tester.pumpAndSettle();

      expect(find.textContaining('Jan 1, 2025 – '), findsOneWidget);
      expect(find.text('777'), findsOneWidget);
      expect(find.text('5.000.000'), findsNothing);
    });

    testWidgets('starts an expense, a transfer or an income', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Expense'));
      verify(() => router.push<Object?>('/entry/expense')).called(1);
      await tester.tap(find.text('Income'));
      verify(() => router.push<Object?>('/entry/income')).called(1);
      await tester.tap(find.byTooltip('Transfer'));
      verify(() => router.push<Object?>('/transfers/new')).called(1);
    });

    testWidgets('the navigation opens every screen', (tester) async {
      await pumpView(tester);

      for (final (screen, route) in [
        ('Accounts', '/accounts'),
        ('Debts', '/debts'),
        ('Categories', '/categories'),
        ('Recurring', '/recurring'),
        ('Settings', '/settings'),
      ]) {
        await tester.tap(find.byTooltip('Go to'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(screen));
        await tester.pumpAndSettle();
        verify(() => router.push<Object?>(route)).called(1);
      }
    });

    testWidgets('the quick menu switches every option', (tester) async {
      await pumpView(tester);
      await tester.tap(find.byTooltip('Quick menu'));
      await tester.pumpAndSettle();

      expect(find.text('PERIOD'), findsOneWidget);
      await tester.tap(find.text('Monthly'));
      expect(lastUpdate().periodType, PeriodType.monthly);
      await tester.tap(find.text('USD'));
      verify(() => homeCubit.currencySelected('USD')).called(1);
      await tester.tap(find.text('Cash'));
      expect(lastUpdate().balanceFilter, BalanceFilter.cash);
      await tester.tap(find.text('Dark'));
      expect(lastUpdate().themeMode, AppThemeMode.dark);
    });

    testWidgets('the Balance and the totals open the history', (tester) async {
      await pumpView(tester);

      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();
      expect(find.text('By day'), findsOneWidget);
      expect(find.text('Food'), findsWidgets);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.fling(
        find.byTooltip('History'),
        const Offset(0, -300),
        1000,
      );
      await tester.pumpAndSettle();
      expect(find.text('By day'), findsOneWidget);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1.200.000'));
      await tester.pumpAndSettle();
      expect(find.text('Transfers'), findsOneWidget);
      expect(find.text('No movements in this period.'), findsOneWidget);
    });

    testWidgets('remembers the period swiped to', (tester) async {
      await pumpView(tester);

      await tester.fling(find.byType(PageView), const Offset(800, 0), 2000);
      await tester.pumpAndSettle();

      verify(() => homeCubit.periodSelected(ready.periods.last)).called(1);
    });
  });
}
