import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';

extension DebtRowMapper on DebtRow {
  Debt toEntity() => Debt(
    id: id,
    type: type,
    name: name,
    iconKey: iconKey,
    color: color,
    payeeId: payeeId,
    currencyCode: currencyCode,
    initialPending: initialPending,
    adjustment: adjustment,
    pillarId: pillarId,
    installment: installment,
    dueDay: dueDay,
    dueDate: dueDate,
    createdOn: createdOn,
  );
}

extension DebtCompanionMapper on Debt {
  /// A new debt (id `0`) leaves the id to the database.
  DebtsCompanion toCompanion() => DebtsCompanion(
    id: id == 0 ? const Value.absent() : Value(id),
    type: Value(type),
    name: Value(name),
    iconKey: Value(iconKey),
    color: Value(color),
    payeeId: Value(payeeId),
    currencyCode: Value(currencyCode),
    initialPending: Value(initialPending),
    adjustment: Value(adjustment),
    pillarId: Value(pillarId),
    installment: Value(installment),
    dueDay: Value(dueDay),
    dueDate: Value(dueDate),
    createdOn: Value(createdOn),
  );
}
