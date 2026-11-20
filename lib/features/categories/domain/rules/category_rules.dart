import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

/// A field of the category form that does not pass the rules.
enum CategoryError { emptyName, nameTooLong, duplicateName, missingPillar }

/// Rules of a category (RF-13, RT-12).
abstract final class CategoryRules {
  static const int maxNameLength = 30;

  /// Display-normalizes the name and clears the pillar of every category
  /// that does not take it from itself.
  static Category normalize(Category category) => category.copyWith(
    name: TextNormalizer.display(category.name),
    pillarId: category.hasPillar ? category.pillarId : null,
  );

  /// Errors of a normalized [category] among the stored [categories]. Names
  /// are unique inside a type, archived categories included.
  static Set<CategoryError> validate(
    Category category, {
    required Iterable<Category> categories,
    required Iterable<Pillar> pillars,
  }) {
    final errors = <CategoryError>{};
    final name = category.name.trim();
    if (name.isEmpty) errors.add(CategoryError.emptyName);
    if (name.length > maxNameLength) errors.add(CategoryError.nameTooLong);
    final key = TextNormalizer.key(name);
    if (categories.any(
      (c) =>
          c.id != category.id &&
          c.type == category.type &&
          TextNormalizer.key(c.name) == key,
    )) {
      errors.add(CategoryError.duplicateName);
    }
    if (category.hasPillar && !pillars.any((p) => p.id == category.pillarId)) {
      errors.add(CategoryError.missingPillar);
    }
    return errors;
  }

  /// Category that receives the movements of a deleted one by default:
  /// Uncategorized for expenses and Between accounts for transfers. Incomes
  /// have none: the user picks the target.
  static CategoryRole? defaultTargetRole(CategoryType type) => switch (type) {
    CategoryType.expense => CategoryRole.uncategorized,
    CategoryType.transfer => CategoryRole.betweenAccounts,
    CategoryType.income => null,
  };

  /// Whether [target] can receive the movements of [deleted]: an active
  /// category of the same type.
  static bool canReceive(Category target, {required Category deleted}) =>
      target.type == deleted.type &&
      target.id != deleted.id &&
      !target.isArchived;
}
