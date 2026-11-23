import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';

class GetDebt implements UseCase<Future<Result<Debt?>>, int> {
  const new(this._repository);

  final DebtRepository _repository;

  @override
  Future<Result<Debt?>> call(int id) => _repository.findDebt(id);
}
