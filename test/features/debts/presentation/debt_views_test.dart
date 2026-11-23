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
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_detail_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_form_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/pages/debt_detail_page.dart';
import 'package:saisho_kakeibo/features/debts/presentation/pages/debt_form_page.dart';
import 'package:saisho_kakeibo/features/debts/presentation/pages/debts_page.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const payees = [
    Payee(id: 1, name: 'Bancolombia', key: 'bancolombia'),
    Payee(id: 2, name: 'Ana', key: 'ana'),
  ];
  final mortgage = debt(dueDay: 5);
  final old = debt(id: 2, name: 'Old loan', initialPending: 100);
  final lent = debt(
    id: 3,
    type: DebtType.owedToMe,
    name: 'Loan to Ana',
    payeeId: 2,
    initialPending: 200000,
    dueDate: LocalDate(2026, 6, 1),
  );
  final today = LocalDate.today();
  final payment = movement(
    id: 9,
    amount: 250000,
    categoryId: 10,
    date: today,
  ).copyWith(debtId: 1);
  final settle = movement(id: 10, amount: 300).copyWith(debtId: 2);
  final visa = account(
    id: 7,
    name: 'Visa',
    type: AccountType.creditCard,
    paymentDay: 15,
  );

  late MockGoRouter router;

  setUp(() {
    router = MockGoRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
    when(() => router.pop<Object?>(any())).thenReturn(null);
    when(() => router.pop()).thenReturn(null);
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(1080, 3000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(child, router: router);
  }

  group('DebtsView', () {
    late MockDebtsCubit cubit;
    final ready = DebtsState(
      status: DebtsStatus.success,
      debts: [mortgage, old, lent],
      movements: [payment, settle],
      accounts: [account(id: 1), visa],
      balances: const {7: -1200000},
      pillars: pillars,
      currencies: const [cop, usd],
      settings: const AppSettings(),
    );

    setUp(() {
      cubit = MockDebtsCubit();
      when(() => cubit.state).thenReturn(ready);
    });

    Future<void> pumpView(WidgetTester tester) => pump(
      tester,
      BlocProvider<DebtsCubit>.value(value: cubit, child: const DebtsView()),
    );

    testWidgets('lists what I owe, the cards and the paid off', (tester) async {
      await pumpView(tester);

      expect(find.text('750.000'), findsOneWidget);
      expect(find.text('Mortgage'), findsOneWidget);
      expect(find.text('750.000 left'), findsOneWidget);
      expect(find.text('25%'), findsOneWidget);
      expect(find.text('Survival · due day 5'), findsOneWidget);
      expect(find.text('Visa'), findsOneWidget);
      expect(find.text('-1.200.000'), findsOneWidget);
      expect(find.text('due day 15'), findsOneWidget);
      expect(find.text('Paid off (1)'), findsOneWidget);

      await tester.tap(find.text('Paid off (1)'));
      await tester.pumpAndSettle();
      expect(find.text('Paid off'), findsOneWidget);

      await tester.tap(find.text('Mortgage'));
      verify(() => router.push<Object?>('/debts/1')).called(1);
      await tester.tap(find.text('Visa'));
      verify(() => router.push<Object?>('/accounts/7')).called(1);
      await tester.tap(find.byTooltip('New debt'));
      verify(() => router.push<Object?>('/debts/new?type=iOwe')).called(1);
    });

    testWidgets('the other tab lists what is owed to me', (tester) async {
      await pumpView(tester);
      await tester.tap(find.text('Owed to me'));
      await tester.pumpAndSettle();

      expect(find.text('Loan to Ana'), findsOneWidget);
      expect(find.textContaining('due Jun 1, 2026'), findsOneWidget);
      await tester.tap(find.byTooltip('New debt'));
      verify(() => router.push<Object?>('/debts/new?type=owedToMe')).called(1);
    });

    testWidgets('switches currency and explains empty tabs', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(ready.copyWith(debts: const [], accounts: [account(id: 1)]));
      await pumpView(tester);
      expect(find.textContaining('Nothing to pay back'), findsOneWidget);
      expect(find.text('COP'), findsNothing);
    });

    testWidgets('picks another currency', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          debts: [
            mortgage,
            debt(id: 5, currencyCode: 'USD'),
          ],
        ),
      );
      await pumpView(tester);
      await tester.tap(find.text('COP'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('USD').last);
      verify(() => cubit.currencySelected('USD')).called(1);
    });

    testWidgets('shows loading and a failed load', (tester) async {
      when(() => cubit.state).thenReturn(const DebtsState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows an error', (tester) async {
      when(() => cubit.state)
          .thenReturn(const DebtsState(status: DebtsStatus.failure));
      await pumpView(tester);
      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });

  group('DebtDetailView', () {
    late MockDebtDetailCubit cubit;
    final ready = DebtDetailState(
      status: DebtDetailStatus.success,
      debtId: 1,
      debts: [mortgage],
      movements: [payment],
      accounts: [account(id: 1)],
      categories: [category(id: 10, name: 'Debt payment')],
      payees: payees,
      pillars: pillars,
      currencies: const [cop],
    );

    setUp(() {
      cubit = MockDebtDetailCubit();
      when(() => cubit.state).thenReturn(ready);
      when(() => cubit.editPending(any())).thenAnswer((_) async {});
      when(() => cubit.delete()).thenAnswer((_) async {});
    });

    Future<void> pumpView(WidgetTester tester) => pump(
      tester,
      BlocProvider<DebtDetailCubit>.value(
        value: cubit,
        child: const DebtDetailView(),
      ),
    );

    testWidgets('shows what is pending and the payments', (tester) async {
      await pumpView(tester);

      expect(find.text('750.000 COP'), findsOneWidget);
      expect(find.text('Registered with 1.000.000'), findsOneWidget);
      expect(find.text('Survival · due day 5'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('-250.000'), findsOneWidget);
      expect(find.byTooltip('Delete debt'), findsNothing);

      await tester.tap(find.text('Debt payment'));
      verify(() => router.push<Object?>('/movements/9')).called(1);
      await tester.tap(find.byTooltip('Edit debt'));
      verify(() => router.push<Object?>('/debts/1/edit')).called(1);
    });

    testWidgets('edits the pending amount', (tester) async {
      await pumpView(tester);
      await tester.tap(find.text('Edit pending'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'abc');
      await tester.pump();
      expect(find.text('Enter a valid amount.'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.enterText(find.byType(TextFormField), '700.000');
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      verify(() => cubit.editPending(700000)).called(1);

      await tester.tap(find.text('Edit pending'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.editPending(any(that: isNot(700000))));
    });

    testWidgets('an unused debt is deleted after confirming', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          movements: const [],
          debts: [mortgage.copyWith(adjustment: -1100000)],
        ),
      );
      await pumpView(tester);

      expect(find.text('-100.000 COP'), findsOneWidget);
      expect(find.text('No payments yet.'), findsOneWidget);
      await tester.tap(find.byTooltip('Delete debt'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.delete());
      await tester.tap(find.byTooltip('Delete debt'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      verify(() => cubit.delete()).called(1);
    });

    testWidgets('pays a debt I owe', (tester) async {
      final categories = [
        category(id: 12, role: CategoryRole.debtPayment),
        category(
          id: 16,
          type: CategoryType.income,
          role: CategoryRole.loanRepaid,
        ),
      ];
      when(() => cubit.state)
          .thenReturn(ready.copyWith(categories: categories));
      await pumpView(tester);
      await tester.tap(find.text('Pay'));
      verify(
        () => router.push<Object?>(
          '/movements/new?type=expense&category=12&debt=1',
        ),
      ).called(1);
    });

    testWidgets('collects a debt owed to me', (tester) async {
      final categories = [
        category(
          id: 16,
          type: CategoryType.income,
          role: CategoryRole.loanRepaid,
        ),
      ];
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          debtId: 3,
          debts: [lent],
          movements: const [],
          categories: categories,
        ),
      );
      await pumpView(tester);
      await tester.tap(find.text('Collect'));
      verify(
        () => router.push<Object?>(
          '/movements/new?type=income&category=16&debt=3',
        ),
      ).called(1);
    });

    testWidgets('a debt owed to me shows its date', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(debtId: 3, debts: [lent], movements: const []),
      );
      await pumpView(tester);
      expect(find.textContaining('due Jun 1, 2026'), findsOneWidget);
    });

    testWidgets('shows loading, missing and failed states', (tester) async {
      when(() => cubit.state).thenReturn(const DebtDetailState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing debt', (tester) async {
      when(() => cubit.state)
          .thenReturn(const DebtDetailState(status: DebtDetailStatus.notFound));
      await pumpView(tester);
      expect(find.text('This debt no longer exists.'), findsOneWidget);
    });

    testWidgets('leaves when deleted and shows failures', (tester) async {
      whenListen(
        cubit,
        Stream.fromIterable([
          ready.copyWith(failure: const DatabaseFailure('disk')),
          const DebtDetailState(status: DebtDetailStatus.notFound),
        ]),
        initialState: ready,
      );
      await pumpView(tester);
      await tester.pump();
      expect(find.text('Something went wrong. Please try again.'), findsOne);
      verify(() => router.pop()).called(1);
    });

    testWidgets('a failed load shows an error', (tester) async {
      when(() => cubit.state)
          .thenReturn(const DebtDetailState(status: DebtDetailStatus.failure));
      await pumpView(tester);
      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });

  group('DebtFormView', () {
    late MockDebtFormCubit cubit;
    const editing = DebtFormState(
      status: DebtFormStatus.editing,
      iconKey: 'request_quote',
      color: 0xFFF4511E,
      currencyCode: 'COP',
      pillars: pillars,
      currencies: [cop, usd],
    );

    setUpAll(() {
      registerFallbackValue(DebtType.iOwe);
      registerFallbackValue(LocalDate(2026, 1, 1));
    });

    setUp(() {
      cubit = MockDebtFormCubit();
      when(() => cubit.state).thenReturn(editing);
      when(() => cubit.submit()).thenAnswer((_) async {});
    });

    Future<void> pumpView(WidgetTester tester) => pump(
      tester,
      BlocProvider<DebtFormCubit>.value(
        value: cubit,
        child: const DebtFormView(),
      ),
    );

    testWidgets('forwards the fields to the cubit', (tester) async {
      await pumpView(tester);

      expect(find.text('New debt'), findsOneWidget);
      await tester.tap(find.text('Owed to me'));
      verify(() => cubit.typeChanged(DebtType.owedToMe)).called(1);
      await tester.enterText(find.byKey(const ValueKey('name')), 'Car');
      verify(() => cubit.nameChanged('Car')).called(1);
      await tester.enterText(find.byKey(const ValueKey('pending')), '100');
      verify(() => cubit.pendingChanged('100')).called(1);
      await tester.enterText(find.byKey(const ValueKey('installment')), '5');
      verify(() => cubit.installmentChanged('5')).called(1);

      await tester.tap(find.text('Pillar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Leisure').last);
      await tester.pumpAndSettle();
      verify(() => cubit.pillarChanged(2)).called(1);

      await tester.tap(find.text('Currency'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('USD').last);
      await tester.pumpAndSettle();
      verify(() => cubit.currencyChanged('USD')).called(1);

      await tester.tap(find.text('Due day (optional)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('5').last);
      await tester.pumpAndSettle();
      verify(() => cubit.dueDayChanged(5)).called(1);

      await tester.tap(find.text('Save'));
      verify(() => cubit.submit()).called(1);
    });

    testWidgets('picks the icon and the color', (tester) async {
      await pumpView(tester);
      await tester.tap(find.byType(InkResponse).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.home_rounded).first);
      await tester.pumpAndSettle();
      verify(() => cubit.iconChanged('home', any())).called(1);

      await tester.tap(find.text('Change color'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(InkResponse).last);
      await tester.pumpAndSettle();
      verify(() => cubit.colorChanged(any())).called(1);
    });

    testWidgets('a debt owed to me asks a due date; errors show', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(
        editing.copyWith(
          type: DebtType.owedToMe,
          dueDate: LocalDate(2026, 6, 1),
          showErrors: true,
          errors: {
            DebtError.emptyName,
            DebtError.invalidPending,
            DebtError.invalidInstallment,
          },
        ),
      );
      await pumpView(tester);

      expect(find.text('Pillar'), findsNothing);
      expect(find.text('Jun 1, 2026'), findsOneWidget);
      expect(find.text('Enter a name.'), findsOneWidget);
      expect(find.text('Enter a valid amount.'), findsOneWidget);
      expect(find.text('Enter an installment above zero.'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear'));
      verify(() => cubit.dueDateChanged(null)).called(1);

      await tester.tap(find.text('Due date (optional)'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      verify(() => cubit.dueDateChanged(LocalDate(2026, 6, 1))).called(1);
    });

    testWidgets('editing shows the name, locked currency and errors', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(
        editing.copyWith(
          original: mortgage,
          currencyLocked: true,
          dueDay: 5,
          showErrors: true,
          errors: {DebtError.nameTooLong, DebtError.missingPillar},
        ),
      );
      await pumpView(tester);

      expect(find.text('Edit Mortgage'), findsOneWidget);
      expect(find.text('I owe'), findsNothing);
      expect(find.text('A debt with movements keeps its currency.'), findsOne);
      expect(find.text('Use 40 characters at most.'), findsOneWidget);
      expect(find.text('Pick a pillar.'), findsOneWidget);
      await tester.tap(find.byTooltip('Clear'));
      verify(() => cubit.dueDayChanged(null)).called(1);
    });

    testWidgets('shows loading and not found', (tester) async {
      when(() => cubit.state).thenReturn(const DebtFormState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing debt', (tester) async {
      when(() => cubit.state)
          .thenReturn(const DebtFormState(status: DebtFormStatus.notFound));
      await pumpView(tester);
      expect(find.text('This debt no longer exists.'), findsOneWidget);
    });

    testWidgets('goes back once saved and shows failures', (tester) async {
      whenListen(
        cubit,
        Stream.fromIterable([
          editing.copyWith(failure: const DatabaseFailure('disk')),
          editing.copyWith(status: DebtFormStatus.saved),
        ]),
        initialState: editing,
      );
      await pumpView(tester);
      await tester.pump();
      expect(find.text('Something went wrong. Please try again.'), findsOne);
      verify(() => router.pop<bool>(true)).called(1);
    });
  });

  test('a movement may reference a debt', () {
    expect(payment.type, MovementType.expense);
  });
}
