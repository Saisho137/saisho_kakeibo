import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/delete_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/merge_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/rename_payee.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payee_detail_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payees_cubit.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _WatchPayees extends Mock implements WatchPayees;

class _WatchMovements extends Mock implements WatchMovements;

class _WatchAccounts extends Mock implements WatchAccounts;

class _WatchCategories extends Mock implements WatchCategories;

class _WatchDebts extends Mock implements WatchDebts;

class _WatchStarts extends Mock implements WatchPeriodStarts;

class _WatchCurrencies extends Mock implements WatchCurrencies;

class _WatchSettings extends Mock implements WatchSettings;

class _Rename extends Mock implements RenamePayee;

class _Merge extends Mock implements MergePayee;

class _Delete extends Mock implements DeletePayee;

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const peaje = Payee(id: 1, name: 'Peaje Palmas', key: 'peajepalmas');
  const pragma = Payee(id: 2, name: 'Pragma', key: 'pragma');
  const crepes = Payee(id: 3, name: 'Crepes', key: 'crepes');
  const unused = Payee(id: 4, name: 'Unused', key: 'unused');
  const amazon = Payee(id: 5, name: 'Amazon', key: 'amazon');
  final today = LocalDate.today();
  final longAgo = today.addDays(-400);
  // Monthly from the 1st: the period is the calendar month.
  const settings = AppSettings(periodType: PeriodType.monthly, cutoffDay: 1);
  final movements = [
    movement(id: 1, payeeId: 1, amount: 9000, date: today, categoryId: 10),
    movement(id: 2, payeeId: 1, amount: 9000, date: today, categoryId: 10),
    movement(id: 3, payeeId: 1, amount: 8000, date: longAgo),
    movement(
      id: 4,
      payeeId: 2,
      type: MovementType.income,
      amount: 5000000,
      date: today,
    ),
    movement(id: 5, payeeId: 3, amount: 30000, date: longAgo),
    movement(id: 6, payeeId: 5, accountId: 2, amount: 10, date: today),
  ];

  late _WatchPayees watchPayees;
  late _WatchMovements watchMovements;
  late _WatchAccounts watchAccounts;
  late _WatchCategories watchCategories;
  late _WatchDebts watchDebts;
  late _WatchStarts watchStarts;
  late _WatchCurrencies watchCurrencies;
  late _WatchSettings watchSettings;

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const RenamePayeeParams(id: 0, name: ''));
    registerFallbackValue(const MergePayeeParams(from: 0, into: 0));
  });

  setUp(() {
    watchPayees = _WatchPayees();
    watchMovements = _WatchMovements();
    watchAccounts = _WatchAccounts();
    watchCategories = _WatchCategories();
    watchDebts = _WatchDebts();
    watchStarts = _WatchStarts();
    watchCurrencies = _WatchCurrencies();
    watchSettings = _WatchSettings();
    when(
      () => watchPayees(any()),
    ).thenAnswer((_) => Stream.value([amazon, crepes, peaje, pragma, unused]));
    when(() => watchMovements(any()))
        .thenAnswer((_) => Stream.value(movements));
    when(() => watchAccounts(any())).thenAnswer(
      (_) =>
          Stream.value([account(id: 1), account(id: 2, currencyCode: 'USD')]),
    );
    when(() => watchCategories(any()))
        .thenAnswer((_) => Stream.value([category(id: 10, name: 'Tolls')]));
    when(() => watchDebts(any())).thenAnswer((_) => Stream.value([]));
    when(() => watchStarts(any())).thenAnswer((_) => Stream.value([]));
    when(() => watchCurrencies(any()))
        .thenAnswer((_) => Stream.value([cop, usd]));
    when(() => watchSettings(any())).thenAnswer((_) => Stream.value(settings));
  });

  group('PayeesCubit', () {
    PayeesCubit build() => PayeesCubit(
      watchPayees: watchPayees,
      watchMovements: watchMovements,
      watchAccounts: watchAccounts,
      watchCategories: watchCategories,
      watchPeriodStarts: watchStarts,
      watchCurrencies: watchCurrencies,
      watchSettings: watchSettings,
    );

    Future<PayeesCubit> loaded() async {
      final cubit = build()..load();
      await Future<void>.delayed(Duration.zero);
      return cubit;
    }

    test('lists the period, most spent first', () async {
      final cubit = await loaded();
      final state = cubit.state;
      expect(state.status, PayeesStatus.success);
      expect(state.currency, cop);
      expect(state.currencyOptions, [cop, usd]);
      expect(state.lines.map((l) => l.payee), [peaje, pragma]);
      final tolls = state.lines.first.stats;
      expect((tolls.count, tolls.expense), (2, 18000));
      expect(state.categoryOf(tolls.lastCategoryId)?.name, 'Tolls');
      await cubit.close();
    });

    test('all time adds older movements and unused entities', () async {
      final cubit = await loaded();
      cubit.scopeChanged(PayeeScope.allTime);
      expect(cubit.state.lines.map((l) => l.payee), [
        crepes,
        peaje,
        pragma,
        unused,
      ]);

      cubit.sortChanged(PayeeSort.used);
      expect(cubit.state.lines.first.payee, peaje);
      cubit.sortChanged(PayeeSort.name);
      expect(cubit.state.lines.first.payee, crepes);

      cubit.queryChanged(' PEA ');
      expect(cubit.state.lines.map((l) => l.payee), [peaje]);

      cubit
        ..queryChanged('')
        ..currencySelected('USD');
      expect(cubit.state.lines.map((l) => l.payee), [amazon, unused]);
      await cubit.close();
    });

    blocTest<PayeesCubit, PayeesState>(
      'reports a failed stream',
      setUp: () =>
          when(() => watchMovements(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: build,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        expect(cubit.state.status, PayeesStatus.failure);
        expect(cubit.state.lines, isEmpty);
      },
    );
  });

  group('PayeeDetailCubit', () {
    late _Rename rename;
    late _Merge merge;
    late _Delete delete;

    setUp(() {
      rename = _Rename();
      merge = _Merge();
      delete = _Delete();
      when(() => rename(any())).thenAnswer((_) async => const Ok(null));
      when(() => merge(any())).thenAnswer((_) async => const Ok(null));
      when(() => delete(any()))
          .thenAnswer((_) async => const Err(ValidationFailure('debt')));
    });

    PayeeDetailCubit build() => PayeeDetailCubit(
      watchPayees: watchPayees,
      watchMovements: watchMovements,
      watchAccounts: watchAccounts,
      watchCategories: watchCategories,
      watchDebts: watchDebts,
      watchPeriodStarts: watchStarts,
      watchCurrencies: watchCurrencies,
      watchSettings: watchSettings,
      rename: rename,
      merge: merge,
      delete: delete,
    );

    test('sums the entity in the period and ever', () async {
      when(() => watchDebts(any())).thenAnswer((_) => Stream.value([debt()]));
      final cubit = build()..load(1);
      await Future<void>.delayed(Duration.zero);
      final state = cubit.state;

      expect(state.status, PayeeDetailStatus.success);
      expect(state.payee, peaje);
      expect(state.currency, cop);
      expect(state.currencyOptions, [cop]);
      expect(state.payeeMovements.map((m) => m.id), [2, 1, 3]);
      expect(state.thisPeriod.expense, 18000);
      expect(state.allTime.expense, 26000);
      expect(state.allTime.averagePrice, 8667);
      expect(state.debt?.payeeId, 1);
      expect(state.mergeTargets, [amazon, crepes, pragma, unused]);
      expect(state.nameTaken('pragma'), isTrue);
      expect(state.nameTaken('peajepalmas'), isFalse);
      expect(state.categoryOf(state.payeeMovements.last), isNull);
      expect(state.accountById(1)?.id, 1);
      await cubit.close();
    });

    test('a movement in another currency picks that one', () async {
      final cubit = build()..load(5);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.currency, usd);
      cubit.currencySelected('COP');
      expect(cubit.state.payeeMovements, isEmpty);
      await cubit.close();
    });

    test('renames, merges and reports a refused delete', () async {
      final cubit = build()..load(1);
      await Future<void>.delayed(Duration.zero);

      await cubit.rename('Peaje');
      verify(
        () => rename(
          any(
            that: isA<RenamePayeeParams>()
                .having((p) => p.id, 'id', 1)
                .having((p) => p.name, 'name', 'Peaje'),
          ),
        ),
      ).called(1);
      await cubit.mergeInto(3);
      verify(
        () => merge(
          any(
            that: isA<MergePayeeParams>()
                .having((p) => p.from, 'from', 1)
                .having((p) => p.into, 'into', 3),
          ),
        ),
      ).called(1);
      await cubit.delete();
      expect(cubit.state.failure, isA<ValidationFailure>());
      await cubit.close();
    });

    test('a missing entity is not found; no id does nothing', () async {
      final cubit = build()..load(99);
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.status, PayeeDetailStatus.notFound);
      await cubit.close();

      final idle = build();
      await idle.rename('x');
      await idle.mergeInto(1);
      await idle.delete();
      verifyNever(() => rename(any()));
      verifyNever(() => merge(any()));
      verifyNever(() => delete(any()));
      expect(idle.state.period, isNull);
      await idle.close();
    });

    blocTest<PayeeDetailCubit, PayeeDetailState>(
      'reports a failed stream',
      setUp: () =>
          when(() => watchDebts(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: build,
      act: (cubit) => cubit.load(1),
      verify: (cubit) => expect(cubit.state.status, PayeeDetailStatus.failure),
    );
  });
}
