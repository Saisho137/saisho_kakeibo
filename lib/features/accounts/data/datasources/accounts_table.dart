import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';

/// Accounts, pockets included (RT-12). Amounts are in the minor unit of
/// [currencyCode]; the type is stored by name.
@DataClassName('AccountRow')
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>
      text().withLength(min: 1, max: AccountRules.maxNameLength)();

  TextColumn get iconKey => text()();

  IntColumn get color => integer()();

  TextColumn get type => textEnum<AccountType>()();

  TextColumn get currencyCode => text().references(Currencies, #code)();

  IntColumn get openingBalance => integer()();

  TextColumn get openingDate => text().map(const LocalDateConverter())();

  BoolColumn get includeInBalance => boolean()();

  BoolColumn get isMain => boolean().withDefault(const Constant(false))();

  IntColumn get parentAccountId =>
      integer().nullable().references(Accounts, #id)();

  IntColumn get creditLimit => integer().nullable()();

  IntColumn get paymentDay => integer().nullable()();

  IntColumn get sortOrder => integer()();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}
