import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payee_suggestions.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/category_fixtures.dart';

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetSuggestions extends Mock implements GetPayeeSuggestions;

void main() {
  late _MockGetCategories getCategories;
  late _MockGetSuggestions getSuggestions;

  final food = category(id: 1, name: 'Eating out');
  final car = category(id: 2, name: 'Car');
  final old = category(id: 3, name: 'Old', isArchived: true);
  final debt = category(id: 4, role: CategoryRole.debtPayment);
  final salary = category(id: 5, name: 'Salary', type: CategoryType.income);
  const peaje = Payee(id: 1, name: 'Peaje Palmas', key: 'peajepalmas');

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(MovementType.expense);
  });

  setUp(() {
    getCategories = _MockGetCategories();
    getSuggestions = _MockGetSuggestions();
    when(() => getCategories(any()))
        .thenAnswer((_) async => Ok([food, car, old, debt, salary]));
    when(() => getSuggestions(any()))
        .thenAnswer((_) async => const Ok([peaje]));
  });

  CategoryGridCubit build() => CategoryGridCubit(
    getCategories: getCategories,
    getPayeeSuggestions: getSuggestions,
  );

  test('shows the active categories of the type, debt ones too', () async {
    final cubit = build();
    await cubit.load(MovementType.expense);

    expect(cubit.state.status, CategoryGridStatus.success);
    expect(cubit.state.visibleCategories, [food, car, debt]);
    expect(cubit.state.visiblePayees, isEmpty);

    await cubit.load(MovementType.income);
    expect(cubit.state.visibleCategories, [salary]);
  });

  test('searches categories and payees by key', () async {
    final cubit = build();
    await cubit.load(MovementType.expense);

    cubit.queryChanged('PEAJE');
    expect(cubit.state.visibleCategories, isEmpty);
    expect(cubit.state.visiblePayees, [peaje]);

    cubit.queryChanged(' eating ');
    expect(cubit.state.visibleCategories, [food]);
    expect(cubit.state.visiblePayees, isEmpty);
  });

  test('reports a failed load', () async {
    when(() => getSuggestions(any()))
        .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
    final cubit = build();
    await cubit.load(MovementType.expense);

    expect(cubit.state.status, CategoryGridStatus.failure);
  });
}
