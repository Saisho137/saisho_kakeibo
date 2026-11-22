import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

/// An expense template of 1.000 in account 1, category 10,
/// created on [LocalDate] 2026-03-01 unless said otherwise.
RecurringTemplate template({
  int id = 1,
  MovementType type = MovementType.expense,
  RecurringCadence cadence = RecurringCadence.period,
  int categoryId = 10,
  int accountId = 1,
  int amount = 1000,
  int? toAccountId,
  int? toAmount,
  int? payeeId,
  int? dueDay,
  bool remind = false,
  bool isActive = true,
  LocalDate? createdOn,
}) => RecurringTemplate(
  id: id,
  type: type,
  cadence: cadence,
  categoryId: categoryId,
  accountId: accountId,
  amount: amount,
  toAccountId: toAccountId,
  toAmount: toAmount,
  payeeId: payeeId,
  dueDay: dueDay,
  remind: remind,
  isActive: isActive,
  createdOn: createdOn ?? LocalDate(2026, 3, 1),
);
