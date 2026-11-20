import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

const Pillar survival = Pillar(id: 1, name: 'Survival', color: 0xFF1E88E5);
const Pillar leisure = Pillar(
  id: 2,
  name: 'Leisure',
  color: 0xFFD81B60,
  sortOrder: 1,
);
const List<Pillar> pillars = [survival, leisure];

/// A category with sensible defaults for tests: a custom expense in
/// Survival unless said otherwise.
Category category({
  required int id,
  CategoryType type = CategoryType.expense,
  CategoryRole role = CategoryRole.custom,
  String? name,
  String iconKey = 'label',
  int color = 0xFF3949AB,
  int? pillarId,
  int sortOrder = 0,
  bool isArchived = false,
}) {
  final hasPillar = type == CategoryType.expense && !role.isCore;
  return Category(
    id: id,
    type: type,
    role: role,
    name: name ?? 'Category $id',
    iconKey: iconKey,
    color: color,
    pillarId: hasPillar ? pillarId ?? survival.id : null,
    defaultName: role.isCore ? name ?? 'Category $id' : null,
    defaultIconKey: role.isCore ? iconKey : null,
    sortOrder: sortOrder,
    isArchived: isArchived,
  );
}
