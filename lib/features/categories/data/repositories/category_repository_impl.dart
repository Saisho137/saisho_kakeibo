import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/category_dao.dart';
import 'package:saisho_kakeibo/features/categories/data/models/category_row_mapper.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const new(this._dao);

  final CategoryDao _dao;

  @override
  Stream<List<Category>> watchCategories() => _dao.watchAll().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Stream<List<Pillar>> watchPillars() => _dao.watchPillars().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<List<Category>>> getCategories() => guardDatabase(
    () async => (await _dao.getAll()).map((row) => row.toEntity()).toList(),
  );

  @override
  Future<Result<List<Pillar>>> getPillars() => guardDatabase(
    () async => (await _dao.getPillars()).map((row) => row.toEntity()).toList(),
  );

  @override
  Future<Result<int>> create(Category category) =>
      guardDatabase(() => _dao.create(category.toInsertCompanion()));

  @override
  Future<Result<void>> save(Category category) =>
      guardDatabase(() => _dao.save(category.toCompanion()));

  @override
  Future<Result<void>> reorder(List<int> ids) =>
      guardDatabase(() => _dao.reorder(ids));

  @override
  Future<Result<int>> countMovements(int id) =>
      guardDatabase(() => _dao.countMovements(id));

  @override
  Future<Result<void>> delete(int id, {int? reassignTo}) =>
      guardDatabase(() => _dao.deleteById(id, reassignTo: reassignTo));

  @override
  Future<Result<void>> savePillar(Pillar pillar) =>
      guardDatabase(() => _dao.savePillar(pillar.toCompanion()));
}
