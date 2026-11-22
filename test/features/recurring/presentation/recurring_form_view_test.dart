import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_form_cubit.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/pages/recurring_form_page.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  late MockRecurringFormCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final editing = RecurringFormState(
    status: RecurringFormStatus.editing,
    accounts: [
      account(id: 1, name: 'Bank'),
      account(id: 2, name: 'Dollars', currencyCode: 'USD'),
    ],
    categories: [
      category(id: 10, name: 'Food'),
      category(id: 13, name: 'Savings', type: CategoryType.transfer),
    ],
    currencies: const [cop, usd],
    accountId: 1,
  );

  setUpAll(() {
    registerFallbackValue(MovementType.expense);
    registerFallbackValue(RecurringCadence.period);
  });

  setUp(() {
    cubit = MockRecurringFormCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(editing);
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.delete()).thenAnswer((_) async {});
    when(() => router.pop<Object?>(any())).thenReturn(null);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<RecurringFormCubit>.value(
        value: cubit,
        child: const RecurringFormView(),
      ),
      router: router,
    );
  }

  group('RecurringFormView', () {
    testWidgets('forwards the fields to the cubit', (tester) async {
      await pumpView(tester);

      expect(find.text('New recurring'), findsOneWidget);
      expect(
        find.text('Its first pending movement comes with the next period.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Income'));
      verify(() => cubit.typeChanged(MovementType.income)).called(1);
      await tester.enterText(find.byKey(const ValueKey('amount')), '5.000');
      verify(() => cubit.amountChanged('5.000')).called(1);
      await tester.enterText(find.byKey(const ValueKey('payee')), 'Netflix');
      verify(() => cubit.payeeChanged('Netflix')).called(1);
      await tester.enterText(find.byKey(const ValueKey('note')), 'Plan');
      verify(() => cubit.noteChanged('Plan')).called(1);
      await tester.tap(find.text('Each month'));
      verify(() => cubit.cadenceChanged(RecurringCadence.monthly)).called(1);

      await tester.tap(find.text('Category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Food').last);
      await tester.pumpAndSettle();
      verify(() => cubit.categoryChanged(10)).called(1);

      await tester.tap(find.text('Bank · COP'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dollars · USD').last);
      await tester.pumpAndSettle();
      verify(() => cubit.accountChanged(2)).called(1);

      await tester.tap(find.text('Save'));
      verify(() => cubit.submit()).called(1);
    });

    testWidgets('picks and clears the due day', (tester) async {
      await pumpView(tester);
      expect(find.text('None'), findsOneWidget);
      await tester.tap(find.text('Due day'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('12'));
      await tester.pumpAndSettle();
      verify(() => cubit.dueDayChanged(12)).called(1);
    });

    testWidgets('a due day turns the reminder on and off', (tester) async {
      when(() => cubit.state)
          .thenReturn(editing.copyWith(dueDay: 12, remind: true));
      await pumpView(tester);
      expect(find.text('Day 12'), findsOneWidget);
      await tester.tap(find.text('Remind me on due day'));
      verify(() => cubit.remindChanged(value: false)).called(1);
      await tester.tap(find.byTooltip('No due day'));
      verify(() => cubit.dueDayChanged(null)).called(1);
    });

    testWidgets('a transfer between currencies asks both amounts', (
      tester,
    ) async {
      when(() => cubit.state).thenReturn(
        editing.copyWith(
          type: MovementType.transfer,
          toAccountId: 2,
          showErrors: true,
          errors: {
            MovementError.invalidAmount,
            MovementError.missingCategory,
            MovementError.sameAccounts,
          },
        ),
      );
      await pumpView(tester);

      expect(find.text('From'), findsOneWidget);
      expect(find.text('To'), findsOneWidget);
      expect(find.text('Received'), findsOneWidget);
      expect(find.text('Entity'), findsNothing);
      expect(find.text('Enter an amount above zero.'), findsOneWidget);
      expect(find.text('Pick a category.'), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey('toAmount')), '10');
      verify(() => cubit.toAmountChanged('10')).called(1);
    });

    testWidgets('edits and deletes after confirming', (tester) async {
      when(() => cubit.state)
          .thenReturn(editing.copyWith(original: template()));
      await pumpView(tester);

      expect(find.text('Edit recurring'), findsOneWidget);
      await tester.tap(find.byTooltip('Delete recurring'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.delete());
      await tester.tap(find.byTooltip('Delete recurring'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      verify(() => cubit.delete()).called(1);
    });

    testWidgets('shows loading and not found', (tester) async {
      when(() => cubit.state).thenReturn(const RecurringFormState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing template', (tester) async {
      when(() => cubit.state).thenReturn(
        const RecurringFormState(status: RecurringFormStatus.notFound),
      );
      await pumpView(tester);
      expect(
        find.text('This recurring movement no longer exists.'),
        findsOneWidget,
      );
    });

    testWidgets('goes back after saving and shows failures', (tester) async {
      whenListen(
        cubit,
        Stream.fromIterable([
          editing.copyWith(failure: const DatabaseFailure('disk')),
          editing.copyWith(status: RecurringFormStatus.saved),
        ]),
        initialState: editing,
      );
      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
      verify(() => router.pop<bool>(true)).called(1);
    });
  });
}
