import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';

/// A field of the pillar dialog that does not pass the rules.
enum PillarError { emptyName, nameTooLong, duplicateName, duplicateColor }

/// Rules of a pillar (RF-02): each one keeps its own name and color, so it
/// is recognized at a glance.
abstract final class PillarRules {
  static const int maxNameLength = 20;

  static Pillar normalize(Pillar pillar) =>
      pillar.copyWith(name: TextNormalizer.display(pillar.name));

  static Set<PillarError> validate(
    Pillar pillar, {
    required Iterable<Pillar> pillars,
  }) {
    final errors = <PillarError>{};
    final name = pillar.name.trim();
    if (name.isEmpty) errors.add(PillarError.emptyName);
    if (name.length > maxNameLength) errors.add(PillarError.nameTooLong);
    final others = pillars.where((p) => p.id != pillar.id);
    final key = TextNormalizer.key(name);
    if (others.any((p) => TextNormalizer.key(p.name) == key)) {
      errors.add(PillarError.duplicateName);
    }
    if (others.any((p) => p.color == pillar.color)) {
      errors.add(PillarError.duplicateColor);
    }
    return errors;
  }
}
