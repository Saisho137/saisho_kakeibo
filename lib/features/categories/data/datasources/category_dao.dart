import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_table.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/pillars_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [Categories, Pillars])
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

  /// Movements arrive in phase 4; until then no category has any.
  Future<int> countMovements(int id) async => 0;

  /// Movements move to [reassignTo] here once they exist (phase 4).
  Future<void> deleteById(int id, {int? reassignTo}) => transaction(() async {
    await (delete(categories)..where((c) => c.id.equals(id))).go();
  });
}
