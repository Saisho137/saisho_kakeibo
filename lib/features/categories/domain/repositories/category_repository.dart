import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

/// Contract implemented by the data layer. Business rules live in the use
/// cases; the repository only stores what they decide, atomically.
abstract interface class CategoryRepository {
  /// Every category, archived included, by type and [Category.sortOrder].
  Stream<List<Category>> watchCategories();

  /// The four pillars in display order.
  Stream<List<Pillar>> watchPillars();

  Future<Result<List<Category>>> getCategories();

  Future<Result<List<Pillar>>> getPillars();

  /// Inserts [category] and returns its id.
  Future<Result<int>> create(Category category);

  Future<Result<void>> save(Category category);

  /// Sets [Category.sortOrder] to the position of each id.
  Future<Result<void>> reorder(List<int> ids);

  Future<Result<int>> countMovements(int id);

  /// Moves the movements of [id] to [reassignTo], if given, and deletes the
  /// category, in one transaction.
  Future<Result<void>> delete(int id, {int? reassignTo});

  Future<Result<void>> savePillar(Pillar pillar);
}
