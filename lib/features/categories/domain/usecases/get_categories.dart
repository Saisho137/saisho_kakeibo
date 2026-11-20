import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

/// Every category once, archived included, by type and order.
class GetCategories
    implements UseCase<Future<Result<List<Category>>>, NoParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<List<Category>>> call(NoParams params) =>
      _repository.getCategories();
}
