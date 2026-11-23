import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

part 'recurring_template.freezed.dart';

/// When a template creates its pending movement (RF-06).
enum RecurringCadence {
  /// At each dynamic period start: a salary with "Starts period" or a
  /// manual start (barber, groceries).
  period,

  /// At each monthly period start, on the cutoff day, whatever period
  /// type the Home shows (subscriptions, building fee).
  monthly,
}

/// A fixed income, expense or transfer that repeats every period (RF-06).
@freezed
abstract class RecurringTemplate with _$RecurringTemplate {
  const factory({
    required MovementType type,
    required int categoryId,
    required int accountId,

    /// In the minor unit of [accountId]'s currency. Confirming one of its
    /// movements copies that amount here (RF-06).
    required int amount,

    /// The day the template was saved; its first movement comes at the
    /// next period start, never in the period it was created (RF-06).
    required LocalDate createdOn,
    @Default(0) int id,
    @Default(RecurringCadence.period) RecurringCadence cadence,

    /// Receiving account of a transfer.
    int? toAccountId,

    /// What a transfer adds to [toAccountId]; it differs from [amount] only
    /// between currencies.
    int? toAmount,

    /// Only incomes and expenses have one.
    int? payeeId,
    String? note,

    /// Day of the month it is due: the reminder day of expenses and
    /// transfers, and the date of incomes.
    int? dueDay,

    /// Notify on [dueDay]; only possible with one.
    @Default(false) bool remind,

    /// A paused template creates nothing.
    @Default(true) bool isActive,

    /// The debt a template of Debt payment or Loan repaid pays or collects
    /// (RF-09), such as a mortgage's installment.
    int? debtId,
  }) = _RecurringTemplate;

  const new _();

  /// The movement this template creates on [date], pending until reviewed.
  Movement toMovement(LocalDate date) => Movement(
    type: type,
    date: date,
    accountId: accountId,
    amount: amount,
    toAccountId: toAccountId,
    toAmount: toAmount,
    categoryId: categoryId,
    payeeId: payeeId,
    note: note,
    recurringTemplateId: id,
    debtId: debtId,
    isPending: true,
  );
}
