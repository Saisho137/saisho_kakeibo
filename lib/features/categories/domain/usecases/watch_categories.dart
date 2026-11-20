import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

class WatchCategories implements UseCase<Stream<List<Category>>, NoParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Stream<List<Category>> call(NoParams params) => _repository.watchCategories();
}
