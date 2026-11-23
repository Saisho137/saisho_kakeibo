import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payee_dao.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

class PayeeRepositoryImpl implements PayeeRepository {
  const new(this._dao);

  final PayeeDao _dao;

  @override
  Future<Result<void>> rename(int id, PayeeName name) =>
      guardDatabase(() => _dao.rename(id, name: name.name, key: name.key));

  @override
  Future<Result<void>> merge({required int from, required int into}) =>
      guardDatabase(() => _dao.merge(from: from, into: into));

  @override
  Future<Result<void>> delete(int id) =>
      guardDatabase(() => _dao.deletePayee(id));
}
