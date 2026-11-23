import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';

/// Deletes an entity (RF-08); its movements stay, without entity. An entity
/// that is a debt stays: the debt is renamed or merged instead.
class DeletePayee implements UseCase<Future<Result<void>>, int> {
  const new({required this._payees, required this._debts});

  final PayeeRepository _payees;
  final DebtRepository _debts;

  @override
  Future<Result<void>> call(int id) async {
    switch (await _debts.getDebts()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value) when value.any((d) => d.payeeId == id):
        return const Err(ValidationFailure('A debt uses this entity.'));
      case Ok():
        return await _payees.delete(id);
    }
  }
}
