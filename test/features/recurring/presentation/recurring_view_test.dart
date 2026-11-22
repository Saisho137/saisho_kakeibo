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
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_cubit.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/pages/recurring_page.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  late MockRecurringCubit cubit;
  late MockGoRouter router;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final ready = RecurringState(
    status: RecurringStatus.success,
    templates: [
      template(payeeId: 4, amount: 44900, dueDay: 12, remind: true),
      template(
        id: 2,
        type: MovementType.transfer,
        categoryId: 13,
        toAccountId: 2,
        amount: 300000,
        dueDay: 5,
      ),
      template(id: 3, isActive: false),
    ],
    accounts: [
      account(id: 1, name: 'Visa'),
      account(id: 2, name: 'Pocket'),
    ],
    categories: [
      category(id: 10, name: 'Subscriptions'),
      category(id: 13, name: 'Savings', type: CategoryType.transfer),
    ],
    payees: const [Payee(id: 4, name: 'Netflix', key: 'netflix')],
    currencies: const [cop],
  );

  setUp(() {
    cubit = MockRecurringCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(ready);
    when(() => cubit.setActive(any(), value: any(named: 'value')))
        .thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pumpView(WidgetTester tester) => tester.pumpApp(
    BlocProvider<RecurringCubit>.value(
      value: cubit,
      child: const RecurringView(),
    ),
    router: router,
  );

  group('RecurringView', () {
    testWidgets('lists the templates', (tester) async {
      await pumpView(tester);

      expect(find.text('Netflix · Visa'), findsOneWidget);
      expect(find.text('44.900 · 🔔 Day 12'), findsOneWidget);
      expect(find.text('Savings'), findsOneWidget);
      expect(find.text('300.000 · Visa → Pocket · Day 5'), findsOneWidget);
      expect(find.text('1.000 · Paused'), findsOneWidget);
    });

    testWidgets('opens, creates and pauses templates', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Netflix · Visa'));
      verify(() => router.push<Object?>('/recurring/1')).called(1);
      await tester.tap(find.byTooltip('New recurring'));
      verify(() => router.push<Object?>('/recurring/new')).called(1);
      await tester.tap(find.byType(Switch).first);
      verify(() => cubit.setActive(1, value: false)).called(1);
    });

    testWidgets('shows loading, empty and failed states', (tester) async {
      when(() => cubit.state).thenReturn(const RecurringState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains an empty list', (tester) async {
      when(() => cubit.state).thenReturn(ready.copyWith(templates: const []));
      await pumpView(tester);
      expect(find.textContaining('No recurring movements yet'), findsOne);
    });

    testWidgets('a failed load and action show an error', (tester) async {
      whenListen(
        cubit,
        Stream.value(
          const RecurringState(
            status: RecurringStatus.failure,
            failure: DatabaseFailure('disk'),
          ),
        ),
        initialState: ready,
      );
      await pumpView(tester);
      await tester.pump();
      expect(
        find.text('Something went wrong. Please try again.'),
        findsWidgets,
      );
    });
  });
}
