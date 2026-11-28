import 'dart:math';

import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/models/account_row_mapper.dart';
import 'package:saisho_kakeibo/features/categories/data/models/category_row_mapper.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/movements/data/models/movement_row_mapper.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payees_cubit.dart';

import '../helpers/fake_reminder_scheduler.dart';
import '../helpers/helpers.dart';

/// About five years of use: 5.000 movements over 1.800 days, 200 payees.
const int _movements = 5000;

/// Fills [db] with [_movements] movements and 200 payees.
Future<void> _seed(AppDatabase db) async {
  final accounts = await db.accountDao.getAll();
  final categories = await db.categoryDao.getAll();
  final expense = [
    for (final c in categories)
      if (c.type == CategoryType.expense) c.id,
  ];
  final random = Random(7);
  final today = LocalDate.today();
  await db.batch((batch) {
    batch.insertAll(db.payees, [
      for (var i = 0; i < 200; i++)
        PayeesCompanion.insert(name: 'Payee $i', key: 'payee$i'),
    ]);
  });
  await db.batch((batch) {
    batch.insertAll(db.movements, [
      for (var i = 0; i < _movements; i++)
        MovementsCompanion.insert(
          type: i % 10 == 0 ? MovementType.income : MovementType.expense,
          date: today.addDays(-random.nextInt(1800)),
          accountId: accounts[i % 2].id,
          amount: 1000 + random.nextInt(200000),
          categoryId: Value(expense[random.nextInt(expense.length)]),
          payeeId: Value(1 + random.nextInt(200)),
        ),
    ]);
  });
}

void main() {
  late AppDatabase db;

  setUpAll(() async {
    db = AppDatabase(NativeDatabase.memory());
    await _seed(db);
  });

  tearDownAll(() => db.close());

  /// Mean time of [body] over a few runs, after a warm-up.
  Future<Duration> time(Future<void> Function() body, {int runs = 5}) async {
    await body();
    final watch = Stopwatch()..start();
    for (var i = 0; i < runs; i++) {
      await body();
    }
    return watch.elapsed ~/ runs;
  }

  void report(String what, Duration took, Duration budget) {
    // The timings are the point of this test: they show in its output.
    // ignore: avoid_print
    print('$what: ${took.inMicroseconds / 1000} ms (budget $budget)');
    expect(took, lessThan(budget), reason: what);
  }

  group('With $_movements movements', () {
    const query = Duration(milliseconds: 150);
    const compute = Duration(milliseconds: 50);

    test('the queries stay fast', () async {
      report('all movements', await time(() => db.movementDao.getAll()), query);
      report('balances', await time(() => db.accountDao.getBalances()), query);
      report(
        'last of each payee',
        await time(() => db.movementDao.lastOfEachPayee('expense')),
        query,
      );
      report(
        'last of a category',
        await time(() => db.movementDao.lastOfCategory(10)),
        query,
      );
      report(
        'period starts',
        await time(() => db.periodDao.getStarts()),
        query,
      );
      report(
        'a debt movements',
        await time(() => db.debtDao.getMovements(1)),
        query,
      );
    });

    test('the Home and Entities compute fast', () async {
      final movements = [
        for (final row in await db.movementDao.getAll()) row.toEntity(),
      ];
      final accounts = [
        for (final row in await db.accountDao.getAll()) row.toEntity(),
      ];
      final categories = [
        for (final row in await db.categoryDao.getAll()) row.toEntity(),
      ];
      const cop = Currency(
        code: 'COP',
        symbol: r'$',
        format: CurrencyFormat.cop,
      );
      final home = HomeState(
        status: HomeStatus.success,
        today: LocalDate.today(),
        settings: const AppSettings(),
        accounts: accounts,
        balances: const {},
        currencies: const [cop],
        movements: movements,
        periodStarts: const [],
        categories: categories,
        pillars: const [],
        payees: const [],
        debts: const [],
      );
      report('Home periods', await time(() async => home.periods), compute);
      final period = home.visiblePeriod!;
      report(
        'Home page (totals + donut)',
        await time(() async {
          home
            ..totalsOf(period)
            ..donutOf(period);
        }),
        compute,
      );
      report(
        'Home history by day',
        await time(() async => home.daysOf(period)),
        compute,
      );
      final payees = PayeesState(
        status: PayeesStatus.success,
        today: LocalDate.today(),
        payees: const [],
        movements: movements,
        accounts: accounts,
        categories: categories,
        periodStarts: const [],
        currencies: const [cop],
        settings: const AppSettings(),
        scope: PayeeScope.allTime,
      );
      report('Entities lines', await time(() async => payees.lines), compute);
    });

    testWidgets('the app opens its busiest screens quickly', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.625;
      addTearDown(tester.view.reset);
      final appDb = AppDatabase(NativeDatabase.memory());
      await tester.runAsync(() => _seed(appDb));
      await configureDependencies(
        database: appDb,
        appInfo: const AppInfo(version: '0.1.0', buildNumber: '1'),
        reminderScheduler: FakeReminderScheduler(),
      );
      addTearDown(getIt.reset);
      const budget = Duration(seconds: 2);

      Future<void> step(String what, Future<void> Function() body) async {
        final watch = Stopwatch()..start();
        await body();
        await tester.pumpAndSettle();
        report(what, watch.elapsed, budget);
      }

      await step('open the Home', () => tester.pumpWidget(const App()));
      expect(find.byTooltip('History'), findsOneWidget);
      await step(
        'open the history',
        () => tester.tap(find.byTooltip('History')),
      );
      await tester.tap(find.byTooltip('Close the history'));
      await tester.pumpAndSettle();
      await step(
        'open the quick entry',
        () => tester.tap(find.byTooltip('Expense')),
      );
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Go to'));
      await tester.pumpAndSettle();
      await step('open Entities', () => tester.tap(find.text('Entities')));
      expect(find.textContaining('Payee '), findsWidgets);
      await tester.disposeDriftStreams();
    });
  });
}
