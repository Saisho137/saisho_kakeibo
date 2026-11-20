import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';

/// Saves the editable fields of an account (RF-15). The type never
/// changes, the currency only while there are no movements, and the main
/// mark only moves by marking another account. Pockets follow their
/// parent's currency and Balance inclusion.
class UpdateAccount implements UseCase<Future<Result<void>>, Account> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<void>> call(Account account) async {
    final loaded = await _repository.getAccounts();
    if (loaded case Err(:final failure)) return Err(failure);
    final accounts = (loaded as Ok<List<Account>>).value;
    final original = accounts.byId(account.id);
    if (original == null) {
      return Err(ValidationFailure('Unknown account ${account.id}'));
    }
    if (account.type != original.type) {
      return const Err(ValidationFailure('The account type never changes.'));
    }
    if (original.isMain && !account.isMain) {
      return const Err(ValidationFailure('Mark another account as main.'));
    }
    final parent = accounts.byId(account.parentAccountId);
    final sameParent = account.parentAccountId == original.parentAccountId;
    var updated = AccountRules.normalize(
      account.copyWith(
        isArchived: original.isArchived,
        sortOrder: original.sortOrder,
      ),
      parent: parent,
    );
    if (!sameParent) {
      updated = updated.copyWith(sortOrder: accounts.nextSortOrder(updated));
    }
    final errors = AccountRules.validate(
      updated,
      parent: parent,
      parentMayBeArchived: sameParent,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid account: $errors'));
    }
    final pockets = accounts.pocketsOf(original.id).toList();
    if (updated.currencyCode != original.currencyCode) {
      for (final id in [original.id, ...pockets.map((p) => p.id)]) {
        final moved = await _repository.hasMovements(id);
        if (moved case Err(:final failure)) return Err(failure);
        if (moved case Ok(value: true)) {
          return const Err(
            ValidationFailure('The currency is locked by movements.'),
          );
        }
      }
    }
    return await _repository.saveAll([
      updated,
      for (final pocket in pockets)
        pocket.copyWith(
          currencyCode: updated.currencyCode,
          includeInBalance: updated.includeInBalance,
        ),
      if (updated.isMain && !original.isMain)
        for (final main in accounts.where((a) => a.isMain))
          main.copyWith(isMain: false),
    ]);
  }
}
