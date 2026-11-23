// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payee_dao.dart';

// ignore_for_file: type=lint
mixin _$PayeeDaoMixin on DatabaseAccessor<AppDatabase> {
  $PayeesTable get payees => attachedDatabase.payees;
  $CurrenciesTable get currencies => attachedDatabase.currencies;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $PillarsTable get pillars => attachedDatabase.pillars;
  $CategoriesTable get categories => attachedDatabase.categories;
  $DebtsTable get debts => attachedDatabase.debts;
  $RecurringTemplatesTable get recurringTemplates =>
      attachedDatabase.recurringTemplates;
  $MovementsTable get movements => attachedDatabase.movements;
  PayeeDaoManager get managers => PayeeDaoManager(this);
}

class PayeeDaoManager {
  final _$PayeeDaoMixin _db;
  PayeeDaoManager(this._db);
  $$PayeesTableTableManager get payees =>
      $$PayeesTableTableManager(_db.attachedDatabase, _db.payees);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db.attachedDatabase, _db.currencies);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$PillarsTableTableManager get pillars =>
      $$PillarsTableTableManager(_db.attachedDatabase, _db.pillars);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db.attachedDatabase, _db.debts);
  $$RecurringTemplatesTableTableManager get recurringTemplates =>
      $$RecurringTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.recurringTemplates,
      );
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
}
