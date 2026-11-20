import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

final LocalDate movementDay = LocalDate(2026, 3, 10);

/// An expense of 1.000 from account 1 with sensible defaults for tests.
Movement movement({
  int id = 0,
  MovementType type = MovementType.expense,
  LocalDate? date,
  int accountId = 1,
  int amount = 1000,
  int? toAccountId,
  int? toAmount,
  int? categoryId,
  int? payeeId,
  String? note,
  bool isPending = false,
}) => Movement(
  id: id,
  type: type,
  date: date ?? movementDay,
  accountId: accountId,
  amount: amount,
  toAccountId: toAccountId,
  toAmount: toAmount,
  categoryId: categoryId,
  payeeId: payeeId,
  note: note,
  isPending: isPending,
);
