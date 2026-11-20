import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/pages/category_form_page.dart';

import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late MockCategoryFormCubit cubit;
  late MockGoRouter router;

  final car = category(id: 1, name: 'Car', iconKey: 'directions_car');
  final uncategorized = category(
    id: 2,
    name: 'Uncategorized',
    role: CategoryRole.uncategorized,
    iconKey: 'help',
  );
  final debt = category(id: 3, name: 'Debt', role: CategoryRole.debtPayment);
  final clothes = category(id: 4, name: 'Clothes');
  final categories = [car, uncategorized, debt, clothes];

  final creating = CategoryFormState(
    status: CategoryFormStatus.editing,
    categories: categories,
    pillars: pillars,
    iconKey: 'label',
    color: 0xFF757575,
  );

  CategoryFormState editing(Category c, {int movements = 0}) =>
      creating.copyWith(
        original: c,
        movementCount: movements,
        type: c.type,
        name: c.name,
        iconKey: c.iconKey,
        color: c.color,
        pillarId: c.pillarId,
      );

  setUp(() {
    cubit = MockCategoryFormCubit();
    router = MockGoRouter();
    when(() => cubit.submit()).thenAnswer((_) async {});
    when(() => cubit.setArchived(archived: any(named: 'archived')))
        .thenAnswer((_) async {});
    when(() => cubit.delete(reassignTo: any(named: 'reassignTo')))
        .thenAnswer((_) async {});
    when(() => router.canPop()).thenReturn(true);
  });

  Future<void> pumpView(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      BlocProvider<CategoryFormCubit>.value(
        value: cubit,
        child: const CategoryFormView(),
      ),
      router: router,
    );
  }

  group('CategoryFormView', () {
    testWidgets('shows loading and missing states', (tester) async {
      when(() => cubit.state).thenReturn(const CategoryFormState());
      await pumpView(tester);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('explains a missing category', (tester) async {
      when(() => cubit.state).thenReturn(
        const CategoryFormState(status: CategoryFormStatus.notFound),
      );
      await pumpView(tester);
      expect(find.text('This category no longer exists.'), findsOneWidget);
    });

    testWidgets('creates a category with every field', (tester) async {
      when(() => cubit.state).thenReturn(creating);

      await pumpView(tester);
      expect(find.text('New category'), findsOneWidget);
      expect(find.byTooltip('Delete category'), findsNothing);

      await tester.tap(find.text('Income'));
      await tester.enterText(find.byType(TextFormField), 'Gym');
      await tester.tap(find.byType(DropdownButtonFormField<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Leisure').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));

      verify(() => cubit.typeChanged(CategoryType.income)).called(1);
      verify(() => cubit.nameChanged('Gym')).called(1);
      verify(() => cubit.pillarChanged(leisure.id)).called(1);
      verify(() => cubit.submit()).called(1);
    });

    testWidgets('picks an icon and a color', (tester) async {
      when(() => cubit.state).thenReturn(creating);

      await pumpView(tester);
      await tester.tap(find.byTooltip('Change icon'));
      await tester.pumpAndSettle();
      await tester.tap(
        find
            .descendant(
              of: find.byType(AlertDialog),
              matching: find.byIcon(Icons.restaurant_rounded),
            )
            .first,
      );
      await tester.pumpAndSettle();
      verify(() => cubit.iconChanged('restaurant')).called(1);

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
      verify(() => cubit.colorChanged(any())).called(1);
    });

    testWidgets('shows field errors', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          showErrors: true,
          errors: {CategoryError.emptyName, CategoryError.missingPillar},
        ),
      );

      await pumpView(tester);

      expect(find.text('Enter a name.'), findsOneWidget);
      expect(find.text('Pick a pillar.'), findsOneWidget);
    });

    testWidgets('shows a repeated name error', (tester) async {
      when(() => cubit.state).thenReturn(
        creating.copyWith(
          showErrors: true,
          errors: {CategoryError.duplicateName},
        ),
      );

      await pumpView(tester);

      expect(
        find.text('Another expense category has this name.'),
        findsOneWidget,
      );
    });

    testWidgets('a core category explains itself and resets', (tester) async {
      when(() => cubit.state)
          .thenReturn(editing(uncategorized).copyWith(name: 'Misc'));

      await pumpView(tester);

      expect(find.text('Edit Uncategorized'), findsOneWidget);
      expect(find.byTooltip('Archive'), findsNothing);
      expect(find.byTooltip('Delete category'), findsNothing);
      expect(find.byType(DropdownButtonFormField<int>), findsNothing);
      expect(find.textContaining('No pillar in the chart'), findsOne);
      expect(find.textContaining('Core category'), findsOne);
      await tester.tap(find.text('Reset to default'));

      verify(() => cubit.resetToDefault()).called(1);
    });

    testWidgets('debt payment takes the pillar of its debt', (tester) async {
      when(() => cubit.state).thenReturn(editing(debt));

      await pumpView(tester);

      expect(find.textContaining('pillar of the debt'), findsOne);
    });

    testWidgets('archives and restores a custom category', (tester) async {
      when(() => cubit.state).thenReturn(editing(car));
      await pumpView(tester);
      await tester.tap(find.byTooltip('Archive'));
      verify(() => cubit.setArchived(archived: true)).called(1);
    });

    testWidgets('an archived category can be restored', (tester) async {
      when(() => cubit.state)
          .thenReturn(editing(car.copyWith(isArchived: true)));
      await pumpView(tester);
      expect(find.textContaining('out of the quick entry grid'), findsOne);
      await tester.tap(find.byTooltip('Restore'));
      verify(() => cubit.setArchived(archived: false)).called(1);
    });

    testWidgets('deletes a category without movements', (tester) async {
      when(() => cubit.state).thenReturn(editing(car));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete category'));
      await tester.pumpAndSettle();
      expect(find.text('Delete Car?'), findsOneWidget);
      expect(find.textContaining('It has no movements'), findsOne);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      verify(() => cubit.delete()).called(1);
    });

    testWidgets('moves movements to the default target', (tester) async {
      when(() => cubit.state).thenReturn(editing(car, movements: 3));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete category'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Its 3 movements move'), findsOne);
      expect(find.text('Uncategorized'), findsOneWidget);
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      verify(() => cubit.delete(reassignTo: uncategorized.id)).called(1);
    });

    testWidgets('an income asks for a target before deleting', (tester) async {
      final bonus = category(id: 5, name: 'Bonus', type: CategoryType.income);
      final returns = category(
        id: 6,
        name: 'Returns',
        type: CategoryType.income,
      );
      when(() => cubit.state).thenReturn(
        editing(
          bonus,
          movements: 1,
        ).copyWith(categories: [...categories, bonus, returns]),
      );

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      verifyNever(() => cubit.delete(reassignTo: any(named: 'reassignTo')));

      await tester.tap(find.byType(DropdownButtonFormField<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Returns').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      verify(() => cubit.delete(reassignTo: returns.id)).called(1);
    });

    testWidgets('cancelling the delete keeps the category', (tester) async {
      when(() => cubit.state).thenReturn(editing(car));

      await pumpView(tester);
      await tester.tap(find.byTooltip('Delete category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.delete(reassignTo: any(named: 'reassignTo')));
    });

    testWidgets('goes back after saving', (tester) async {
      whenListen(
        cubit,
        Stream.value(editing(car).copyWith(status: CategoryFormStatus.saved)),
        initialState: editing(car),
      );

      await pumpView(tester);
      await tester.pump();

      verify(() => router.pop<Object?>()).called(1);
    });

    testWidgets('shows a snackbar when saving fails', (tester) async {
      whenListen(
        cubit,
        Stream.value(
          editing(car).copyWith(failure: const DatabaseFailure('x')),
        ),
        initialState: editing(car),
      );

      await pumpView(tester);
      await tester.pump();

      expect(find.text('Something went wrong. Please try again.'), findsOne);
    });
  });
}
