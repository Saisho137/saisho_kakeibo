import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';

/// Deletes a debt no movement references; one with payments stays, and
/// goes to *Paid off* once settled.
class DeleteDebt implements UseCase<Future<Result<void>>, int> {
  const new(this._repository);

  final DebtRepository _repository;

  @override
  Future<Result<void>> call(int id) async {
    switch (await _repository.getMovements(id)) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: final movements) when movements.isNotEmpty:
        return const Err(ValidationFailure('A debt with movements stays.'));
      case Ok():
        return await _repository.deleteDebt(id);
    }
  }
}
