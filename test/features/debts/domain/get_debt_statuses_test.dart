import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockDebts extends Mock implements DebtRepository;

class _MockMovements extends Mock implements MovementRepository;

void main() {
  test('GetDebtStatuses pairs each debt with its status', () async {
    final debts = _MockDebts();
    final movements = _MockMovements();
    when(debts.getDebts).thenAnswer((_) async => Ok([debt()]));
    when(movements.getAll).thenAnswer(
      (_) async => Ok([movement(amount: 400000).copyWith(debtId: 1)]),
    );
    final use = GetDebtStatuses(debts: debts, movements: movements);

    final lines =
        (await use(const NoParams()) as Ok<List<DebtWithStatus>>).value;
    expect(lines.single.status.pending, 600000);

    when(movements.getAll)
        .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
    expect(await use(const NoParams()), isA<Err<List<DebtWithStatus>>>());
  });
}
