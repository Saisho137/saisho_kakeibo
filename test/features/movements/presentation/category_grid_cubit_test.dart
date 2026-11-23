import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payee_suggestions.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart' as fixtures;

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetSuggestions extends Mock implements GetPayeeSuggestions;

class _MockGetDebts extends Mock implements GetDebtStatuses;

void main() {
  late _MockGetCategories getCategories;
  late _MockGetSuggestions getSuggestions;
  late _MockGetDebts getDebts;

  final food = category(id: 1, name: 'Eating out');
  final car = category(id: 2, name: 'Car');
  final old = category(id: 3, name: 'Old', isArchived: true);
  final debt = category(id: 4, role: CategoryRole.debtPayment);
  final salary = category(id: 5, name: 'Salary', type: CategoryType.income);
  const peaje = Payee(id: 1, name: 'Peaje Palmas', key: 'peajepalmas');
  const mortgagePayee = Payee(id: 2, name: 'Mortgage', key: 'mortgage');
  final mortgage = fixtures.debt(payeeId: 2);
  final settled = fixtures.debt(id: 2, name: 'Mortgage old', initialPending: 0);
  final lent = fixtures.debt(id: 3, type: DebtType.owedToMe, name: 'Lent');

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
        .thenAnswer((_) async => const Ok([peaje, mortgagePayee]));
    getDebts = _MockGetDebts();
    when(() => getDebts(any())).thenAnswer(
      (_) async => Ok([
        for (final d in [mortgage, settled, lent])
          (debt: d, status: DebtStatus.of(d, const [])),
      ]),
    );
  });

  CategoryGridCubit build() => CategoryGridCubit(
    getCategories: getCategories,
    getPayeeSuggestions: getSuggestions,
    getDebts: getDebts,
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

  test('finds the open debts the type pays, not as payees', () async {
    final cubit = build();
    await cubit.load(MovementType.expense);
    expect(cubit.state.visibleDebts, isEmpty);

    cubit.queryChanged('mort');
    expect(cubit.state.paymentCategory, debt);
    expect(cubit.state.visibleDebts, [mortgage]);
    expect(cubit.state.visiblePayees, isEmpty);

    // Without Loan repaid, the income grid finds no debts to collect.
    await cubit.load(MovementType.income);
    expect(cubit.state.debts, [lent]);
    expect(cubit.state.visibleDebts, isEmpty);
  });

  test('reports a failed load', () async {
    when(() => getSuggestions(any()))
        .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
    final cubit = build();
    await cubit.load(MovementType.expense);

    expect(cubit.state.status, CategoryGridStatus.failure);
  });
}
