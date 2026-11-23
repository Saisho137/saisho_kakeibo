import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'debt.freezed.dart';

/// Who owes whom (RF-09).
enum DebtType {
  /// A loan or credit I pay back: a mortgage, a loan received.
  iOwe,

  /// Money I lent and will collect.
  owedToMe,
}

/// A debt, outside the accounts: it never moves a balance by itself
/// (RF-09). Only the movements that reference it change what is pending.
@freezed
abstract class Debt with _$Debt {
  const factory({
    required DebtType type,
    required String name,
    required String iconKey,

    /// ARGB color of its icon circle.
    required int color,

    /// The creditor or the debtor.
    required int payeeId,
    required String currencyCode,

    /// What was pending when the debt was registered, in the minor unit of
    /// [currencyCode]: what the bank reports or what was agreed.
    required int initialPending,
    required LocalDate createdOn,
    @Default(0) int id,

    /// Pillar its payments inherit; only debts I owe have one (RF-02).
    int? pillarId,

    /// Prefills the amount of a payment.
    int? installment,

    /// Day of the month a debt I owe is due, for its reminder.
    int? dueDay,

    /// The single date a debt owed to me is due, for its reminder.
    LocalDate? dueDate,

    /// Correction made with "Edit pending", which moves no money.
    @Default(0) int adjustment,
  }) = _Debt;

  const new _();

  bool get iOwe => type == DebtType.iOwe;
}
