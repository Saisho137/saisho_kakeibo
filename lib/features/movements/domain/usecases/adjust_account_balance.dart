import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

final class AdjustAccountBalanceParams {
  const new({
    required this.accountId,
    required this.actualBalance,
    required this.date,
  });

  final int accountId;

  /// The real balance, as the bank shows it: pockets included for a
  /// parent account. In minor units.
  final int actualBalance;
  final LocalDate date;
}

/// Saves the difference between the real balance and the app's as an
/// adjustment (RF-15). For a parent account the difference goes to its own
/// part, outside the pockets. Nothing is saved when they already match.
class AdjustAccountBalance
    implements UseCase<Future<Result<void>>, AdjustAccountBalanceParams> {
  const new({required this._accounts, required this._movements});

  final AccountRepository _accounts;
  final MovementRepository _movements;

  @override
  Future<Result<void>> call(AdjustAccountBalanceParams params) async {
    final List<Account> accounts;
    final Map<int, int> balances;
    switch ((await _accounts.getAccounts(), await _accounts.getBalances())) {
      case (Ok(value: final a), Ok(value: final b)):
        (accounts, balances) = (a, b);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
    final account = accounts.byId(params.accountId);
    if (account == null) {
      return Err(ValidationFailure('Unknown account ${params.accountId}'));
    }
    final current = [
      account,
      ...accounts.pocketsOf(account.id),
    ].fold(0, (sum, a) => sum + (balances[a.id] ?? a.openingBalance));
    final difference = params.actualBalance - current;
    if (difference == 0) return const Ok(null);
    final saved = await _movements.save(
      Movement(
        type: MovementType.adjustment,
        date: params.date,
        accountId: account.id,
        amount: difference,
      ),
    );
    return switch (saved) {
      Ok() => const Ok(null),
      Err(:final failure) => Err(failure),
    };
  }
}
