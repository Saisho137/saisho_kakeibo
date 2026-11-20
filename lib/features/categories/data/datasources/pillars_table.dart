import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/pillar_rules.dart';

/// The four Kakeibo pillars (RF-02).
@DataClassName('PillarRow')
class Pillars extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name =>
      text().withLength(min: 1, max: PillarRules.maxNameLength)();

  IntColumn get color => integer()();

  IntColumn get sortOrder => integer()();
}
