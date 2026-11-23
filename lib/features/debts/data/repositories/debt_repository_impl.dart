import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debt_dao.dart';
import 'package:saisho_kakeibo/features/debts/data/models/debt_row_mapper.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/movements/data/models/movement_row_mapper.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

class DebtRepositoryImpl implements DebtRepository {
  const new(this._dao);

  final DebtDao _dao;

  @override
  Stream<List<Debt>> watchDebts() => _dao.watchDebts().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<List<Debt>>> getDebts() => guardDatabase(
    () async => (await _dao.getDebts()).map((row) => row.toEntity()).toList(),
  );

  @override
  Future<Result<Debt?>> findDebt(int id) =>
      guardDatabase(() async => (await _dao.findDebt(id))?.toEntity());

  @override
  Future<Result<int>> saveDebt(Debt debt, {PayeeName? payee}) => guardDatabase(
    () => _dao.saveDebt(
      debt.toCompanion(),
      payeeName: payee?.name,
      payeeKey: payee?.key,
    ),
  );

  @override
  Future<Result<List<Movement>>> getMovements(int id) => guardDatabase(
    () async =>
        (await _dao.getMovements(id)).map((row) => row.toEntity()).toList(),
  );

  @override
  Future<Result<void>> deleteDebt(int id) =>
      guardDatabase(() => _dao.deleteDebt(id));
}
