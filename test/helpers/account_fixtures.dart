import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

final LocalDate openingDay = LocalDate(2026, 1, 1);

/// An account with sensible defaults for tests.
Account account({
  required int id,
  AccountType type = AccountType.bank,
  String? name,
  String currencyCode = 'COP',
  int openingBalance = 0,
  bool includeInBalance = false,
  bool isMain = false,
  int? parentAccountId,
  int? creditLimit,
  int? paymentDay,
  int sortOrder = 0,
  bool isArchived = false,
}) => Account(
  id: id,
  name: name ?? 'Account $id',
  iconKey: type.defaultIconKey,
  color: 0xFF3949AB,
  type: type,
  currencyCode: currencyCode,
  openingBalance: openingBalance,
  openingDate: openingDay,
  includeInBalance: includeInBalance,
  isMain: isMain,
  parentAccountId: parentAccountId,
  creditLimit: creditLimit,
  paymentDay: paymentDay,
  sortOrder: sortOrder,
  isArchived: isArchived,
);
