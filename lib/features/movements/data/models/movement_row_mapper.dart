import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

extension MovementRowMapper on MovementRow {
  Movement toEntity() => Movement(
    id: id,
    type: type,
    date: date,
    accountId: accountId,
    amount: amount,
    toAccountId: toAccountId,
    toAmount: toAmount,
    categoryId: categoryId,
    payeeId: payeeId,
    note: note,
    debtId: debtId,
    recurringTemplateId: recurringTemplateId,
    isPending: isPending,
    startsPeriod: startsPeriod,
  );
}

extension MovementCompanionMapper on Movement {
  /// A new movement (id `0`) leaves the id to the database.
  MovementsCompanion toCompanion() => MovementsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    type: Value(type),
    date: Value(date),
    accountId: Value(accountId),
    amount: Value(amount),
    toAccountId: Value(toAccountId),
    toAmount: Value(toAmount),
    categoryId: Value(categoryId),
    payeeId: Value(payeeId),
    note: Value(note),
    debtId: Value(debtId),
    recurringTemplateId: Value(recurringTemplateId),
    isPending: Value(isPending),
    startsPeriod: Value(startsPeriod),
  );
}
