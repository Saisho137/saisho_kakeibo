import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/pillars_table.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';

/// Debts I owe and debts owed to me (RF-09). Amounts are in the minor unit
/// of [currencyCode].
@DataClassName('DebtRow')
class Debts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get type => textEnum<DebtType>()();

  TextColumn get name =>
      text().withLength(min: 1, max: DebtRules.maxNameLength)();

  TextColumn get iconKey => text()();

  IntColumn get color => integer()();

  IntColumn get payeeId => integer().references(Payees, #id)();

  TextColumn get currencyCode => text().references(Currencies, #code)();

  IntColumn get initialPending => integer()();

  IntColumn get adjustment => integer().withDefault(const Constant(0))();

  IntColumn get pillarId => integer().nullable().references(Pillars, #id)();

  IntColumn get installment => integer().nullable()();

  IntColumn get dueDay => integer().nullable()();

  TextColumn get dueDate => text().map(const LocalDateConverter()).nullable()();

  TextColumn get createdOn => text().map(const LocalDateConverter())();
}
