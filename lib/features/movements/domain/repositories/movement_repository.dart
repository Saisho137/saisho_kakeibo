import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

/// Contract implemented by the data layer. Business rules live in the use
/// cases; the repository only stores what they decide, atomically.
abstract interface class MovementRepository {
  /// Movements on either side of [accountId], newest first.
  Stream<List<Movement>> watchByAccount(int accountId);

  Stream<List<Payee>> watchPayees();

  Future<Result<Movement?>> findById(int id);

  /// Inserts or replaces [movement]. With a [payee], it is found by key or
  /// created, and set on the movement, in the same transaction. Returns the
  /// movement id.
  Future<Result<int>> save(Movement movement, {PayeeName? payee});

  Future<Result<void>> delete(int id);
}
