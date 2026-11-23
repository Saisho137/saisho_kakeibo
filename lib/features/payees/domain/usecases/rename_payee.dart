import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

final class RenamePayeeParams {
  const new({required this.id, required this.name});

  final int id;

  /// As typed; normalized like any entity (RF-07).
  final String name;
}

/// Renames an entity (RF-08). A name that another entity already has is
/// refused: merging is how two entities become one.
class RenamePayee implements UseCase<Future<Result<void>>, RenamePayeeParams> {
  const new({required this._payees, required this._movements});

  final PayeeRepository _payees;
  final MovementRepository _movements;

  @override
  Future<Result<void>> call(RenamePayeeParams params) async {
    final name = PayeeName.parse(params.name);
    if (name == null) {
      return const Err(ValidationFailure('An entity needs a name.'));
    }
    switch (await _movements.getPayees()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value)
          when value.any((p) => p.key == name.key && p.id != params.id):
        return const Err(ValidationFailure('Another entity has that name.'));
      case Ok(:final value) when !value.any((p) => p.id == params.id):
        return Err(ValidationFailure('Unknown entity ${params.id}'));
      case Ok():
        return await _payees.rename(params.id, name);
    }
  }
}
