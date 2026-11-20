import 'package:drift/drift.dart';

/// Currencies and their format (RF-16). Accounts and amounts reference the
/// [code], which never changes.
@DataClassName('CurrencyRow')
class Currencies extends Table {
  TextColumn get code => text().withLength(min: 3, max: 3)();

  TextColumn get symbol => text().withLength(min: 1, max: 4)();

  /// Fixed at creation: it defines the minor unit of every stored amount.
  IntColumn get decimals => integer()();

  TextColumn get thousandsSeparator => text().withLength(max: 1)();

  TextColumn get decimalSeparator => text().withLength(min: 1, max: 1)();

  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {code};
}
