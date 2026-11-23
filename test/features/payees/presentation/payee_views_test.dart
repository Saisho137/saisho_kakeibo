import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payee_detail_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payees_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/pages/payee_detail_page.dart';
import 'package:saisho_kakeibo/features/payees/presentation/pages/payees_page.dart';
import 'package:saisho_kakeibo/features/payees/presentation/widgets/price_chart.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const peaje = Payee(id: 1, name: 'Peaje Palmas', key: 'peajepalmas');
  const pragma = Payee(id: 2, name: 'Pragma', key: 'pragma');
  const unused = Payee(id: 3, name: 'Unused', key: 'unused');
  final today = LocalDate.today();
  const settings = AppSettings(periodType: PeriodType.monthly, cutoffDay: 1);
  final movements = [
    movement(id: 1, payeeId: 1, amount: 12000, date: today, categoryId: 10),
    movement(id: 2, payeeId: 1, amount: 10000, date: today.addDays(-40)),
    movement(
      id: 3,
      payeeId: 2,
      type: MovementType.income,
      amount: 5000000,
      date: today,
    ),
  ];

  late MockGoRouter router;

  setUp(() {
    router = MockGoRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
    when(() => router.pop()).thenReturn(null);
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(1080, 3000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(child, router: router);
  }

  group('PayeesView', () {
    late MockPayeesCubit cubit;
    final ready = PayeesState(
      status: PayeesStatus.success,
      today: today,
      payees: const [peaje, pragma, unused],
      movements: movements,
      accounts: [
        account(id: 1),
        account(id: 2, currencyCode: 'USD'),
      ],
      categories: [category(id: 10, name: 'Tolls')],
      periodStarts: const [],
      currencies: const [cop, usd],
      settings: settings,
    );

    setUp(() {
      cubit = MockPayeesCubit();
      when(() => cubit.state).thenReturn(ready);
    });

    Future<void> pumpView(WidgetTester tester) => pump(
      tester,
      BlocProvider<PayeesCubit>.value(value: cubit, child: const PayeesView()),
    );

    testWidgets('lists the period with counts and net totals', (tester) async {
      await pumpView(tester);

      expect(find.text('Peaje Palmas'), findsOneWidget);
      expect(find.text('×1'), findsNWidgets(2));
      expect(find.text('12.000'), findsOneWidget);
      expect(find.text('+5.000.000'), findsOneWidget);
      expect(find.text('Unused'), findsNothing);

      await tester.tap(find.text('Peaje Palmas'));
      verify(() => router.push<Object?>('/payees/1')).called(1);
      await tester.enterText(find.byType(TextField), 'pea');
      verify(() => cubit.queryChanged('pea')).called(1);
      await tester.tap(find.text('All time'));
      verify(() => cubit.scopeChanged(PayeeScope.allTime)).called(1);
    });

    testWidgets('sorts and switches currency', (tester) async {
      await pumpView(tester);
      await tester.tap(find.byTooltip('Sort'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A-Z'));
      await tester.pumpAndSettle();
      verify(() => cubit.sortChanged(PayeeSort.name)).called(1);

      await tester.tap(find.text('COP'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('USD').last);
      await tester.pumpAndSettle();
      verify(() => cubit.currencySelected('USD')).called(1);
    });

    testWidgets('all time shows unused entities; empty states', (tester) async {
      when(() => cubit.state)
          .thenReturn(ready.copyWith(scope: PayeeScope.allTime));
      await pumpView(tester);
      expect(find.text('Unused'), findsOneWidget);
      expect(find.text('×0'), findsOneWidget);
    });

    testWidgets('explains an empty list and no matches', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(payees: const []));
      await pumpView(tester);
      expect(
        find.text('No entities with movements in this period.'),
        findsOneWidget,
      );
    });

    testWidgets('explains no entities at all and no matches', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(ready.copyWith(payees: const [], scope: PayeeScope.allTime));
      await pumpView(tester);
      expect(find.textContaining('No entities yet.'), findsOneWidget);
    });

    testWidgets('explains a search without matches', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(query: 'zzz'));
      await pumpView(tester);
      expect(find.text('Nothing matches.'), findsOneWidget);
    });

    testWidgets('shows loading and a failed load', (tester) async {
      when(() => cubit.state).thenReturn(const PayeesState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      when(() => cubit.state)
          .thenReturn(const PayeesState(status: PayeesStatus.failure));
      await pumpView(tester);
      await tester.pump();
    });
  });

  group('PayeeDetailView', () {
    late MockPayeeDetailCubit cubit;
    final ready = PayeeDetailState(
      status: PayeeDetailStatus.success,
      payeeId: 1,
      today: today,
      payees: const [peaje, pragma],
      movements: movements,
      accounts: [account(id: 1)],
      categories: [category(id: 10, name: 'Tolls')],
      debts: const [],
      periodStarts: const [],
      currencies: const [cop],
      settings: settings,
    );

    setUp(() {
      cubit = MockPayeeDetailCubit();
      when(() => cubit.state).thenReturn(ready);
      when(() => cubit.rename(any())).thenAnswer((_) async {});
      when(() => cubit.mergeInto(any())).thenAnswer((_) async {});
      when(() => cubit.delete()).thenAnswer((_) async {});
    });

    Future<void> pumpView(WidgetTester tester) => pump(
      tester,
      BlocProvider<PayeeDetailCubit>.value(
        value: cubit,
        child: const PayeeDetailView(),
      ),
    );

    Future<void> openMenu(WidgetTester tester, String action) async {
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(action).last);
      await tester.pumpAndSettle();
    }

    testWidgets('shows the totals, the chart and the movements', (
      tester,
    ) async {
      await pumpView(tester);

      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Peaje Palmas'),
        ),
        findsOneWidget,
      );
      expect(find.text('22.000'), findsOneWidget);
      expect(find.text('11.000'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.byType(PriceChart), findsOneWidget);
      expect(find.text('Tolls'), findsOneWidget);

      await tester.tap(find.text('Tolls'));
      verify(() => router.push<Object?>('/movements/1')).called(1);
    });

    testWidgets('renames, refusing a taken name', (tester) async {
      await pumpView(tester);
      await openMenu(tester, 'Rename');

      await tester.enterText(find.byType(TextFormField), 'pragma');
      await tester.pump();
      expect(
        find.text('Another entity has this name: merge into it instead.'),
        findsOneWidget,
      );
      await tester.enterText(find.byType(TextFormField), ' ');
      await tester.pump();
      expect(find.text('Enter a name.'), findsOneWidget);
      await tester.enterText(find.byType(TextFormField), 'Peaje');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      verify(() => cubit.rename('Peaje')).called(1);

      await openMenu(tester, 'Rename');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.rename(any(that: isNot('Peaje'))));
    });

    testWidgets('merges into another after confirming', (tester) async {
      await pumpView(tester);
      await openMenu(tester, 'Merge into…');
      expect(find.text('Merge Peaje Palmas into…'), findsOneWidget);
      await tester.tap(find.text('Pragma'));
      await tester.pumpAndSettle();
      expect(find.text('Merge into Pragma?'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.mergeInto(any()));

      await openMenu(tester, 'Merge into…');
      await tester.tap(find.text('Pragma'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Merge'));
      await tester.pumpAndSettle();
      verify(() => cubit.mergeInto(2)).called(1);
    });

    testWidgets('deletes after confirming', (tester) async {
      await pumpView(tester);
      await openMenu(tester, 'Delete');
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.delete());
      await openMenu(tester, 'Delete');
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();
      verify(() => cubit.delete()).called(1);
    });

    testWidgets('the entity of a debt links to it and is not deleted', (
      tester,
    ) async {
      when(() => cubit.state)
          .thenReturn(ready.copyWith(debts: [debt(name: 'Peaje Palmas')]));
      await pumpView(tester);
      expect(find.text('Debt: Peaje Palmas'), findsOneWidget);
      await tester.tap(find.text('Debt: Peaje Palmas'));
      verify(() => router.push<Object?>('/debts/1')).called(1);

      await openMenu(tester, 'Rename');
      expect(find.text('The debt Peaje Palmas is renamed too.'), findsOne);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('More actions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();
      expect(find.text('Delete Peaje Palmas?'), findsNothing);
    });

    testWidgets('switches the currency of an entity in two', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          accounts: [
            account(id: 1),
            account(id: 2, currencyCode: 'USD'),
          ],
          currencies: const [cop, usd],
          movements: [
            ...movements,
            movement(id: 9, payeeId: 1, accountId: 2, date: today),
          ],
          selectedCurrencyCode: 'COP',
        ),
      );
      await pumpView(tester);
      await tester.tap(find.text('COP'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('USD').last);
      await tester.pumpAndSettle();
      verify(() => cubit.currencySelected('USD')).called(1);
    });

    testWidgets('shows loading, missing and failed states', (tester) async {
      when(() => cubit.state).thenReturn(const PayeeDetailState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing entity', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(const PayeeDetailState(status: PayeeDetailStatus.notFound));
      await pumpView(tester);
      expect(find.text('This entity no longer exists.'), findsOneWidget);
    });

    testWidgets('a failed load shows an error', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(const PayeeDetailState(status: PayeeDetailStatus.failure));
      await pumpView(tester);
      expect(
        find.text('Something went wrong. Please try again.'),
        findsOneWidget,
      );
    });

    testWidgets('leaves when merged away and shows failures', (tester) async {
      whenListen(
        cubit,
        Stream.fromIterable([
          ready.copyWith(failure: const DatabaseFailure('disk')),
          ready.copyWith(status: PayeeDetailStatus.notFound),
        ]),
        initialState: ready,
      );
      await pumpView(tester);
      await tester.pump();
      expect(
        find.text('Something went wrong. Please try again.'),
        findsOneWidget,
      );
      verify(() => router.pop()).called(1);
    });
  });
}
