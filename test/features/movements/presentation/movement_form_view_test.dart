import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/movement_form_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/movement_form_page.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart' as fixtures;
import '../../../helpers/helpers.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  late MockMovementFormCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final bank = account(id: 1, name: 'Bank');
  final fund = account(
    id: 2,
    name: 'Fund',
    type: AccountType.pocket,
    parentAccountId: 1,
  );
  final wallet = account(id: 3, name: 'Wallet', currencyCode: 'USD');
  final food = category(id: 10, name: 'Eating out');
  final car = category(id: 11, name: 'Car');
  final salary = category(
    id: 12,
    name: 'Salary',
    type: CategoryType.income,
    role: CategoryRole.salary,
  );

  final ready = MovementFormState(
    status: MovementFormStatus.editing,
    categoryId: 10,
    accountId: 1,
    date: LocalDate.today(),
    accounts: [bank, fund, wallet],
    categories: [food, car, salary],
    currencies: const [cop, usd],
    payees: const [Payee(id: 5, name: 'Uber', key: 'uber')],
  );

  setUp(() {
    cubit = MockMovementFormCubit();
    router = MockGoRouter();
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => cubit.dateChanged(any())).thenAnswer((_) async {});
    when(() => router.canPop()).thenReturn(true);
  });

  setUpAll(() => registerFallbackValue(movementDay));

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<MovementFormCubit>.value(
        value: cubit,
        child: const MovementFormView(),
      ),
      router: router,
    );
  }

  testWidgets('shows loading and missing states', (tester) async {
    when(() => cubit.state).thenReturn(const MovementFormState());
    await pumpView(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('explains a missing movement', (tester) async {
    when(
      () => cubit.state,
    ).thenReturn(const MovementFormState(status: MovementFormStatus.notFound));
    await pumpView(tester);
    expect(find.text('This movement no longer exists.'), findsOneWidget);
  });

  testWidgets('types on the keypad and saves', (tester) async {
    when(() => cubit.state)
        .thenReturn(ready.copyWith(amount: const AmountInput('12000+3000')));

    await pumpView(tester);

    expect(find.text('Eating out'), findsOneWidget);
    expect(find.text('COP 12.000 + 3.000'), findsOneWidget);
    expect(find.text('= 15.000'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('000'), findsOneWidget);
    expect(find.byTooltip('Delete movement'), findsNothing);
    expect(find.text('Starts period'), findsNothing);

    await tester.tap(find.text('7'));
    await tester.tap(find.text('000'));
    await tester.tap(find.bySemanticsLabel('Plus'));
    await tester.tap(find.bySemanticsLabel('Delete'));
    await tester.tap(find.text('Save'));

    verify(() => cubit.keyPressed(KeypadKey.d7)).called(1);
    verify(() => cubit.keyPressed(KeypadKey.triple0)).called(1);
    verify(() => cubit.keyPressed(KeypadKey.add)).called(1);
    verify(() => cubit.keyPressed(KeypadKey.backspace)).called(1);
    verify(() => cubit.submit()).called(1);
  });

  testWidgets('a currency with decimals shows its separator key', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(ready.copyWith(accountId: 3));

    await pumpView(tester);
    await tester.tap(find.text(','));

    verify(() => cubit.keyPressed(KeypadKey.decimal)).called(1);
    expect(find.text('USD 0'), findsOneWidget);
  });

  testWidgets('changes category, account, payee, note and date', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(ready);

    await pumpView(tester);
    await tester.tap(find.byTooltip('Change category'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Car'));
    await tester.pumpAndSettle();
    verify(() => cubit.categoryChanged(11)).called(1);

    await tester.tap(find.byType(DropdownButtonFormField<int>));
    await tester.pumpAndSettle();
    expect(find.text('↳ Fund'), findsWidgets);
    await tester.tap(find.text('Wallet · USD').last);
    await tester.pumpAndSettle();
    verify(() => cubit.accountChanged(3)).called(1);

    await tester.enterText(find.byType(TextFormField).at(0), 'ub');
    await tester.pumpAndSettle();
    verify(() => cubit.payeeChanged('ub')).called(1);
    await tester.tap(find.text('Uber'));
    await tester.pumpAndSettle();
    verify(() => cubit.payeeChanged('Uber')).called(1);

    await tester.enterText(find.byType(TextFormField).at(1), 'Taxi');
    verify(() => cubit.noteChanged('Taxi')).called(1);

    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    verify(() => cubit.dateChanged(any())).called(1);
  });

  testWidgets('a salary can start a period', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        categoryId: 12,
        startsPeriod: true,
        date: LocalDate(2025, 3, 2),
      ),
    );

    await pumpView(tester);
    expect(find.textContaining('2025'), findsOneWidget);
    await tester.tap(find.text('Starts period'));

    verify(() => cubit.startsPeriodChanged(value: false)).called(1);
  });

  testWidgets('shows errors', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        categoryId: null,
        accountId: null,
        showErrors: true,
        errors: {
          MovementError.invalidAmount,
          MovementError.missingCategory,
          MovementError.missingAccount,
        },
      ),
    );

    await pumpView(tester);

    expect(find.text('Enter an amount above zero.'), findsOneWidget);
    expect(find.text('Pick a category.'), findsWidgets);
    expect(find.text('Pick an account.'), findsOneWidget);
  });

  testWidgets('a pending movement is confirmed and can be deleted', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        original: movement(id: 7, isPending: true),
        isPending: true,
        date: LocalDate.today().addDays(-1),
      ),
    );

    await pumpView(tester);
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('Confirm'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete movement'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(() => cubit.delete());

    await tester.tap(find.byTooltip('Delete movement'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this movement?'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    verify(() => cubit.delete()).called(1);
  });

  testWidgets('a stored movement can become recurring', (tester) async {
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
    when(() => cubit.state)
        .thenReturn(ready.copyWith(original: movement(id: 7)));

    await pumpView(tester);
    await tester.tap(find.byTooltip('Make recurring'));
    verify(() => router.push<Object?>('/recurring/new?from=7')).called(1);
  });

  testWidgets('hides the keypad while the system keyboard is open', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(ready);
    tester.view.viewInsets = const FakeViewPadding(bottom: 800);
    addTearDown(tester.view.resetViewInsets);

    await pumpView(tester);

    expect(find.text('000'), findsNothing);
  });

  testWidgets('goes back with true once saved', (tester) async {
    whenListen(
      cubit,
      Stream.value(ready.copyWith(status: MovementFormStatus.saved)),
      initialState: ready,
    );

    await pumpView(tester);
    await tester.pump();

    verify(() => router.pop<bool>(true)).called(1);
  });

  testWidgets('shows a snackbar when saving fails', (tester) async {
    whenListen(
      cubit,
      Stream.value(ready.copyWith(failure: const DatabaseFailure('x'))),
      initialState: ready,
    );

    await pumpView(tester);
    await tester.pump();

    expect(find.text('Something went wrong. Please try again.'), findsOne);
  });

  group('debt section', () {
    final loanGiven = category(
      id: 14,
      name: 'Loan given',
      role: CategoryRole.loanGiven,
    );
    final loanReceived = category(
      id: 13,
      name: 'Loan received',
      type: CategoryType.income,
      role: CategoryRole.loanReceived,
    );
    final anaLoan = fixtures.debt(
      id: 2,
      type: DebtType.owedToMe,
      name: 'Ana',
      initialPending: 100000,
    );
    final debts = [(debt: anaLoan, status: DebtStatus.of(anaLoan, const []))];

    testWidgets('a loan given picks a debt or creates one', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          categoryId: 14,
          categories: [food, loanGiven],
          debts: debts,
          debtId: 2,
          debtTouched: true,
        ),
      );
      await pumpView(tester);

      expect(find.text('Ana · 100.000 left'), findsOneWidget);
      expect(find.text('Entity'), findsNothing);
      await tester.tap(find.text('Ana · 100.000 left'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('New debt').last);
      await tester.pumpAndSettle();
      verify(() => cubit.debtChanged(null)).called(1);
    });

    testWidgets('a new debt shows its fields and errors', (tester) async {
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          type: MovementType.income,
          categoryId: 13,
          categories: [loanReceived],
          pillars: const [survival],
          showErrors: true,
          errors: const {
            MovementError.missingDebt,
            MovementError.missingDebtPillar,
          },
        ),
      );
      await pumpView(tester);

      expect(find.text('Debt'), findsNothing);
      expect(find.text('Enter who it is with.'), findsOneWidget);
      expect(find.text('Pick a pillar.'), findsOneWidget);
      await tester.enterText(
        find.byKey(const ValueKey('debtName')),
        'Car loan',
      );
      await tester.enterText(find.byKey(const ValueKey('debtPending')), '7000');
      await tester.ensureVisible(find.text('Pillar'));
      await tester.tap(find.text('Pillar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(survival.name).last);
      await tester.pumpAndSettle();

      verify(() => cubit.debtNameChanged('Car loan')).called(1);
      verify(() => cubit.debtPendingChanged('7000')).called(1);
      verify(() => cubit.debtPillarChanged(survival.id)).called(1);
    });

    testWidgets('a payment without a debt asks for one', (tester) async {
      final payment = category(id: 15, role: CategoryRole.debtPayment);
      when(() => cubit.state).thenReturn(
        ready.copyWith(
          categoryId: 15,
          categories: [payment],
          showErrors: true,
          errors: const {MovementError.missingDebt},
        ),
      );
      await pumpView(tester);
      expect(find.text('Pick the debt.'), findsOneWidget);
    });
  });
}
