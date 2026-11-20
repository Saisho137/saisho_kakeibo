import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/transfer_rules.dart';

final class SuggestTransferCategoryParams {
  const new({required this.from, required this.to});

  final Account from;
  final Account to;
}

/// Category prefilled in a transfer (RF-13): the last one used between the
/// same two accounts, else the rule by account types, else Between
/// accounts. Archived categories are skipped.
class SuggestTransferCategory
    implements UseCase<Future<Result<int?>>, SuggestTransferCategoryParams> {
  const new({required this._movements, required this._categories});

  final MovementRepository _movements;
  final CategoryRepository _categories;

  @override
  Future<Result<int?>> call(SuggestTransferCategoryParams params) async {
    final List<Category> categories;
    switch (await _categories.getCategories()) {
      case Ok(:final value):
        categories = value
            .where((c) => c.type == CategoryType.transfer && !c.isArchived)
            .toList();
      case Err(:final failure):
        return Err(failure);
    }
    final last = await _movements.lastTransfer(params.from.id, params.to.id);
    if (last case Err(:final failure)) return Err(failure);
    final used = categories.byId((last as Ok<Movement?>).value?.categoryId);
    final suggested =
        used ??
        categories.byRole(
          TransferRules.suggestedRole(params.from, params.to),
        ) ??
        categories.byRole(CategoryRole.betweenAccounts);
    return Ok(suggested?.id);
  }
}
