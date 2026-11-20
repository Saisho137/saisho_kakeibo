import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/pages/categories_page.dart';

import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late MockCategoriesCubit cubit;
  late MockGoRouter router;

  final ready = CategoriesState(
    status: CategoriesStatus.success,
    pillars: pillars,
    categories: [
      category(id: 1, name: 'Eating out', pillarId: leisure.id),
      category(id: 2, name: 'Car', sortOrder: 1),
      category(
        id: 3,
        name: 'Debt payment',
        role: CategoryRole.debtPayment,
        sortOrder: 2,
      ),
      category(
        id: 4,
        name: 'Uncategorized',
        role: CategoryRole.uncategorized,
        sortOrder: 3,
      ),
      category(id: 5, name: 'Gym', isArchived: true, sortOrder: 4),
      category(
        id: 6,
        name: 'Salary',
        type: CategoryType.income,
        role: CategoryRole.salary,
      ),
    ],
  );

  setUpAll(() {
    registerFallbackValue(CategoryType.expense);
    registerFallbackValue(survival);
  });

  setUp(() {
    cubit = MockCategoriesCubit();
    router = MockGoRouter();
    when(() => cubit.state).thenReturn(ready);
    when(() => cubit.reorder(any(), any(), any())).thenAnswer((_) async {});
    when(() => cubit.updatePillar(any())).thenAnswer((_) async {});
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<CategoriesCubit>.value(
        value: cubit,
        child: const CategoriesView(),
      ),
      router: router,
    );
  }

  group('CategoriesView', () {
    testWidgets('shows a progress indicator while loading', (tester) async {
      when(() => cubit.state).thenReturn(const CategoriesState());

      await pumpView(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a failed load', (tester) async {
      when(() => cubit.state)
          .thenReturn(const CategoriesState(status: CategoriesStatus.failure));

      await pumpView(tester);

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });

    testWidgets('lists expenses with their pillar and core lock', (
      tester,
    ) async {
      await pumpView(tester);

      expect(find.text('Eating out'), findsOneWidget);
      expect(find.text('Leisure'), findsOneWidget);
      expect(find.text('Survival'), findsOneWidget);
      expect(find.text("Debt's pillar"), findsOneWidget);
      expect(find.text('No pillar'), findsOneWidget);
      expect(find.byIcon(Icons.lock_rounded), findsNWidgets(2));
      expect(find.text('Gym'), findsNothing);
      expect(find.text('Archived (1)'), findsOneWidget);

      await tester.tap(find.text('Archived (1)'));
      await tester.pumpAndSettle();
      expect(find.text('Gym'), findsOneWidget);
    });

    testWidgets('switches tabs and creates a category of that type', (
      tester,
    ) async {
      await pumpView(tester);

      await tester.tap(find.text('Transfer'));
      await tester.pumpAndSettle();
      expect(find.text('No categories yet.'), findsOneWidget);

      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();
      expect(find.text('Salary'), findsOneWidget);
      await tester.tap(find.byTooltip('New category'));

      verify(() => router.push<Object?>('/categories/new?type=income'))
          .called(1);
    });

    testWidgets('opens a category and reorders', (tester) async {
      await pumpView(tester);

      await tester.tap(find.text('Car'));
      verify(() => router.push<Object?>('/categories/2')).called(1);

      tester
          .widget<ReorderableListView>(find.byType(ReorderableListView).first)
          .onReorderItem!(1, 0);
      verify(() => cubit.reorder(CategoryType.expense, 1, 0)).called(1);
    });

    testWidgets('edits a pillar from the pillars dialog', (tester) async {
      await pumpView(tester);

      await tester.tap(find.byTooltip('Pillars'));
      await tester.pumpAndSettle();
      expect(find.text('Pillars'), findsWidgets);
      await tester.tap(find.text('Survival').last);
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), ' ');
      await tester.tap(find.text('Save'));
      await tester.pump();
      expect(find.text('Enter a name.'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'leisure');
      await tester.pump();
      expect(find.text('Another pillar has this name.'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'needs');
      final swatches = find.descendant(
        of: find.byType(AlertDialog).last,
        matching: find.byType(InkResponse),
      );
      await tester.tap(swatches.first);
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      final saved =
          verify(() => cubit.updatePillar(captureAny())).captured.single
              as Pillar;
      expect(saved.name, 'Needs');
      expect(saved.color, isNot(survival.color));

      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('cancelling the pillar dialog keeps the pillar', (
      tester,
    ) async {
      await pumpView(tester);

      await tester.tap(find.byTooltip('Pillars'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Leisure').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.updatePillar(any()));
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
