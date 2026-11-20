import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

final class SetAccountArchivedParams {
  const new({required this.id, required this.archived});

  final int id;
  final bool archived;
}

/// Archives or restores an account and its pockets together (RF-15). The
/// main account cannot be archived, and a pocket cannot be restored while
/// its parent is archived.
class SetAccountArchived
    implements UseCase<Future<Result<void>>, SetAccountArchivedParams> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<void>> call(SetAccountArchivedParams params) async {
    final loaded = await _repository.getAccounts();
    if (loaded case Err(:final failure)) return Err(failure);
    final accounts = (loaded as Ok<List<Account>>).value;
    final account = accounts.byId(params.id);
    if (account == null) {
      return Err(ValidationFailure('Unknown account ${params.id}'));
    }
    if (params.archived && account.isMain) {
      return const Err(ValidationFailure('The main account stays active.'));
    }
    final parent = accounts.byId(account.parentAccountId);
    if (!params.archived && (parent?.isArchived ?? false)) {
      return const Err(ValidationFailure('Restore the parent account first.'));
    }
    return await _repository.saveAll([
      for (final a in [account, ...accounts.pocketsOf(account.id)])
        a.copyWith(isArchived: params.archived),
    ]);
  }
}
