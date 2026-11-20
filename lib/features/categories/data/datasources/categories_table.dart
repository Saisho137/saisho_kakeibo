import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/pillars_table.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';

/// Income, expense and transfer categories (RT-12). Type and role are
/// stored by name.
@DataClassName('CategoryRow')
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get type => textEnum<CategoryType>()();

  TextColumn get role => textEnum<CategoryRole>()();

  TextColumn get name =>
      text().withLength(min: 1, max: CategoryRules.maxNameLength)();

  TextColumn get iconKey => text()();

  IntColumn get color => integer()();

  IntColumn get pillarId => integer().nullable().references(Pillars, #id)();

  TextColumn get defaultName => text().nullable()();

  TextColumn get defaultIconKey => text().nullable()();

  IntColumn get sortOrder => integer()();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}
