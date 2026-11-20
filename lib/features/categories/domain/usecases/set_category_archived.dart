import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';

final class SetCategoryArchivedParams {
  const new({required this.id, required this.archived});

  final int id;
  final bool archived;
}

/// Archives a custom category, taking it out of the quick entry grid while
/// its history stays, or restores it (RF-13). Core categories are never
/// archived.
class SetCategoryArchived
    implements UseCase<Future<Result<void>>, SetCategoryArchivedParams> {
  const new(this._repository);

  final CategoryRepository _repository;

  @override
  Future<Result<void>> call(SetCategoryArchivedParams params) async {
    final loaded = await _repository.getCategories();
    if (loaded case Err(:final failure)) return Err(failure);
    final category = (loaded as Ok<List<Category>>).value.byId(params.id);
    if (category == null) {
      return Err(ValidationFailure('Unknown category ${params.id}'));
    }
    if (category.isCore) {
      return const Err(ValidationFailure('Core categories stay active.'));
    }
    return await _repository.save(
      category.copyWith(isArchived: params.archived),
    );
  }
}
