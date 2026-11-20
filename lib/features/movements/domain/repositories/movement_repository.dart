import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

/// Contract implemented by the data layer. Business rules live in the use
/// cases; the repository only stores what they decide, atomically.
abstract interface class MovementRepository {
  /// Movements on either side of [accountId], newest first.
  Stream<List<Movement>> watchByAccount(int accountId);

  /// Every movement, newest first.
  Stream<List<Movement>> watchAll();

  Stream<List<Payee>> watchPayees();

  Future<Result<Movement?>> findById(int id);

  Future<Result<List<Payee>>> getPayees();

  /// Latest movement of [categoryId], if any.
  Future<Result<Movement?>> lastOfCategory(int categoryId);

  /// Latest transfer from [fromAccountId] to [toAccountId], if any.
  Future<Result<Movement?>> lastTransfer(int fromAccountId, int toAccountId);

  /// Latest movement of [type] of every payee that has one.
  Future<Result<List<Movement>>> lastOfEachPayee(MovementType type);

  /// Inserts or replaces [movement]. With a [payee], it is found by key or
  /// created, and set on the movement, in the same transaction. Returns the
  /// movement id.
  Future<Result<int>> save(Movement movement, {PayeeName? payee});

  Future<Result<void>> delete(int id);
}
