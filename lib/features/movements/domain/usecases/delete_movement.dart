import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

class DeleteMovement implements UseCase<Future<Result<void>>, int> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Future<Result<void>> call(int id) async => await _repository.delete(id);
}
