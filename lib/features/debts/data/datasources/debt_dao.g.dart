// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt_dao.dart';

// ignore_for_file: type=lint
mixin _$DebtDaoMixin on DatabaseAccessor<AppDatabase> {
  $PayeesTable get payees => attachedDatabase.payees;
  $CurrenciesTable get currencies => attachedDatabase.currencies;
  $PillarsTable get pillars => attachedDatabase.pillars;
  $DebtsTable get debts => attachedDatabase.debts;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $CategoriesTable get categories => attachedDatabase.categories;
  $RecurringTemplatesTable get recurringTemplates =>
      attachedDatabase.recurringTemplates;
  $MovementsTable get movements => attachedDatabase.movements;
  DebtDaoManager get managers => DebtDaoManager(this);
}

class DebtDaoManager {
  final _$DebtDaoMixin _db;
  DebtDaoManager(this._db);
  $$PayeesTableTableManager get payees =>
      $$PayeesTableTableManager(_db.attachedDatabase, _db.payees);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db.attachedDatabase, _db.currencies);
  $$PillarsTableTableManager get pillars =>
      $$PillarsTableTableManager(_db.attachedDatabase, _db.pillars);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$RecurringTemplatesTableTableManager get recurringTemplates =>
      $$RecurringTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.recurringTemplates,
      );
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
}
