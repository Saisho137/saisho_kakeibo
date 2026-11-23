import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';

final class EditDebtPendingParams {
  const new({required this.id, required this.pending});

  final int id;

  /// What is really pending, as the bank reports it.
  final int pending;
}

/// "Edit pending": sets what is pending on a debt without moving money
/// (RF-09). The payments stay; a correction makes up the difference.
class EditDebtPending
    implements UseCase<Future<Result<void>>, EditDebtPendingParams> {
  const new(this._repository);

  final DebtRepository _repository;

  @override
  Future<Result<void>> call(EditDebtPendingParams params) async {
    switch ((
      await _repository.findDebt(params.id),
      await _repository.getMovements(params.id),
    )) {
      case (Ok(value: final debt?), Ok(value: final movements)):
        final status = DebtStatus.of(debt, movements);
        return switch (await _repository.saveDebt(
          debt.copyWith(adjustment: status.adjustmentFor(debt, params.pending)),
        )) {
          Ok() => const Ok(null),
          Err(:final failure) => Err(failure),
        };
      case (Ok(value: null), _):
        return Err(ValidationFailure('Unknown debt ${params.id}'));
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
  }
}
