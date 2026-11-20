import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

/// Deletes an account without movements (RF-15). The main account and
/// accounts with pockets cannot be deleted.
class DeleteAccount implements UseCase<Future<Result<void>>, int> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<void>> call(int id) async {
    final loaded = await _repository.getAccounts();
    if (loaded case Err(:final failure)) return Err(failure);
    final accounts = (loaded as Ok<List<Account>>).value;
    final account = accounts.byId(id);
    if (account == null) return Err(ValidationFailure('Unknown account $id'));
    if (account.isMain) {
      return const Err(ValidationFailure('The main account stays.'));
    }
    if (accounts.pocketsOf(id).isNotEmpty) {
      return const Err(ValidationFailure('Delete its pockets first.'));
    }
    final moved = await _repository.hasMovements(id);
    if (moved case Err(:final failure)) return Err(failure);
    if (moved case Ok(value: true)) {
      return const Err(ValidationFailure('Accounts with movements stay.'));
    }
    return await _repository.delete(id);
  }
}
