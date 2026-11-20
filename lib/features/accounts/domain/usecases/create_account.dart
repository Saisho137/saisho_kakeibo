import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';

/// Creates an account at the end of its group. A new main account takes
/// the mark from the previous one. Returns the new id.
class CreateAccount implements UseCase<Future<Result<int>>, Account> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<int>> call(Account account) async {
    final loaded = await _repository.getAccounts();
    if (loaded case Err(:final failure)) return Err(failure);
    final accounts = (loaded as Ok<List<Account>>).value;
    final parent = accounts.byId(account.parentAccountId);
    final normalized = AccountRules.normalize(
      account.copyWith(id: 0, isArchived: false),
      parent: parent,
    );
    final errors = AccountRules.validate(normalized, parent: parent);
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid account: $errors'));
    }
    return await _repository.create(
      normalized.copyWith(sortOrder: accounts.nextSortOrder(normalized)),
      alsoSave: [
        if (normalized.isMain)
          for (final a in accounts.where((a) => a.isMain))
            a.copyWith(isMain: false),
      ],
    );
  }
}
