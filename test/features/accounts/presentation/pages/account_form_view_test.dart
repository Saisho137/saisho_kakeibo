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
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/account_form_page.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late MockAccountFormCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final main = account(id: 2, name: 'Bank', isMain: true);
  final lulo = account(id: 3, name: 'Lulo');
  final creating = AccountFormState(
    status: AccountFormStatus.editing,
    accounts: [main, lulo],
    currencies: const [cop, usd],
    currencyCode: 'COP',
    iconKey: 'account_balance',
    color: 0xFF3949AB,
    openingDate: LocalDate(2026, 1, 1),
    parentAccountId: main.id,
  );
  AccountFormState editing(Account account) => creating.copyWith(
    original: account,
    name: account.name,
    type: account.type,
    isMain: account.isMain,
  );

  setUpAll(() => registerFallbackValue(AccountType.cash));

  setUp(() {
    cubit = MockAccountFormCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(creating);
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => cubit.setArchived(archived: any(named: 'archived')))
        .thenAnswer((_) async {});
    when(() => router.canPop()).thenReturn(true);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<AccountFormCubit>.value(
        value: cubit,
        child: const AccountFormView(),
      ),
      router: router,
    );
  }

  group('AccountFormView', () {
    testWidgets('shows a progress indicator while loading', (tester) async {
      when(() => cubit.state).thenReturn(const AccountFormState());

      await pumpView(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing account', (tester) async {
      when(
        () => cubit.state,
      ).thenReturn(const AccountFormState(status: AccountFormStatus.notFound));

      await pumpView(tester);

      expect(find.text('This account no longer exists.'), findsOneWidget);
    });

    testWidgets('a new bank account shows its fields', (tester) async {
      await pumpView(tester);

      expect(find.text('New account'), findsOneWidget);
      expect(find.byType(ChoiceChip), findsNWidgets(5));
      expect(find.text('Money outside its pockets'), findsOneWidget);
      expect(find.text('Include in Balance'), findsOneWidget);
      expect(find.text('Main account'), findsOneWidget);
      expect(find.text('Credit limit'), findsNothing);
      expect(find.text('Parent account'), findsNothing);
      expect(find.byTooltip('Delete account'), findsNothing);
    });

    testWidgets('forwards the fields to the cubit', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Cash'));
      await tester.enterText(find.byType(TextFormField).at(0), 'Wallet');
      await tester.enterText(find.byType(TextFormField).at(1), '350.000');
      await tester.tap(find.text('Include in Balance'));
      await tester.tap(find.text('Main account'));
      await tester.tap(find.text(r'COP · $'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(r'USD · US$').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));

      verify(() => cubit.typeChanged(AccountType.cash)).called(1);
      verify(() => cubit.nameChanged('Wallet')).called(1);
      verify(() => cubit.openingChanged('350.000')).called(1);
      verify(() => cubit.includeInBalanceChanged(value: true)).called(1);
      verify(() => cubit.isMainChanged(value: true)).called(1);
      verify(() => cubit.currencyChanged('USD')).called(1);
      verify(() => cubit.submit()).called(1);
    });

    testWidgets('picks the icon, the color and the opening date', (
      tester,
    ) async {
      await pumpView(tester);

      await tester.tap(find.byTooltip('Change icon'));
      await tester.pumpAndSettle();
      await tester.tap(
        find
            .descendant(
              of: find.byType(AlertDialog),
              matching: find.byType(InkResponse),
            )
            .first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Change color'));
      await tester.pumpAndSettle();
      await tester.tap(
        find
            .descendant(
              of: find.byType(AlertDialog),
              matching: find.byType(InkResponse),
            )
            .first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Opening date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('15'));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      verify(() => cubit.iconChanged('restaurant', any())).called(1);
      verify(() => cubit.colorChanged(0xFFE53935)).called(1);
      verify(() => cubit.openingDateChanged(LocalDate(2026, 1, 15))).called(1);
    });

    testWidgets('a credit card asks for limit and payment day', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          type: AccountType.creditCard,
          showErrors: true,
          errors: {
            AccountError.invalidCreditLimit,
            AccountError.invalidPaymentDay,
            AccountError.invalidOpeningBalance,
          },
        ),
      );

      await pumpView(tester);
      expect(find.text('Current debt'), findsOneWidget);
      expect(find.text('Enter a limit above zero.'), findsOneWidget);
      expect(find.text('Enter a valid amount.'), findsOneWidget);
      expect(find.text('Main account'), findsNothing);

      await tester.enterText(find.byType(TextFormField).at(2), '3.000.000');
      await tester.tap(find.text('Payment day'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, '15'));
      await tester.pumpAndSettle();

      verify(() => cubit.creditLimitChanged('3.000.000')).called(1);
      verify(() => cubit.paymentDayChanged(15)).called(1);
    });

    testWidgets('a pocket picks its parent instead of a currency', (
      tester,
    ) async {
      when(() => cubit.state)
          .thenReturn(creating.copyWith(type: AccountType.pocket));

      await pumpView(tester);
      expect(find.text('Parent account'), findsOneWidget);
      expect(find.text('Include in Balance'), findsNothing);
      expect(
        find.textContaining('uses the currency and the Balance setting'),
        findsOneWidget,
      );

      await tester.tap(find.byType(DropdownButtonFormField<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lulo').last);
      await tester.pumpAndSettle();

      verify(() => cubit.parentChanged(lulo.id)).called(1);
    });

    testWidgets('a pocket without banks explains why', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          type: AccountType.pocket,
          accounts: const [],
          parentAccountId: null,
          showErrors: true,
          errors: {AccountError.missingParent, AccountError.emptyName},
        ),
      );

      await pumpView(tester);

      expect(find.textContaining('Create a bank account first'), findsOne);
      expect(find.text('Choose a bank account.'), findsOneWidget);
      expect(find.text('Enter a name.'), findsOneWidget);
    });

    testWidgets('editing locks the type and the currency with movements', (
      tester,
    ) async {
      when(() => cubit.state)
          .thenReturn(editing(lulo).copyWith(hasMovements: true));

      await pumpView(tester);

      expect(find.text('Edit Lulo'), findsOneWidget);
      expect(find.byType(ChoiceChip), findsNothing);
      expect(find.textContaining("type can't be changed"), findsOneWidget);
      expect(find.textContaining("currency can't be changed"), findsOne);
    });

    testWidgets('the main account cannot be archived or deleted', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(editing(main));

      await pumpView(tester);

      expect(find.byTooltip('Archive'), findsNothing);
      expect(find.byTooltip('Delete account'), findsNothing);
      expect(find.textContaining('Mark another bank account'), findsOne);
      expect(find.textContaining("can't be archived or deleted"), findsOne);
    });

    testWidgets('warns that the pockets are deleted with the account', (
      tester,
    ) async {
      final pocket = account(
        id: 4,
        name: 'Emergency fund',
        type: AccountType.pocket,
        parentAccountId: 3,
      );
      when(() => cubit.state)
          .thenReturn(editing(lulo).copyWith(accounts: [main, lulo, pocket]));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete account'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Its pocket will be deleted too: Emergency fund.'),
        findsOne,
      );
      await tester.tap(find.text('Delete all'));
      await tester.pumpAndSettle();

      verify(() => cubit.delete()).called(1);
    });

    testWidgets('archives and deletes after confirming', (tester) async {
      when(() => cubit.state).thenReturn(editing(lulo));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Archive'));
      await tester.tap(find.byTooltip('Delete account'));
      await tester.pumpAndSettle();
      expect(find.text('Delete Lulo?'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      verify(() => cubit.setArchived(archived: true)).called(1);
      verify(() => cubit.delete()).called(1);
    });

    testWidgets('restores an archived account', (tester) async {
      when(() => cubit.state)
          .thenReturn(editing(lulo.copyWith(isArchived: true)));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Restore'));

      verify(() => cubit.setArchived(archived: false)).called(1);
    });

    testWidgets('cancelling the confirmation keeps the account', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(editing(lulo));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete account'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.delete());
    });

    testWidgets('goes back after saving', (tester) async {
      whenListen(
        cubit,
        Stream.value(creating.copyWith(status: AccountFormStatus.saved)),
        initialState: creating,
      );

      await pumpView(tester);
      await tester.pump();

      verify(() => router.pop<Object?>()).called(1);
    });

    testWidgets('shows a snackbar when saving fails', (tester) async {
      whenListen(
        cubit,
        Stream.value(creating.copyWith(failure: const DatabaseFailure('x'))),
        initialState: creating,
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });
}
