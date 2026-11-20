import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

extension AccountRowMapper on AccountRow {
  Account toEntity() => Account(
    id: id,
    name: name,
    iconKey: iconKey,
    color: color,
    type: type,
    currencyCode: currencyCode,
    openingBalance: openingBalance,
    openingDate: openingDate,
    includeInBalance: includeInBalance,
    isMain: isMain,
    parentAccountId: parentAccountId,
    creditLimit: creditLimit,
    paymentDay: paymentDay,
    sortOrder: sortOrder,
    isArchived: isArchived,
  );
}

extension AccountCompanionMapper on Account {
  /// Row to insert: the database assigns the id.
  AccountsCompanion toInsertCompanion() =>
      toCompanion().copyWith(id: const Value.absent());

  AccountsCompanion toCompanion() => AccountsCompanion(
    id: Value(id),
    name: Value(name),
    iconKey: Value(iconKey),
    color: Value(color),
    type: Value(type),
    currencyCode: Value(currencyCode),
    openingBalance: Value(openingBalance),
    openingDate: Value(openingDate),
    includeInBalance: Value(includeInBalance),
    isMain: Value(isMain),
    parentAccountId: Value(parentAccountId),
    creditLimit: Value(creditLimit),
    paymentDay: Value(paymentDay),
    sortOrder: Value(sortOrder),
    isArchived: Value(isArchived),
  );
}
