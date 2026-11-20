import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/pillar_rules.dart';

/// Renames or recolors a pillar (RF-02).
class UpdatePillar implements UseCase<Future<Result<void>>, Pillar> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<void>> call(Pillar pillar) async {
    final loaded = await _repository.getPillars();
    if (loaded case Err(:final failure)) return Err(failure);
    final pillars = (loaded as Ok<List<Pillar>>).value;
    final original = pillars.where((p) => p.id == pillar.id).firstOrNull;
    if (original == null) {
      return Err(ValidationFailure('Unknown pillar ${pillar.id}'));
    }
    final updated = PillarRules.normalize(
      pillar.copyWith(sortOrder: original.sortOrder),
    );
    final errors = PillarRules.validate(updated, pillars: pillars);
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid pillar: $errors'));
    }
    return await _repository.savePillar(updated);
  }
}
