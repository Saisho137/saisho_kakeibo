import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';

extension CategoriesX on Iterable<Category> {
  Category? byId(int? id) =>
      id == null ? null : where((c) => c.id == id).firstOrNull;

  Category? byRole(CategoryRole role) =>
      role.isCore ? where((c) => c.role == role).firstOrNull : null;

  Iterable<Category> ofType(CategoryType type) => where((c) => c.type == type);

  /// Colors of the active categories of [type] other than [exceptId], which
  /// a new color should avoid (RF-13).
  Iterable<int> colorsInUse(CategoryType type, {int? exceptId}) => [
    for (final c in ofType(type))
      if (!c.isArchived && c.id != exceptId) c.color,
  ];

  /// The [Category.sortOrder] that puts a new category last in [type].
  int nextSortOrder(CategoryType type) =>
      ofType(type).fold(-1, (max, c) => c.sortOrder > max ? c.sortOrder : max) +
      1;
}
