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
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/transfer_form_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/transfer_form_page.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  late MockTransferFormCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final cash = account(id: 1, name: 'Cash', type: AccountType.cash);
  final bank = account(id: 2, name: 'Bank');
  final wallet = account(id: 3, name: 'Wallet', currencyCode: 'USD');
  final fund = account(
    id: 4,
    name: 'Fund',
    type: AccountType.pocket,
    parentAccountId: 2,
  );
  final savings = category(
    id: 20,
    name: 'Savings',
    type: CategoryType.transfer,
  );
  final between = category(
    id: 21,
    name: 'Between accounts',
    type: CategoryType.transfer,
  );

  final ready = TransferFormState(
    status: TransferFormStatus.editing,
    fromAccountId: 2,
    date: LocalDate.today(),
    accounts: [cash, bank, wallet, fund],
    categories: [savings, between],
    currencies: const [cop, usd],
  );

  setUp(() {
    cubit = MockTransferFormCubit();
    router = MockGoRouter();
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => cubit.fromChanged(any())).thenAnswer((_) async {});
    when(() => cubit.toChanged(any())).thenAnswer((_) async {});
    when(() => router.canPop()).thenReturn(true);
  });

  setUpAll(() => registerFallbackValue(movementDay));

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<TransferFormCubit>.value(
        value: cubit,
        child: const TransferFormView(),
      ),
      router: router,
    );
  }

  testWidgets('shows loading and missing states', (tester) async {
    when(() => cubit.state).thenReturn(const TransferFormState());
    await pumpView(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('explains a missing transfer', (tester) async {
    when(
      () => cubit.state,
    ).thenReturn(const TransferFormState(status: TransferFormStatus.notFound));
    await pumpView(tester);
    expect(find.text('This movement no longer exists.'), findsOneWidget);
  });

  testWidgets('fills a new transfer and saves', (tester) async {
    when(() => cubit.state)
        .thenReturn(ready.copyWith(amount: const AmountInput('5000+1000')));

    await pumpView(tester);
    expect(find.text('New transfer'), findsOneWidget);
    expect(find.text('COP 5.000 + 1.000'), findsOneWidget);
    expect(find.text('= 6.000'), findsOneWidget);
    expect(find.text('Received'), findsNothing);

    await tester.tap(find.text('7'));
    await tester.tap(find.byType(DropdownButtonFormField<int>).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('↳ Fund').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<int>).at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cash · COP').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<int>).at(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Between accounts').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'ATM');
    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));

    verify(() => cubit.keyPressed(KeypadKey.d7)).called(1);
    verify(() => cubit.toChanged(4)).called(1);
    verify(() => cubit.fromChanged(1)).called(1);
    verify(() => cubit.categoryChanged(21)).called(1);
    verify(() => cubit.noteChanged('ATM')).called(1);
    verify(() => cubit.dateChanged(any())).called(1);
    verify(() => cubit.submit()).called(1);
  });

  testWidgets('between currencies shows what is received', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        fromAccountId: 3,
        toAccountId: 2,
        amount: const AmountInput('10.5'),
        toAmount: const AmountInput('42000'),
        editingTo: true,
      ),
    );

    await pumpView(tester);
    expect(find.text('USD 10,5'), findsOneWidget);
    expect(find.text('COP 42.000'), findsOneWidget);
    expect(find.text('000'), findsOneWidget);

    await tester.tap(find.text('Sent'));
    verify(() => cubit.editingToChanged(value: false)).called(1);
    await tester.tap(find.text('Received'));
    verify(() => cubit.editingToChanged(value: true)).called(1);
  });

  testWidgets('a transfer inside one account explains the total', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(ready.copyWith(toAccountId: 4));

    await pumpView(tester);

    expect(
      find.textContaining("doesn't add to the Transfers total"),
      findsOneWidget,
    );
  });

  testWidgets('shows errors', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        fromAccountId: null,
        showErrors: true,
        errors: {
          MovementError.invalidAmount,
          MovementError.missingAccount,
          MovementError.missingCategory,
        },
      ),
    );

    await pumpView(tester);

    expect(find.text('Enter an amount above zero.'), findsOneWidget);
    expect(find.text('Pick an account.'), findsOneWidget);
    expect(find.text('Pick the account that receives it.'), findsOneWidget);
    expect(find.text('Pick a category.'), findsOneWidget);
  });

  testWidgets('says when both accounts are the same', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        toAccountId: 2,
        showErrors: true,
        errors: {MovementError.sameAccounts},
      ),
    );

    await pumpView(tester);

    expect(find.text('Pick two different accounts.'), findsNWidgets(2));
  });

  testWidgets('edits and deletes a stored transfer', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        original: movement(id: 9, type: MovementType.transfer),
        toAccountId: 1,
        date: LocalDate(2025, 3, 2),
      ),
    );

    await pumpView(tester);
    expect(find.text('Transfer'), findsOneWidget);
    expect(find.textContaining('2025'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete transfer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    verifyNever(() => cubit.delete());

    await tester.tap(find.byTooltip('Delete transfer'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this transfer?'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    verify(() => cubit.delete()).called(1);
  });

  testWidgets('a stored transfer can become recurring', (tester) async {
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        original: movement(id: 9, type: MovementType.transfer, isPending: true),
        toAccountId: 1,
      ),
    );

    await pumpView(tester);
    expect(find.text('Confirm'), findsOneWidget);
    await tester.tap(find.byTooltip('Make recurring'));
    verify(() => router.push<Object?>('/recurring/new?from=9')).called(1);
  });

  testWidgets('a transfer of a template is already recurring', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        original: movement(
          id: 9,
          type: MovementType.transfer,
        ).copyWith(recurringTemplateId: 2),
        toAccountId: 1,
      ),
    );

    await pumpView(tester);
    expect(find.byTooltip('Make recurring'), findsNothing);
  });

  testWidgets('shows yesterday and hides the keypad with the keyboard', (
    tester,
  ) async {
    when(() => cubit.state)
        .thenReturn(ready.copyWith(date: LocalDate.today().addDays(-1)));
    tester.view.viewInsets = const FakeViewPadding(bottom: 800);
    addTearDown(tester.view.resetViewInsets);

    await pumpView(tester);

    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('000'), findsNothing);
  });

  testWidgets('goes back once saved', (tester) async {
    whenListen(
      cubit,
      Stream.value(ready.copyWith(status: TransferFormStatus.saved)),
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
}
