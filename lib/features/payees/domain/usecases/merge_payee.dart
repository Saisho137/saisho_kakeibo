import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';

final class MergePayeeParams {
  const new({required this.from, required this.into});

  final int from;
  final int into;
}

/// *Merge into…* (RF-08): the movements of [MergePayeeParams.from] go to
/// [MergePayeeParams.into], for duplicates the normalization does not catch
/// ("Peaje Palmas" and "Peaje Las Palmas"), and the first is deleted.
class MergePayee implements UseCase<Future<Result<void>>, MergePayeeParams> {
  const new({required this._payees, required this._movements});

  final PayeeRepository _payees;
  final MovementRepository _movements;

  @override
  Future<Result<void>> call(MergePayeeParams params) async {
    if (params.from == params.into) {
      return const Err(ValidationFailure('An entity merges into another.'));
    }
    switch (await _movements.getPayees()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value)
          when !value.any((p) => p.id == params.from) ||
              !value.any((p) => p.id == params.into):
        return const Err(ValidationFailure('Unknown entity.'));
      case Ok():
        return await _payees.merge(from: params.from, into: params.into);
    }
  }
}
