import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';

/// Creates a custom category, last in its type (RF-13). Core categories
/// only come with the app.
class CreateCategory implements UseCase<Future<Result<int>>, Category> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<int>> call(Category category) async {
    final List<Category> categories;
    final List<Pillar> pillars;
    switch ((
      await _repository.getCategories(),
      await _repository.getPillars(),
    )) {
      case (Ok(value: final c), Ok(value: final p)):
        (categories, pillars) = (c, p);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
    final created = CategoryRules.normalize(
      category.copyWith(
        role: CategoryRole.custom,
        defaultName: null,
        defaultIconKey: null,
        isArchived: false,
        sortOrder: categories.nextSortOrder(category.type),
      ),
    );
    final errors = CategoryRules.validate(
      created,
      categories: categories,
      pillars: pillars,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid category: $errors'));
    }
    return await _repository.create(created);
  }
}
