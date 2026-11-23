import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/category_grid_page.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/helpers.dart';

void main() {
  late MockCategoryGridCubit cubit;
  late MockGoRouter router;

  final ready = CategoryGridState(
    status: CategoryGridStatus.success,
    categories: [
      category(id: 1, name: 'Eating out'),
      category(id: 2, name: 'Car'),
    ],
    payees: const [Payee(id: 9, name: 'Peaje Palmas', key: 'peajepalmas')],
  );

  setUp(() {
    cubit = MockCategoryGridCubit();
    router = MockGoRouter();
    when(() => router.push<bool>(any())).thenAnswer((_) async => null);
    when(() => router.canPop()).thenReturn(true);
  });

  Future<void> pumpView(WidgetTester tester) => tester.pumpApp(
    BlocProvider<CategoryGridCubit>.value(
      value: cubit,
      child: const CategoryGridView(),
    ),
    router: router,
  );

  testWidgets('shows loading and failure states', (tester) async {
    when(() => cubit.state).thenReturn(const CategoryGridState());
    await pumpView(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('explains a failed load', (tester) async {
    when(
      () => cubit.state,
    ).thenReturn(const CategoryGridState(status: CategoryGridStatus.failure));
    await pumpView(tester);
    expect(find.text('Something went wrong. Please try again.'), findsOne);
  });

  testWidgets('opens the form of a category and leaves once saved', (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(ready);
    when(() => router.push<bool>(any())).thenAnswer((_) async => true);

    await pumpView(tester);
    expect(find.text('New expense'), findsOneWidget);
    await tester.tap(find.text('Car'));
    await tester.pumpAndSettle();

    verify(() => router.push<bool>('/movements/new?type=expense&category=2'))
        .called(1);
    verify(() => router.pop<Object?>()).called(1);
  });

  testWidgets('searches and opens a payee', (tester) async {
    when(() => cubit.state).thenReturn(ready.copyWith(query: 'peaje'));

    await pumpView(tester);
    await tester.enterText(find.byType(TextField), 'peaje');
    verify(() => cubit.queryChanged('peaje')).called(1);
    expect(find.text('Entities'), findsOneWidget);
    await tester.tap(find.text('Peaje Palmas'));
    await tester.pumpAndSettle();

    verify(() => router.push<bool>('/movements/new?type=expense&payee=9'))
        .called(1);
    verifyNever(() => router.pop<Object?>());
  });

  testWidgets('says when nothing matches', (tester) async {
    when(() => cubit.state)
        .thenReturn(ready.copyWith(query: 'zzz', type: MovementType.income));

    await pumpView(tester);

    expect(find.text('New income'), findsOneWidget);
    expect(find.text('Nothing matches.'), findsOneWidget);
  });

  testWidgets('a found debt opens its payment', (tester) async {
    when(() => cubit.state).thenReturn(
      ready.copyWith(
        debts: [debt()],
        paymentCategory: category(
          id: 4,
          name: 'Debt payment',
          role: CategoryRole.debtPayment,
        ),
        query: 'mort',
      ),
    );
    await pumpView(tester);

    expect(find.text('Debts'), findsOneWidget);
    await tester.tap(find.text('Mortgage'));
    verify(
      () => router.push<bool>('/movements/new?type=expense&category=4&debt=1'),
    ).called(1);
  });
}
