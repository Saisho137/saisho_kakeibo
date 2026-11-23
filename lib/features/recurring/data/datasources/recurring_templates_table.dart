import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_table.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debts_table.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

/// Fixed incomes, expenses and transfers (RF-06). Deleting an account
/// deletes its templates, which could no longer create anything.
@DataClassName('RecurringTemplateRow')
class RecurringTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get type => textEnum<MovementType>()();

  TextColumn get cadence => textEnum<RecurringCadence>()();

  IntColumn get categoryId => integer().references(Categories, #id)();

  IntColumn get accountId =>
      integer().references(Accounts, #id, onDelete: KeyAction.cascade)();

  IntColumn get toAccountId => integer().nullable().references(
    Accounts,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get amount => integer()();

  IntColumn get toAmount => integer().nullable()();

  IntColumn get payeeId => integer().nullable().references(Payees, #id)();

  TextColumn get note =>
      text().withLength(max: MovementRules.maxNoteLength).nullable()();

  IntColumn get dueDay => integer().nullable()();

  BoolColumn get remind => boolean().withDefault(const Constant(false))();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  TextColumn get createdOn => text().map(const LocalDateConverter())();

  /// The debt it pays; a debt can only go away without movements, and its
  /// templates go with it.
  IntColumn get debtId => integer().nullable().references(
    Debts,
    #id,
    onDelete: KeyAction.cascade,
  )();
}
