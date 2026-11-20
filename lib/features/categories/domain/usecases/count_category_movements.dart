import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

/// How many movements a category classifies, shown before deleting it.
class CountCategoryMovements implements UseCase<Future<Result<int>>, int> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<int>> call(int id) => _repository.countMovements(id);
}
