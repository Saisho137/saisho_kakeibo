import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

final class SaveMovementParams {
  const new(this.movement, {this.payeeName});

  /// A movement with id `0` is created; any other id is replaced.
  final Movement movement;

  /// Payee as typed; it is reused if one with the same key exists (RF-08).
  final String? payeeName;
}

/// Creates or edits a movement (RT-04). Archived accounts only keep the
/// movements they already had.
class SaveMovement implements UseCase<Future<Result<int>>, SaveMovementParams> {
  const new({
    required this._movements,
    required this._accounts,
    required this._categories,
  });

  final MovementRepository _movements;
  final AccountRepository _accounts;
  final CategoryRepository _categories;

  @override
  Future<Result<int>> call(SaveMovementParams params) async {
    final List<Account> accounts;
    final List<Category> categories;
    switch ((
      await _accounts.getAccounts(),
      await _categories.getCategories(),
    )) {
      case (Ok(value: final a), Ok(value: final c)):
        (accounts, categories) = (a, c);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
    Movement? original;
    if (params.movement.id != 0) {
      final found = await _movements.findById(params.movement.id);
      if (found case Err(:final failure)) return Err(failure);
      original = (found as Ok<Movement?>).value;
      if (original == null) {
        return Err(ValidationFailure('Unknown movement ${params.movement.id}'));
      }
    }

    final account = accounts.byId(params.movement.accountId);
    final toAccount = accounts.byId(params.movement.toAccountId);
    final movement = MovementRules.normalize(
      params.movement,
      account: account,
      toAccount: toAccount,
    );
    final payee = PayeeName.parse(params.payeeName);
    final errors = MovementRules.validate(
      movement,
      account: account,
      toAccount: toAccount,
      category: categories.byId(movement.categoryId),
      hasPayee: payee != null,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid movement: $errors'));
    }
    bool newlyUsed(Account? a) =>
        a != null && a.isArchived && original?.involves(a.id) != true;
    if (newlyUsed(account) || newlyUsed(toAccount)) {
      return const Err(ValidationFailure('Archived accounts take no more.'));
    }
    return await _movements.save(
      movement.copyWith(payeeId: null),
      payee: payee,
    );
  }
}
