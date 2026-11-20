import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_totals.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/movement_fixtures.dart';

class _MockWatchSettings extends Mock implements WatchSettings;

class _MockWatchAccounts extends Mock implements WatchAccounts;

class _MockWatchBalances extends Mock implements WatchAccountBalances;

class _MockWatchCurrencies extends Mock implements WatchCurrencies;

class _MockWatchMovements extends Mock implements WatchMovements;

class _MockWatchStarts extends Mock implements WatchPeriodStarts;

class _MockWatchCategories extends Mock implements WatchCategories;

class _MockWatchPillars extends Mock implements WatchPillars;

void main() {
  late _MockWatchSettings watchSettings;
  late _MockWatchAccounts watchAccounts;
  late _MockWatchBalances watchBalances;
  late _MockWatchCurrencies watchCurrencies;
  late _MockWatchMovements watchMovements;
  late _MockWatchStarts watchStarts;
  late _MockWatchCategories watchCategories;
  late _MockWatchPillars watchPillars;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const eur = Currency(code: 'EUR', symbol: '€', format: CurrencyFormat.usd);
  final cash = account(id: 1, type: AccountType.cash, includeInBalance: true);
  final card = account(id: 2, type: AccountType.creditCard);
  final dollars = account(id: 3, currencyCode: 'USD');

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() {
    watchSettings = _MockWatchSettings();
    watchAccounts = _MockWatchAccounts();
    watchBalances = _MockWatchBalances();
    watchCurrencies = _MockWatchCurrencies();
    watchMovements = _MockWatchMovements();
    watchStarts = _MockWatchStarts();
    watchCategories = _MockWatchCategories();
    watchPillars = _MockWatchPillars();
    when(() => watchCategories(any()))
        .thenAnswer((_) => Stream.value([category(id: 10)]));
    when(() => watchPillars(any())).thenAnswer((_) => Stream.value(pillars));
    when(() => watchSettings(any()))
        .thenAnswer((_) => Stream.value(const AppSettings()));
    when(() => watchAccounts(any()))
        .thenAnswer((_) => Stream.value([cash, card, dollars]));
    when(() => watchBalances(any()))
        .thenAnswer((_) => Stream.value({1: 500, 2: -300, 3: 9}));
    when(() => watchCurrencies(any()))
        .thenAnswer((_) => Stream.value([cop, usd, eur]));
    when(() => watchMovements(any())).thenAnswer((_) => Stream.value([]));
    when(() => watchStarts(any())).thenAnswer((_) => Stream.value([]));
  });

  HomeCubit buildCubit() => HomeCubit(
    watchSettings: watchSettings,
    watchAccounts: watchAccounts,
    watchBalances: watchBalances,
    watchCurrencies: watchCurrencies,
    watchMovements: watchMovements,
    watchPeriodStarts: watchStarts,
    watchCategories: watchCategories,
    watchPillars: watchPillars,
  );

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'is ready once every stream arrives',
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.status, HomeStatus.success);
        expect(state.today, LocalDate.today());
        expect(state.currency, cop);
        expect(state.currencyOptions, [cop, usd]);
        expect(state.balance, const Money(500, 'COP'));
        expect(state.periods, hasLength(1));
        expect(state.currentIndex, 0);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'switches the active currency',
      build: buildCubit,
      act: (cubit) async {
        cubit.load();
        await Future<void>.delayed(Duration.zero);
        cubit.currencySelected('USD');
      },
      verify: (cubit) {
        expect(cubit.state.currency, usd);
        expect(cubit.state.balance, const Money(0, 'USD'));
      },
    );

    blocTest<HomeCubit, HomeState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchMovements(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        expect(cubit.state.status, HomeStatus.failure);
        expect(cubit.state.failure, isA<UnexpectedFailure>());
      },
    );

    test('cancels its streams when closed', () async {
      final controller = StreamController<List<Movement>>();
      when(() => watchMovements(any())).thenAnswer((_) => controller.stream);
      final cubit = buildCubit()..load();

      await cubit.close();

      expect(controller.hasListener, isFalse);
    });
  });

  group('HomeState', () {
    test('has nothing to show before loading', () {
      const state = HomeState();
      expect(state.currency, isNull);
      expect(state.balance, isNull);
      expect(state.periods, isEmpty);
      expect(state.currentIndex, 0);
      expect(
        state.totalsOf(Period(start: movementDay)),
        const CurrencyTotals(),
      );
      expect(state.donutOf(Period(start: movementDay)).isEmpty, isTrue);
    });

    test('totals a period over every account of the currency', () {
      // Monthly from the 27th: March 10 falls in Feb 27 – Mar 26.
      final state = HomeState(
        today: movementDay,
        settings: const AppSettings(periodType: PeriodType.monthly),
        accounts: [cash, card, dollars],
        periodStarts: const [],
        categories: [category(id: 10)],
        pillars: pillars,
        movements: [
          movement(accountId: 2, amount: 300, categoryId: 10),
          movement(type: MovementType.income, amount: 2000),
          movement(accountId: 3, amount: 5),
          movement(amount: 70, date: LocalDate(2026, 2, 20)),
        ],
      );

      expect(state.periods, hasLength(2));
      expect(
        state.totalsOf(state.periods.first),
        const CurrencyTotals(income: 2000, expenses: 300),
      );
      expect(
        state.totalsOf(state.periods.last),
        const CurrencyTotals(expenses: 70),
      );
      expect(
        state
            .copyWith(selectedCurrencyCode: 'EUR')
            .totalsOf(state.periods.first),
        const CurrencyTotals(),
      );
    });
  });
}
