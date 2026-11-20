import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/adjust_account_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_account_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/movement_fixtures.dart';

class _MockWatchAccounts extends Mock implements WatchAccounts;

class _MockWatchBalances extends Mock implements WatchAccountBalances;

class _MockWatchCurrencies extends Mock implements WatchCurrencies;

class _MockWatchMovements extends Mock implements WatchAccountMovements;

class _MockWatchCategories extends Mock implements WatchCategories;

class _MockWatchPayees extends Mock implements WatchPayees;

class _MockWatchSettings extends Mock implements WatchSettings;

class _MockWatchStarts extends Mock implements WatchPeriodStarts;

class _MockAdjust extends Mock implements AdjustAccountBalance;

class _MockDelete extends Mock implements DeleteMovement;

void main() {
  late _MockWatchAccounts watchAccounts;
  late _MockWatchBalances watchBalances;
  late _MockWatchCurrencies watchCurrencies;
  late _MockWatchMovements watchMovements;
  late _MockWatchCategories watchCategories;
  late _MockWatchPayees watchPayees;
  late _MockWatchSettings watchSettings;
  late _MockWatchStarts watchStarts;
  late _MockAdjust adjust;
  late _MockDelete delete;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final lulo = account(id: 1);
  final fund = account(id: 2, type: AccountType.pocket, parentAccountId: 1);
  final food = category(id: 10);
  const uber = Payee(id: 5, name: 'Uber', key: 'uber');
  final lunch = movement(id: 1, categoryId: 10, payeeId: 5);
  final older = movement(id: 2, date: movementDay.addDays(-1));

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(
      AdjustAccountBalanceParams(
        accountId: 0,
        actualBalance: 0,
        date: movementDay,
      ),
    );
  });

  setUp(() {
    watchAccounts = _MockWatchAccounts();
    watchBalances = _MockWatchBalances();
    watchCurrencies = _MockWatchCurrencies();
    watchMovements = _MockWatchMovements();
    watchCategories = _MockWatchCategories();
    watchPayees = _MockWatchPayees();
    watchSettings = _MockWatchSettings();
    watchStarts = _MockWatchStarts();
    adjust = _MockAdjust();
    delete = _MockDelete();
    when(() => watchAccounts(any()))
        .thenAnswer((_) => Stream.value([lulo, fund]));
    when(() => watchBalances(any()))
        .thenAnswer((_) => Stream.value({1: 2000, 2: 3000}));
    when(() => watchCurrencies(any())).thenAnswer((_) => Stream.value([cop]));
    when(() => watchMovements(any()))
        .thenAnswer((_) => Stream.value([lunch, older]));
    when(() => watchCategories(any())).thenAnswer((_) => Stream.value([food]));
    when(() => watchPayees(any())).thenAnswer((_) => Stream.value([uber]));
    when(() => watchSettings(any()))
        .thenAnswer((_) => Stream.value(const AppSettings()));
    when(() => watchStarts(any())).thenAnswer((_) => Stream.value([]));
    when(() => adjust(any())).thenAnswer((_) async => const Ok(null));
    when(() => delete(any())).thenAnswer((_) async => const Ok(null));
  });

  AccountDetailCubit buildCubit() => AccountDetailCubit(
    watchAccounts: watchAccounts,
    watchBalances: watchBalances,
    watchCurrencies: watchCurrencies,
    watchMovements: watchMovements,
    watchCategories: watchCategories,
    watchPayees: watchPayees,
    watchSettings: watchSettings,
    watchPeriodStarts: watchStarts,
    adjustBalance: adjust,
    deleteMovement: delete,
  );

  group('AccountDetailCubit', () {
    blocTest<AccountDetailCubit, AccountDetailState>(
      'shows the account once every stream arrives',
      build: buildCubit,
      act: (cubit) => cubit.load(1),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.status, AccountDetailStatus.success);
        expect(state.account, lulo);
        expect(state.currency, cop);
        expect(state.pockets, [fund]);
        expect(state.balance, const Money(5000, 'COP'));
        expect(state.free, const Money(2000, 'COP'));
        expect(state.today, LocalDate.today());
        expect(state.settings, const AppSettings());
        expect(state.periodStarts, isEmpty);
        expect(state.categoryOf(lunch), food);
        expect(state.payeeOf(lunch), uber);
        expect(state.accountById(2), fund);
      },
    );

    blocTest<AccountDetailCubit, AccountDetailState>(
      'a pocket has no free line, a missing account is not found',
      build: buildCubit,
      act: (cubit) async {
        cubit.load(2);
        await Future<void>.delayed(Duration.zero);
        expect(cubit.state.free, isNull);
        expect(cubit.state.balance, const Money(3000, 'COP'));
        cubit.load(99);
      },
      wait: Duration.zero,
      verify: (cubit) {
        expect(cubit.state.status, AccountDetailStatus.notFound);
        expect(cubit.state.balance, isNull);
      },
    );

    test('an empty state has no derived values', () {
      const state = AccountDetailState();
      expect(state.pockets, isEmpty);
      expect(state.free, isNull);
      expect(state.periods, isEmpty);
      expect(state.currentIndex, 0);
    });

    group('periods', () {
      // Dynamic periods: a salary started one on March 5.
      final state = AccountDetailState(
        accountId: 1,
        today: movementDay,
        settings: const AppSettings(),
        periodStarts: [movementDay.addDays(-5)],
        movements: [
          movement(id: 3, date: movementDay.addDays(40)),
          lunch,
          older,
          movement(id: 4, date: LocalDate(2026, 1, 30)),
        ],
      );

      test('go from the newest movement back to the oldest', () {
        expect(state.periods, [
          Period(start: LocalDate(2026, 3, 5)),
          Period(start: LocalDate(2026, 2, 27), end: LocalDate(2026, 3, 4)),
          Period(start: LocalDate(2026, 1, 27), end: LocalDate(2026, 2, 26)),
        ]);
        expect(state.currentIndex, 0);
      });

      test('group the movements of a period by day', () {
        final days = state.daysIn(state.periods.first);
        expect(days.map((d) => d.$1), [
          movementDay.addDays(40),
          movementDay,
          movementDay.addDays(-1),
        ]);
        expect(days[1].$2, [lunch]);
        expect(state.daysIn(state.periods[1]), isEmpty);
      });

      test('start on today when later periods have movements', () {
        final monthly = state.copyWith(
          settings: const AppSettings(periodType: PeriodType.monthly),
        );
        expect(monthly.periods.first.start, LocalDate(2026, 3, 27));
        expect(monthly.currentIndex, 1);
      });
    });

    blocTest<AccountDetailCubit, AccountDetailState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchMovements(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load(1),
      verify: (cubit) =>
          expect(cubit.state.status, AccountDetailStatus.failure),
    );

    blocTest<AccountDetailCubit, AccountDetailState>(
      'adjusts the balance today and deletes movements',
      build: buildCubit,
      act: (cubit) async {
        cubit.load(1);
        await cubit.adjustBalance(7000);
        await cubit.deleteMovement(3);
      },
      verify: (_) {
        final params =
            verify(() => adjust(captureAny())).captured.single
                as AdjustAccountBalanceParams;
        expect(params.accountId, 1);
        expect(params.actualBalance, 7000);
        expect(params.date, LocalDate.today());
        verify(() => delete(3)).called(1);
      },
    );

    blocTest<AccountDetailCubit, AccountDetailState>(
      'exposes a failed action and ignores adjusting before loading',
      setUp: () =>
          when(() => delete(any()))
              .thenAnswer((_) async => const Err(DatabaseFailure('disk'))),
      build: buildCubit,
      act: (cubit) async {
        await cubit.adjustBalance(1);
        await cubit.deleteMovement(3);
      },
      verify: (cubit) {
        verifyNever(() => adjust(any()));
        expect(cubit.state.failure, isA<DatabaseFailure>());
      },
    );
  });
}
