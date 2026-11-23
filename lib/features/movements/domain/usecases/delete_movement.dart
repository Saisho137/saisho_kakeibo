import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

/// Deletes a movement. Deleting the loan that created a debt, when nothing
/// else references that debt, deletes the debt too (RF-09).
class DeleteMovement implements UseCase<Future<Result<void>>, int> {
  const new(
    this._repository, {
    required this._debts,
    required this._categories,
  });

  final MovementRepository _repository;
  final DebtRepository _debts;
  final CategoryRepository _categories;

  @override
  Future<Result<void>> call(int id) async {
    final Movement? movement;
    switch (await _repository.findById(id)) {
      case Ok(:final value):
        movement = value;
      case Err(:final failure):
        return Err(failure);
    }
    final deleted = await _repository.delete(id);
    final debtId = movement?.debtId;
    if (deleted is Err || movement == null || debtId == null) return deleted;

    switch ((
      await _categories.getCategories(),
      await _debts.getMovements(debtId),
    )) {
      case (Ok(value: final categories), Ok(value: final left)):
        final role = categories.byId(movement.categoryId)?.role;
        if (role != null && DebtRules.createsDebt(role) && left.isEmpty) {
          return await _debts.deleteDebt(debtId);
        }
        return const Ok(null);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
  }
}
