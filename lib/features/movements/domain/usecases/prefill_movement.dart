import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement_draft.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

final class PrefillMovementParams {
  const new({required this.type, this.categoryId, this.payeeId});

  final MovementType type;
  final int? categoryId;

  /// A payee picked in the search: it brings its last category and amount.
  final int? payeeId;
}

/// Prefills the quick entry form from history (RF-01, RF-08): a category
/// brings the account and payee of its last movement; a payee brings its
/// last category, account and amount. Without history, or when that
/// account is archived, the account is the main one.
class PrefillMovement
    implements UseCase<Future<Result<MovementDraft>>, PrefillMovementParams> {
  const new({required this._movements, required this._accounts});

  final MovementRepository _movements;
  final AccountRepository _accounts;

  @override
  Future<Result<MovementDraft>> call(PrefillMovementParams params) async {
    final List<Account> accounts;
    final List<Payee> payees;
    switch ((await _accounts.getAccounts(), await _movements.getPayees())) {
      case (Ok(value: final a), Ok(value: final p)):
        (accounts, payees) = (a, p);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
    Movement? last;
    final payeeId = params.payeeId;
    final categoryId = params.categoryId;
    if (payeeId != null) {
      final found = await _movements.lastOfEachPayee(params.type);
      if (found case Err(:final failure)) return Err(failure);
      last = (found as Ok<List<Movement>>).value
          .where((m) => m.payeeId == payeeId)
          .firstOrNull;
    } else if (categoryId != null) {
      final found = await _movements.lastOfCategory(categoryId);
      if (found case Err(:final failure)) return Err(failure);
      last = (found as Ok<Movement?>).value;
    }

    final active = accounts.where((a) => !a.isArchived);
    final used = active.byId(last?.accountId);
    final main =
        active.where((a) => a.isMain).firstOrNull ?? active.firstOrNull;
    final payee = payees.where((p) => p.id == (payeeId ?? last?.payeeId));
    return Ok(
      MovementDraft(
        categoryId: payeeId == null ? categoryId : last?.categoryId,
        accountId: (used ?? main)?.id,
        payeeName: payee.firstOrNull?.name,
        amount: payeeId == null ? null : last?.amount,
      ),
    );
  }
}
