import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';

/// Saves the name, icon, color and pillar of a category (RF-13). Its type
/// and role never change, and a core category keeps having no pillar of
/// its own.
class UpdateCategory implements UseCase<Future<Result<void>>, Category> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<void>> call(Category category) async {
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
    final original = categories.byId(category.id);
    if (original == null) {
      return Err(ValidationFailure('Unknown category ${category.id}'));
    }
    final updated = CategoryRules.normalize(
      category.copyWith(
        type: original.type,
        role: original.role,
        defaultName: original.defaultName,
        defaultIconKey: original.defaultIconKey,
        sortOrder: original.sortOrder,
        isArchived: original.isArchived,
      ),
    );
    final errors = CategoryRules.validate(
      updated,
      categories: categories,
      pillars: pillars,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid category: $errors'));
    }
    return await _repository.save(updated);
  }
}
