import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/accounts_page.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late MockAccountsCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final ready = AccountsState(
    status: AccountsStatus.success,
    currencies: const [cop, usd],
    currencyCode: 'COP',
    accounts: [
      account(id: 1, name: 'Bancolombia', includeInBalance: true, isMain: true),
      account(id: 3, name: 'Lulo', sortOrder: 1),
      account(
        id: 4,
        type: AccountType.pocket,
        name: 'Emergency fund',
        parentAccountId: 3,
      ),
      account(
        id: 5,
        type: AccountType.creditCard,
        name: 'Visa',
        creditLimit: 3000000,
        paymentDay: 15,
      ),
      account(
        id: 6,
        type: AccountType.investment,
        name: 'CDT',
        isArchived: true,
      ),
    ],
    balances: {1: 3900000, 3: 2000000, 4: -300000, 5: -1200000, 6: 0},
  );

  setUp(() {
    cubit = MockAccountsCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(ready);
    when(() => cubit.reorder(any(), any(), any())).thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  setUpAll(() => registerFallbackValue(AccountGroup.cashAndBank));

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<AccountsCubit>.value(
        value: cubit,
        child: const AccountsView(),
      ),
      router: router,
    );
  }

  group('AccountsView', () {
    testWidgets('shows a progress indicator while loading', (tester) async {
      when(() => cubit.state).thenReturn(const AccountsState());

      await pumpView(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a failed load', (tester) async {
      when(() => cubit.state)
          .thenReturn(const AccountsState(status: AccountsStatus.failure));

      await pumpView(tester);

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });

    testWidgets('shows totals, groups, pockets and card limits', (
      tester,
    ) async {
      await pumpView(tester);

      for (final text in [
        'Total balance',
        '4.400.000',
        'Balance',
        '3.900.000',
        'Cash & bank',
        'Credit cards',
        'Lulo',
        '1.700.000',
        'Emergency fund',
        '-300.000',
        'Free',
        '2.000.000',
        'Visa',
        '-1.200.000',
        '1.800.000 left · day 15',
      ]) {
        expect(find.text(text), findsWidgets, reason: text);
      }
      expect(find.text('Investments'), findsNothing);
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
      expect(find.byIcon(Icons.radio_button_checked_rounded), findsOneWidget);
    });

    testWidgets('lists archived accounts when asked', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(showArchived: true));

      await pumpView(tester);

      expect(find.text('CDT'), findsOneWidget);
      expect(find.text('Archived'), findsOneWidget);
    });

    testWidgets('explains a currency without accounts', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(currencyCode: 'USD'));

      await pumpView(tester);

      expect(find.text('No accounts in USD yet.'), findsOneWidget);
    });

    testWidgets('opens accounts, pockets and the new account form', (
      tester,
    ) async {
      await pumpView(tester);

      await tester.tap(find.text('Lulo'));
      await tester.tap(find.text('Emergency fund'));
      await tester.tap(find.byTooltip('New account'));

      verify(() => router.push<Object?>('/accounts/3')).called(1);
      verify(() => router.push<Object?>('/accounts/4')).called(1);
      verify(() => router.push<Object?>('/accounts/new')).called(1);
    });

    testWidgets('switches currency and archived visibility', (tester) async {
      await pumpView(tester);

      await tester.tap(find.byTooltip('Currency'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('USD').last);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PopupMenuButton<void>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Show archived'));
      await tester.pumpAndSettle();

      verify(() => cubit.currencySelected('USD')).called(1);
      verify(() => cubit.showArchivedToggled()).called(1);
    });

    testWidgets('saves the order of a group after a drag', (tester) async {
      await pumpView(tester);

      tester
          .widget<ReorderableListView>(find.byType(ReorderableListView).first)
          .onReorderItem!(1, 0);

      verify(() => cubit.reorder(AccountGroup.cashAndBank, 1, 0)).called(1);
    });

    testWidgets('shows a snackbar when an action fails', (tester) async {
      whenListen(
        cubit,
        Stream.value(ready.copyWith(failure: const DatabaseFailure('x'))),
        initialState: ready,
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });
}
