import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';

/// A debt I owe of 1.000.000 COP to payee 1, in Survival, unless said
/// otherwise.
Debt debt({
  int id = 1,
  DebtType type = DebtType.iOwe,
  String name = 'Mortgage',
  int payeeId = 1,
  String currencyCode = 'COP',
  int initialPending = 1000000,
  int? pillarId = 1,
  int? installment,
  int? dueDay,
  LocalDate? dueDate,
  int adjustment = 0,
}) => Debt(
  id: id,
  type: type,
  name: name,
  iconKey: 'request_quote',
  color: 0xFFF4511E,
  payeeId: payeeId,
  currencyCode: currencyCode,
  initialPending: initialPending,
  pillarId: type == DebtType.iOwe ? pillarId : null,
  installment: installment,
  dueDay: dueDay,
  dueDate: dueDate,
  adjustment: adjustment,
  createdOn: LocalDate(2026, 1, 1),
);
