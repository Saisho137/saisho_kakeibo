import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';

/// Movements of every account in a period, newest first, for its totals
/// and history (RF-14).
class WatchPeriodMovements implements UseCase<Stream<List<Movement>>, Period> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Stream<List<Movement>> call(Period period) =>
      _repository.watchBetween(period.start, period.end);
}
