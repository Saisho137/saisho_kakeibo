import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_table.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';

/// Incomes, expenses, transfers and adjustments (RT-04). Amounts are in the
/// minor unit of their account's currency. Debts (phase 8) and recurring
/// templates (phase 7) get their foreign keys when their tables exist.
@DataClassName('MovementRow')
@TableIndex(name: 'movements_account', columns: {#accountId})
@TableIndex(name: 'movements_to_account', columns: {#toAccountId})
@TableIndex(name: 'movements_category', columns: {#categoryId})
@TableIndex(name: 'movements_date', columns: {#date})
class Movements extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get type => textEnum<MovementType>()();

  TextColumn get date => text().map(const LocalDateConverter())();

  IntColumn get accountId => integer().references(Accounts, #id)();

  IntColumn get amount => integer()();

  IntColumn get toAccountId => integer().nullable().references(Accounts, #id)();

  IntColumn get toAmount => integer().nullable()();

  IntColumn get categoryId =>
      integer().nullable().references(Categories, #id)();

  IntColumn get payeeId => integer().nullable().references(Payees, #id)();

  TextColumn get note =>
      text().withLength(max: MovementRules.maxNoteLength).nullable()();

  IntColumn get debtId => integer().nullable()();

  IntColumn get recurringTemplateId => integer().nullable()();

  BoolColumn get isPending => boolean().withDefault(const Constant(false))();

  BoolColumn get startsPeriod => boolean().withDefault(const Constant(false))();
}
