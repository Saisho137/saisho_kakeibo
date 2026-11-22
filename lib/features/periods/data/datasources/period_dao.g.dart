// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_dao.dart';

// ignore_for_file: type=lint
mixin _$PeriodDaoMixin on DatabaseAccessor<AppDatabase> {
  $PeriodStartsTable get periodStarts => attachedDatabase.periodStarts;
  $CurrenciesTable get currencies => attachedDatabase.currencies;
  $AccountsTable get accounts => attachedDatabase.accounts;
  $PillarsTable get pillars => attachedDatabase.pillars;
  $CategoriesTable get categories => attachedDatabase.categories;
  $PayeesTable get payees => attachedDatabase.payees;
  $RecurringTemplatesTable get recurringTemplates =>
      attachedDatabase.recurringTemplates;
  $MovementsTable get movements => attachedDatabase.movements;
  PeriodDaoManager get managers => PeriodDaoManager(this);
}

class PeriodDaoManager {
  final _$PeriodDaoMixin _db;
  PeriodDaoManager(this._db);
  $$PeriodStartsTableTableManager get periodStarts =>
      $$PeriodStartsTableTableManager(_db.attachedDatabase, _db.periodStarts);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db.attachedDatabase, _db.currencies);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$PillarsTableTableManager get pillars =>
      $$PillarsTableTableManager(_db.attachedDatabase, _db.pillars);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db.attachedDatabase, _db.categories);
  $$PayeesTableTableManager get payees =>
      $$PayeesTableTableManager(_db.attachedDatabase, _db.payees);
  $$RecurringTemplatesTableTableManager get recurringTemplates =>
      $$RecurringTemplatesTableTableManager(
        _db.attachedDatabase,
        _db.recurringTemplates,
      );
  $$MovementsTableTableManager get movements =>
      $$MovementsTableTableManager(_db.attachedDatabase, _db.movements);
}
