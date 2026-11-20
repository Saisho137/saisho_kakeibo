import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movement_dao.dart';
import 'package:saisho_kakeibo/features/movements/data/models/movement_row_mapper.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/data/models/payee_row_mapper.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

class MovementRepositoryImpl implements MovementRepository {
  const new(this._dao);

  final MovementDao _dao;

  @override
  Stream<List<Movement>> watchByAccount(int accountId) => _dao
      .watchByAccount(accountId)
      .map((rows) => rows.map((row) => row.toEntity()).toList(growable: false));

  @override
  Stream<List<Payee>> watchPayees() => _dao.watchPayees().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<Movement?>> findById(int id) =>
      guardDatabase(() async => (await _dao.findById(id))?.toEntity());

  @override
  Future<Result<int>> save(Movement movement, {PayeeName? payee}) =>
      guardDatabase(
        () => _dao.save(
          movement.toCompanion(),
          payeeName: payee?.name,
          payeeKey: payee?.key,
        ),
      );

  @override
  Future<Result<void>> delete(int id) =>
      guardDatabase(() => _dao.deleteById(id));
}
