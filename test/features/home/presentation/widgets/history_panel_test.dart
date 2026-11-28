import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/balance_pill.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_panel.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_view.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

import '../../../../helpers/account_fixtures.dart';
import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/movement_fixtures.dart';

void main() {
  late MockHomeCubit cubit;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final today = LocalDate.today();

  setUp(() {
    cubit = MockHomeCubit();
    when(() => cubit.state).thenReturn(
      HomeState(
        status: HomeStatus.success,
        today: today,
        settings: const AppSettings(),
        accounts: [account(id: 1)],
        balances: const {},
        currencies: const [cop],
        categories: [
          category(id: 10, name: 'Food'),
          category(id: 12, name: 'Salary', type: CategoryType.income),
        ],
        pillars: pillars,
        periodStarts: [today.addDays(-1)],
        movements: [movement(categoryId: 10, amount: 625, date: today)],
      ),
    );
  });

  Future<void> pumpPanel(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<HomeCubit>.value(
        value: cubit,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: HistoryPanel(
                  balance: const Money(1000, 'COP'),
                  currency: cop,
                  pageBuilder: (context, open) => Center(
                    child: TextButton(
                      onPressed: () => open(categoryType: MovementType.income),
                      child: const Text('Totals'),
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Actions')),
            ],
          ),
        ),
      ),
    );
  }

  double width(WidgetTester tester) =>
      tester.view.physicalSize.width / tester.view.devicePixelRatio;

  group('HistoryPanel', () {
    testWidgets('the Balance opens and closes the history', (tester) async {
      await pumpPanel(tester);
      expect(find.byType(HistoryView), findsNothing);
      final closed = tester.getCenter(find.byType(BalancePill));

      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
      // The Balance rises to the top, still centered, and what goes
      // below the panel stays in sight.
      final open = tester.getCenter(find.byType(BalancePill));
      expect(open.dy, lessThan(closed.dy));
      expect(open.dx, closeTo(width(tester) / 2, 0.5));
      expect(find.text('Totals'), findsNothing);
      expect(find.text('Actions').hitTestable(), findsOneWidget);
      // The switch's 48 dp target ends at the margin, as the grip starts.
      expect(
        tester.getCenter(find.byIcon(Icons.donut_small_outlined)).dx,
        closeTo(
          width(tester) - AppSpacing.md - kMinInteractiveDimension / 2,
          0.5,
        ),
      );

      await tester.tap(find.byTooltip('Close the history'));
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsNothing);
      expect(find.text('Totals'), findsOneWidget);
    });

    testWidgets('switches between by day and by category', (tester) async {
      await pumpPanel(tester);
      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('By category'));
      await tester.pumpAndSettle();
      expect(find.byType(SegmentedButton<MovementType>), findsOneWidget);

      await tester.tap(find.byTooltip('By day'));
      await tester.pumpAndSettle();
      expect(find.byType(SegmentedButton<MovementType>), findsNothing);
    });

    testWidgets('the page opens it by category of a type', (tester) async {
      await pumpPanel(tester);

      await tester.tap(find.text('Totals'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('By day'), findsOneWidget);
      expect(find.text('No movements in this period.'), findsOneWidget);

      // Each opening starts afresh, by day.
      await tester.tap(find.byTooltip('Close the history'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('By category'), findsOneWidget);
    });

    testWidgets('pulling the Balance opens and closes it', (tester) async {
      await pumpPanel(tester);

      await tester.fling(
        find.byTooltip('History'),
        const Offset(0, -300),
        1000,
      );
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsOneWidget);

      // A slow, short pull goes back where it was.
      await tester.drag(
        find.byTooltip('Close the history'),
        const Offset(0, 100),
      );
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsOneWidget);

      await tester.fling(
        find.byTooltip('Close the history'),
        const Offset(0, 300),
        1000,
      );
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsNothing);
    });

    testWidgets('back closes it before leaving', (tester) async {
      await pumpPanel(tester);
      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(HistoryView), findsNothing);
      expect(find.text('Totals'), findsOneWidget);
    });
  });
}
