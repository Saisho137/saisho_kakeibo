import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

extension RecurringTemplateRowMapper on RecurringTemplateRow {
  RecurringTemplate toEntity() => RecurringTemplate(
    id: id,
    type: type,
    cadence: cadence,
    categoryId: categoryId,
    accountId: accountId,
    toAccountId: toAccountId,
    amount: amount,
    toAmount: toAmount,
    payeeId: payeeId,
    note: note,
    dueDay: dueDay,
    remind: remind,
    isActive: isActive,
    createdOn: createdOn,
  );
}

extension RecurringTemplateCompanionMapper on RecurringTemplate {
  /// A new template (id `0`) leaves the id to the database.
  RecurringTemplatesCompanion toCompanion() => RecurringTemplatesCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    type: Value(type),
    cadence: Value(cadence),
    categoryId: Value(categoryId),
    accountId: Value(accountId),
    toAccountId: Value(toAccountId),
    amount: Value(amount),
    toAmount: Value(toAmount),
    payeeId: Value(payeeId),
    note: Value(note),
    dueDay: Value(dueDay),
    remind: Value(remind),
    isActive: Value(isActive),
    createdOn: Value(createdOn),
  );
}
