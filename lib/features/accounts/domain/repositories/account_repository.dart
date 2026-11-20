import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

/// Contract implemented by the data layer. Business rules live in the use
/// cases; the repository only stores what they decide, atomically.
abstract interface class AccountRepository {
  /// Every account, archived included, by [Account.sortOrder].
  Stream<List<Account>> watchAccounts();

  /// Own balance of each account by id, in minor units: opening balance
  /// plus its movements. A parent's value does not include its pockets.
  Stream<Map<int, int>> watchBalances();

  Future<Result<List<Account>>> getAccounts();

  Future<Result<Account?>> findById(int id);

  /// Inserts [account] and saves [alsoSave] in the same transaction.
  /// Returns the new id.
  Future<Result<int>> create(
    Account account, {
    List<Account> alsoSave = const [],
  });

  /// Saves every account in one transaction.
  Future<Result<void>> saveAll(List<Account> accounts);

  /// Sets [Account.sortOrder] to the position of each id.
  Future<Result<void>> reorder(List<int> ids);

  Future<Result<bool>> hasMovements(int id);

  Future<Result<void>> delete(int id);
}
