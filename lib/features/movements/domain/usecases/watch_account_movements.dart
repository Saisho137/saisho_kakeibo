import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

/// Movements of an account, newest first, for its detail screen.
class WatchAccountMovements implements UseCase<Stream<List<Movement>>, int> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Stream<List<Movement>> call(int accountId) =>
      _repository.watchByAccount(accountId);
}
