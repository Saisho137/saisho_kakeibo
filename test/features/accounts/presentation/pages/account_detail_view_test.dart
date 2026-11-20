import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/account_detail_page.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/movement_fixtures.dart';

void main() {
  late MockAccountDetailCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final today = LocalDate.today();
  final lulo = account(id: 1, name: 'Lulo');
  final fund = account(
    id: 2,
    name: 'Fund',
    type: AccountType.pocket,
    parentAccountId: 1,
  );
  final visa = account(id: 3, name: 'Visa', type: AccountType.creditCard);
  final cdt = account(id: 4, name: 'CDT', type: AccountType.investment);

  AccountDetailState ready(Account a, {List<Movement> movements = const []}) =>
      AccountDetailState(
        status: AccountDetailStatus.success,
        accountId: a.id,
        accounts: [lulo, fund, visa, cdt],
        balances: const {1: 2000, 2: 3000, 3: -1200, 4: 900},
        currencies: const [cop],
        movements: movements,
        categories: [
          category(id: 10, name: 'Eating out'),
          category(id: 11, name: 'Salary', type: CategoryType.income),
          category(id: 12, name: 'Savings', type: CategoryType.transfer),
        ],
        payees: const [Payee(id: 5, name: 'Uber', key: 'uber')],
      );

  setUp(() {
    cubit = MockAccountDetailCubit();
    router = MockGoRouter();
    when(() => cubit.adjustBalance(any())).thenAnswer((_) async {});
    when(() => cubit.deleteMovement(any())).thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<AccountDetailCubit>.value(
        value: cubit,
        child: const AccountDetailView(),
      ),
      router: router,
    );
  }

  group('AccountDetailView', () {
    testWidgets('shows loading, missing and failed states', (tester) async {
      when(() => cubit.state).thenReturn(const AccountDetailState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing account', (tester) async {
      when(() => cubit.state).thenReturn(
        const AccountDetailState(status: AccountDetailStatus.notFound),
      );
      await pumpView(tester);
      expect(find.text('This account no longer exists.'), findsOneWidget);
    });

    testWidgets('shows the balance, the free part and no movements', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(ready(lulo));

      await pumpView(tester);

      expect(find.text('Lulo'), findsOneWidget);
      expect(find.text('5.000 COP'), findsOneWidget);
      expect(find.text('Free 2.000'), findsOneWidget);
      expect(find.text('No movements yet.'), findsOneWidget);
      await tester.tap(find.byTooltip('Edit account'));
      verify(() => router.push<Object?>('/accounts/1/edit')).called(1);
      await tester.tap(find.text('Transfer'));
      verify(() => router.push<Object?>('/transfers/new?from=1')).called(1);
    });

    testWidgets('lists movements by day as seen from the account', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(
        ready(
          lulo,
          movements: [
            movement(id: 1, categoryId: 10, payeeId: 5, date: today),
            movement(
              id: 2,
              type: MovementType.income,
              categoryId: 11,
              amount: 4000,
              isPending: true,
              note: 'March',
              date: today.addDays(-1),
            ),
            movement(
              id: 3,
              type: MovementType.transfer,
              categoryId: 12,
              toAccountId: 2,
              toAmount: 1000,
              date: today.addDays(-1),
            ),
            movement(
              id: 4,
              type: MovementType.transfer,
              categoryId: 12,
              accountId: 3,
              toAccountId: 1,
              toAmount: 500,
              date: LocalDate(2025, 1, 5),
            ),
            movement(
              id: 5,
              type: MovementType.adjustment,
              amount: 30,
              date: LocalDate(2025, 1, 5),
            ),
          ],
        ),
      );

      await pumpView(tester);

      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Yesterday'), findsOneWidget);
      expect(find.text('Sun, Jan 5, 2025'), findsOneWidget);
      expect(find.text('Eating out'), findsOneWidget);
      expect(find.text('Uber'), findsOneWidget);
      expect(find.text('-1.000'), findsNWidgets(2));
      expect(find.text('March · Pending'), findsOneWidget);
      expect(find.text('+4.000'), findsOneWidget);
      expect(find.text('To Fund'), findsOneWidget);
      expect(find.text('From Visa'), findsOneWidget);
      expect(find.text('+500'), findsOneWidget);
      expect(find.text('Balance adjustment'), findsOneWidget);
      expect(find.text('+30'), findsOneWidget);

      await tester.tap(find.text('Eating out'));
      verify(() => router.push<Object?>('/movements/1')).called(1);
      await tester.tap(find.text('To Fund'));
      verify(() => router.push<Object?>('/transfers/3')).called(1);
    });

    testWidgets('deletes an adjustment after confirming', (tester) async {
      when(() => cubit.state).thenReturn(
        ready(
          lulo,
          movements: [movement(id: 5, type: MovementType.adjustment)],
        ),
      );

      await pumpView(tester);
      await tester.tap(find.text('Balance adjustment'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.deleteMovement(any()));

      await tester.tap(find.text('Balance adjustment'));
      await tester.pumpAndSettle();
      expect(find.text('Delete this adjustment?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      verify(() => cubit.deleteMovement(5)).called(1);
    });

    testWidgets('adjusts the balance with the real one', (tester) async {
      when(() => cubit.state).thenReturn(ready(lulo));

      await pumpView(tester);
      await tester.tap(find.text('Adjust balance'));
      await tester.pumpAndSettle();
      final field = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(TextFormField),
      );
      expect(find.text('Real balance'), findsOneWidget);

      await tester.enterText(field, '1,5');
      await tester.tap(find.text('Save'));
      await tester.pump();
      expect(find.text('Enter an amount.'), findsOneWidget);

      await tester.enterText(field, '5.500');
      await tester.pump();
      expect(find.text('Difference: +500'), findsOneWidget);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      verify(() => cubit.adjustBalance(5500)).called(1);
    });

    testWidgets('accepts a negative balance and can be cancelled', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(ready(fund));

      await pumpView(tester);
      await tester.tap(find.text('Adjust balance'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextFormField),
        ),
        '-200',
      );
      await tester.pump();
      expect(find.text('Difference: -3.200'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.adjustBalance(any()));
    });

    testWidgets('a credit card asks for its debt', (tester) async {
      when(() => cubit.state).thenReturn(ready(visa));

      await pumpView(tester);
      await tester.tap(find.text('Adjust balance'));
      await tester.pumpAndSettle();
      expect(find.text('Current debt'), findsOneWidget);
      expect(find.text('1.200'), findsOneWidget);
      await tester.enterText(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextFormField),
        ),
        '1.000',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      verify(() => cubit.adjustBalance(-1000)).called(1);
    });

    testWidgets('an investment updates its value', (tester) async {
      when(() => cubit.state).thenReturn(ready(cdt));

      await pumpView(tester);
      await tester.tap(find.text('Update value'));
      await tester.pumpAndSettle();

      expect(find.text('Current value'), findsOneWidget);
    });

    testWidgets('leaves when the account is deleted', (tester) async {
      whenListen(
        cubit,
        Stream.value(
          const AccountDetailState(status: AccountDetailStatus.notFound),
        ),
        initialState: ready(lulo),
      );
      when(() => router.canPop()).thenReturn(true);

      await pumpView(tester);
      await tester.pump();

      verify(() => router.pop<Object?>()).called(1);
    });

    testWidgets('shows a snackbar when an action fails', (tester) async {
      whenListen(
        cubit,
        Stream.value(ready(lulo).copyWith(failure: const DatabaseFailure('x'))),
        initialState: ready(lulo),
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });

    testWidgets('a failed load shows an error', (tester) async {
      when(() => cubit.state).thenReturn(
        const AccountDetailState(status: AccountDetailStatus.failure),
      );
      await pumpView(tester);
      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });
}
