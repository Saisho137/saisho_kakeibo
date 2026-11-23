import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'movement.freezed.dart';

/// The four kinds of movement (RT-04).
enum MovementType {
  income,
  expense,

  /// Between two accounts of mine. Adds to the Transfers total.
  transfer,

  /// Corrects a balance to match the real one. Adds to no total.
  adjustment,
}

/// Money that moves in, out of or between my accounts (RT-04, RT-05).
/// Amounts are in the minor unit of their account's currency.
@freezed
abstract class Movement with _$Movement {
  const factory({
    required MovementType type,
    required LocalDate date,

    /// The account that receives an income, pays an expense, sends a
    /// transfer or is adjusted.
    required int accountId,

    /// Positive, except for an adjustment: the signed difference.
    required int amount,

    /// Database id; `0` for a movement that is not stored yet.
    @Default(0) int id,

    /// Account that receives a transfer.
    int? toAccountId,

    /// What a transfer adds to [toAccountId]; it differs from [amount] only
    /// between currencies.
    int? toAmount,

    /// Required for incomes, expenses and transfers.
    int? categoryId,

    /// Only incomes and expenses have one.
    int? payeeId,
    String? note,

    /// Debt the movement creates, pays or collects (RF-09).
    int? debtId,

    /// Template a pending movement was created from (RF-06).
    int? recurringTemplateId,

    /// Waiting for confirmation. A pending income does not move the balance
    /// until confirmed (RF-06).
    @Default(false) bool isPending,

    /// A salary that starts a period (RF-05).
    @Default(false) bool startsPeriod,
  }) = _Movement;

  const new _();

  /// How much the movement changes the balance of [account].
  int effectOn(int account) {
    var effect = 0;
    if (accountId == account) {
      effect += switch (type) {
        MovementType.income => isPending ? 0 : amount,
        MovementType.expense || MovementType.transfer => -amount,
        MovementType.adjustment => amount,
      };
    }
    if (type == MovementType.transfer && toAccountId == account) {
      effect += toAmount ?? amount;
    }
    return effect;
  }

  /// Whether [account] is on either side of the movement.
  bool involves(int account) => accountId == account || toAccountId == account;
}
