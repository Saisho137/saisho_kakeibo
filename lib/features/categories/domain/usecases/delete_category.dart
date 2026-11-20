import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';

final class DeleteCategoryParams {
  const new({required this.id, this.reassignTo});

  final int id;

  /// Category that receives the movements; required if there are any.
  final int? reassignTo;
}

/// Deletes a custom category, moving its movements to another category of
/// the same type first, so deleting also merges (RF-13). Core categories
/// are never deleted.
class DeleteCategory
    implements UseCase<Future<Result<void>>, DeleteCategoryParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<void>> call(DeleteCategoryParams params) async {
    final loaded = await _repository.getCategories();
    if (loaded case Err(:final failure)) return Err(failure);
    final categories = (loaded as Ok<List<Category>>).value;
    final category = categories.byId(params.id);
    if (category == null) {
      return Err(ValidationFailure('Unknown category ${params.id}'));
    }
    if (category.isCore) {
      return const Err(ValidationFailure('Core categories stay.'));
    }
    final counted = await _repository.countMovements(params.id);
    if (counted case Err(:final failure)) return Err(failure);
    final hasMovements = (counted as Ok<int>).value > 0;
    final target = categories.byId(params.reassignTo);
    if (hasMovements &&
        (target == null ||
            !CategoryRules.canReceive(target, deleted: category))) {
      return const Err(ValidationFailure('Pick where the movements go.'));
    }
    return await _repository.delete(
      params.id,
      reassignTo: hasMovements ? target?.id : null,
    );
  }
}
