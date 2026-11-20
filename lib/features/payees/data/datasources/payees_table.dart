import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

/// Payees, called entities in the app (RF-08). [key] is unique (RT-08).
@DataClassName('PayeeRow')
class Payees extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>
      text().withLength(min: 1, max: PayeeRules.maxNameLength)();

  TextColumn get key => text().unique()();
}
