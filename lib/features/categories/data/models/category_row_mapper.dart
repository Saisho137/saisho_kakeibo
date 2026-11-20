import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

extension CategoryRowMapper on CategoryRow {
  Category toEntity() => Category(
    id: id,
    type: type,
    role: role,
    name: name,
    iconKey: iconKey,
    color: color,
    pillarId: pillarId,
    defaultName: defaultName,
    defaultIconKey: defaultIconKey,
    sortOrder: sortOrder,
    isArchived: isArchived,
  );
}

extension CategoryCompanionMapper on Category {
  /// Row to insert: the database assigns the id.
  CategoriesCompanion toInsertCompanion() =>
      toCompanion().copyWith(id: const Value.absent());

  CategoriesCompanion toCompanion() => CategoriesCompanion(
    id: Value(id),
    type: Value(type),
    role: Value(role),
    name: Value(name),
    iconKey: Value(iconKey),
    color: Value(color),
    pillarId: Value(pillarId),
    defaultName: Value(defaultName),
    defaultIconKey: Value(defaultIconKey),
    sortOrder: Value(sortOrder),
    isArchived: Value(isArchived),
  );
}

extension PillarRowMapper on PillarRow {
  Pillar toEntity() =>
      Pillar(id: id, name: name, color: color, sortOrder: sortOrder);
}

extension PillarCompanionMapper on Pillar {
  PillarsCompanion toCompanion() => PillarsCompanion(
    id: Value(id),
    name: Value(name),
    color: Value(color),
    sortOrder: Value(sortOrder),
  );
}
