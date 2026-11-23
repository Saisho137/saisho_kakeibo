import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

/// Contract implemented by the data layer.
abstract interface class DebtRepository {
  Stream<List<Debt>> watchDebts();

  Future<Result<List<Debt>>> getDebts();

  Future<Result<Debt?>> findDebt(int id);

  /// Inserts or replaces [debt]. With a [payee], it is found by key or
  /// created and set on the debt. Returns its id.
  Future<Result<int>> saveDebt(Debt debt, {PayeeName? payee});

  /// Movements that reference the debt [id], newest first.
  Future<Result<List<Movement>>> getMovements(int id);

  Future<Result<void>> deleteDebt(int id);
}
