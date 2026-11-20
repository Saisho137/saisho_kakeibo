import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_table.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/pillars_table.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories, Pillars, Movements])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  new(super.attachedDatabase);

  SimpleSelectStatement<$CategoriesTable, CategoryRow> _ordered() =>
      select(categories)..orderBy([
        (c) => OrderingTerm.asc(c.type),
        (c) => OrderingTerm.asc(c.sortOrder),
        (c) => OrderingTerm.asc(c.id),
      ]);

  SimpleSelectStatement<$PillarsTable, PillarRow> _orderedPillars() =>
      select(pillars)..orderBy([
        (p) => OrderingTerm.asc(p.sortOrder),
        (p) => OrderingTerm.asc(p.id),
      ]);

  Stream<List<CategoryRow>> watchAll() => _ordered().watch();

  Future<List<CategoryRow>> getAll() => _ordered().get();

  Stream<List<PillarRow>> watchPillars() => _orderedPillars().watch();

  Future<List<PillarRow>> getPillars() => _orderedPillars().get();

  Future<int> create(CategoriesCompanion category) =>
      into(categories).insert(category);

  Future<int> createPillar(PillarsCompanion pillar) =>
      into(pillars).insert(pillar);

  Future<void> save(CategoriesCompanion category) =>
      update(categories).replace(category);

  Future<void> savePillar(PillarsCompanion pillar) =>
      update(pillars).replace(pillar);

  Future<void> reorder(List<int> ids) => transaction(() async {
    for (final (index, id) in ids.indexed) {
      await (update(categories)..where((c) => c.id.equals(id))).write(
        CategoriesCompanion(sortOrder: Value(index)),
      );
    }
  });

  Future<int> countMovements(int id) async {
    final count = movements.id.count();
    final query = selectOnly(movements)
      ..addColumns([count])
      ..where(movements.categoryId.equals(id));
    final row = await query.getSingle();
    final value = row.read(count);
    return value ?? 0;
  }

  /// Moves the movements of [id] to [reassignTo], if given, then deletes
  /// the category.
  Future<void> deleteById(int id, {int? reassignTo}) => transaction(() async {
    if (reassignTo != null) {
      await (update(movements)..where((m) => m.categoryId.equals(id))).write(
        MovementsCompanion(categoryId: Value(reassignTo)),
      );
    }
    await (delete(categories)..where((c) => c.id.equals(id))).go();
  });
}
