import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

final class SaveDebtParams {
  const new(this.debt, {this.payeeName});

  /// A debt with id `0` is created; any other id is replaced.
  final Debt debt;

  /// Creditor or debtor as typed; reused if one with the same key exists.
  final String? payeeName;
}

/// Creates or edits a debt (RF-09). Its type can't change, nor its
/// currency once a movement references it.
class SaveDebt implements UseCase<Future<Result<int>>, SaveDebtParams> {
  const new(this._repository);

  final DebtRepository _repository;

  @override
  Future<Result<int>> call(SaveDebtParams params) async {
    final payee = PayeeName.parse(params.payeeName);
    final debt = DebtRules.normalize(params.debt);
    final errors = DebtRules.validate(
      debt,
      hasPayee: payee != null || debt.payeeId != 0,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid debt: $errors'));
    }
    if (debt.id != 0) {
      final Debt? original;
      switch (await _repository.findDebt(debt.id)) {
        case Ok(:final value):
          original = value;
        case Err(:final failure):
          return Err(failure);
      }
      if (original == null) {
        return Err(ValidationFailure('Unknown debt ${debt.id}'));
      }
      if (original.type != debt.type) {
        return const Err(ValidationFailure("A debt's type can't change."));
      }
      if (original.currencyCode != debt.currencyCode) {
        switch (await _repository.getMovements(debt.id)) {
          case Ok(value: final movements) when movements.isNotEmpty:
            return const Err(
              ValidationFailure('A debt with movements keeps its currency.'),
            );
          case Err(:final failure):
            return Err(failure);
          case Ok():
            break;
        }
      }
    }
    return await _repository.saveDebt(debt, payee: payee);
  }
}
