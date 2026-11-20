import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

/// Payees used with movements of a type, for the search of the category
/// grid (RF-08).
class GetPayeeSuggestions
    implements UseCase<Future<Result<List<Payee>>>, MovementType> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Future<Result<List<Payee>>> call(MovementType type) async {
    switch ((
      await _repository.getPayees(),
      await _repository.lastOfEachPayee(type),
    )) {
      case (Ok(value: final payees), Ok(value: final last)):
        final used = {for (final m in last) m.payeeId};
        return Ok([
          for (final p in payees)
            if (used.contains(p.id)) p,
        ]);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
  }
}
