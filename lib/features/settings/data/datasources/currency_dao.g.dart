// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dao.dart';

// ignore_for_file: type=lint
mixin _$CurrencyDaoMixin on DatabaseAccessor<AppDatabase> {
  $CurrenciesTable get currencies => attachedDatabase.currencies;
  $AccountsTable get accounts => attachedDatabase.accounts;
  CurrencyDaoManager get managers => CurrencyDaoManager(this);
}

class CurrencyDaoManager {
  final _$CurrencyDaoMixin _db;
  CurrencyDaoManager(this._db);
  $$CurrenciesTableTableManager get currencies =>
      $$CurrenciesTableTableManager(_db.attachedDatabase, _db.currencies);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
}
