import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/account_dao.dart';
import 'package:saisho_kakeibo/features/accounts/data/models/account_row_mapper.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  const new(this._dao);

  final AccountDao _dao;

  @override
  Stream<List<Account>> watchAccounts() => _dao.watchAll().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Stream<Map<int, int>> watchBalances() => _dao.watchBalances();

  @override
  Future<Result<List<Account>>> getAccounts() => guardDatabase(
    () async => (await _dao.getAll())
        .map((row) => row.toEntity())
        .toList(growable: false),
  );

  @override
  Future<Result<Account?>> findById(int id) =>
      guardDatabase(() async => (await _dao.findById(id))?.toEntity());

  @override
  Future<Result<int>> create(
    Account account, {
    List<Account> alsoSave = const [],
  }) => guardDatabase(
    () => _dao.create(
      account.toInsertCompanion(),
      alsoSave: [for (final a in alsoSave) a.toCompanion()],
    ),
  );

  @override
  Future<Result<void>> saveAll(List<Account> accounts) => guardDatabase(
    () => _dao.saveAll([for (final a in accounts) a.toCompanion()]),
  );

  @override
  Future<Result<void>> reorder(List<int> ids) =>
      guardDatabase(() => _dao.reorder(ids));

  // Movements arrive in phase 4; until then no account has any.
  @override
  Future<Result<bool>> hasMovements(int id) async => const Ok(false);

  @override
  Future<Result<void>> delete(List<int> ids) =>
      guardDatabase(() => _dao.deleteAll(ids));
}
