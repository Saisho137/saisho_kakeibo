import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

/// A debt with what is pending on it.
typedef DebtWithStatus = ({Debt debt, DebtStatus status});

/// Every debt with its status, for the quick entry to pick the one a
/// movement pays, collects or adds to (RF-09).
class GetDebtStatuses
    implements UseCase<Future<Result<List<DebtWithStatus>>>, NoParams> {
  const new({required this._debts, required this._movements});

  final DebtRepository _debts;
  final MovementRepository _movements;

  @override
  Future<Result<List<DebtWithStatus>>> call(NoParams params) async {
    switch ((await _debts.getDebts(), await _movements.getAll())) {
      case (Ok(value: final debts), Ok(value: final movements)):
        return Ok([
          for (final debt in debts)
            (debt: debt, status: DebtStatus.of(debt, movements)),
        ]);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
  }
}
