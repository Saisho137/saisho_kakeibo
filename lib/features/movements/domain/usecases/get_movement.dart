import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

class GetMovement implements UseCase<Future<Result<Movement?>>, int> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Future<Result<Movement?>> call(int id) => _repository.findById(id);
}
