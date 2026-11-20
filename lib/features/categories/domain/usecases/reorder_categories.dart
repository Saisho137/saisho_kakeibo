import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

/// Saves the order of the categories of a type after dragging one of them.
/// It is the order of the quick entry grid (RF-13).
class ReorderCategories implements UseCase<Future<Result<void>>, List<int>> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<void>> call(List<int> ids) => _repository.reorder(ids);
}
