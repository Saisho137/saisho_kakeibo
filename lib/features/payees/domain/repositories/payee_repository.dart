import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

/// Changes to the entities themselves (RF-08). They are created and listed
/// with the movements.
abstract interface class PayeeRepository {
  /// Renames the entity [id]; a debt that is that entity takes the name.
  Future<Result<void>> rename(int id, PayeeName name);

  /// Moves the movements, recurring templates and debts of [from] to
  /// [into], then deletes [from]. A moved debt takes the name of [into].
  Future<Result<void>> merge({required int from, required int into});

  /// Deletes the entity [id]; its movements and templates keep no entity.
  Future<Result<void>> delete(int id);
}
