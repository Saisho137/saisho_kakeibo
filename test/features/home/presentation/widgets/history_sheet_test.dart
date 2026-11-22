import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_sheet.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/movement_fixtures.dart';

void main() {
  late MockHomeCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final today = LocalDate.today();
  final cash = account(id: 1, name: 'Cash', type: AccountType.cash);
  final bank = account(id: 2, name: 'Bank');
  final food = category(id: 10, name: 'Food');
  final car = category(id: 11, name: 'Car');
  final salary = category(id: 12, name: 'Salary', type: CategoryType.income);
  final savings = category(
    id: 13,
    name: 'Savings',
    type: CategoryType.transfer,
  );

  final ready = HomeState(
    status: HomeStatus.success,
    today: today,
    settings: const AppSettings(),
    accounts: [cash, bank],
    balances: const {},
    currencies: const [cop],
    categories: [food, car, salary, savings],
    pillars: pillars,
    payees: const [Payee(id: 5, name: 'Uber', key: 'uber')],
    periodStarts: [today.addDays(-1)],
    movements: [
      movement(id: 1, categoryId: 10, amount: 625, date: today, payeeId: 5),
      movement(id: 2, categoryId: 11, amount: 375, date: today),
      movement(
        id: 3,
        type: MovementType.income,
        categoryId: 12,
        amount: 9000,
        isPending: true,
        date: today.addDays(-1),
      ),
      movement(
        id: 4,
        type: MovementType.transfer,
        categoryId: 13,
        toAccountId: 2,
        amount: 200,
        date: today.addDays(-1),
      ),
      movement(
        id: 5,
        type: MovementType.adjustment,
        accountId: 2,
        amount: 3,
        date: today.addDays(-1),
      ),
    ],
  );

  setUp(() {
    cubit = MockHomeCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(ready);
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> open(WidgetTester tester, {MovementType? categoryType}) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<HomeCubit>.value(
        value: cubit,
        child: Builder(
          builder: (context) => TextButton(
            onPressed: () =>
                showHistorySheet(context, categoryType: categoryType),
            child: const Text('open'),
          ),
        ),
      ),
      router: router,
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  group('HistoryView', () {
    testWidgets('lists the period by day', (tester) async {
      await open(tester);

      expect(find.textContaining('Since '), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Yesterday'), findsOneWidget);
      expect(find.text('Uber'), findsOneWidget);
      expect(find.text('-625'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('To Bank'), findsOneWidget);
      expect(find.text('Balance adjustment'), findsOneWidget);

      await tester.tap(find.text('Food'));
      verify(() => router.push<Object?>('/movements/1')).called(1);
      await tester.tap(find.text('To Bank'));
      verify(() => router.push<Object?>('/transfers/4')).called(1);
      await tester.tap(find.text('Balance adjustment'));
      verify(() => router.push<Object?>('/accounts/2')).called(1);
    });

    testWidgets('groups by category, adding up to 100 %', (tester) async {
      await open(tester, categoryType: MovementType.expense);

      expect(find.text('63% of Expenses'), findsOneWidget);
      expect(find.text('37% of Expenses'), findsOneWidget);
      expect(find.text('625'), findsOneWidget);

      await tester.tap(find.text('Food'));
      await tester.pumpAndSettle();
      expect(find.text('-625'), findsOneWidget);
      expect(find.text('-375'), findsNothing);

      await tester.tap(find.text('Transfers'));
      await tester.pumpAndSettle();
      expect(find.text('100% of Transfers'), findsOneWidget);

      // A pending income waits for its confirmation.
      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();
      expect(find.text('No movements in this period.'), findsOneWidget);

      await tester.tap(find.text('By day'));
      await tester.pumpAndSettle();
      expect(find.text('Today'), findsOneWidget);
    });

    testWidgets('shows nothing before loading', (tester) async {
      when(() => cubit.state).thenReturn(const HomeState());
      await open(tester);

      expect(find.text('By day'), findsNothing);
    });

    testWidgets('an empty period says so', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(movements: const []));
      await open(tester);

      expect(find.text('No movements in this period.'), findsOneWidget);
    });
  });
}
