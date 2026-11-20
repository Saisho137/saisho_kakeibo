import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

/// Every movement, newest first. The Home splits them by period in memory,
/// so swiping shows the next period at once (RF-14).
class WatchMovements implements UseCase<Stream<List<Movement>>, NoParams> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Stream<List<Movement>> call(NoParams params) => _repository.watchAll();
}
