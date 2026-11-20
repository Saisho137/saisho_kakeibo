import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

/// Every payee, for autocompleting the payee field (RF-07).
class GetPayees implements UseCase<Future<Result<List<Payee>>>, NoParams> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Future<Result<List<Payee>>> call(NoParams params) => _repository.getPayees();
}
