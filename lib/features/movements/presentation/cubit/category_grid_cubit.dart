import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payee_suggestions.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

part 'category_grid_cubit.freezed.dart';
part 'category_grid_state.dart';

/// The categories of a type in their manual order, the payees used with
/// that type and the open debts it pays or collects, for the first step of
/// the quick entry (RF-01, RF-09).
class CategoryGridCubit extends Cubit<CategoryGridState> {
  new({
    required this._getCategories,
    required this._getPayeeSuggestions,
    required this._getDebts,
  }) : super(const CategoryGridState());

  final GetCategories _getCategories;
  final GetPayeeSuggestions _getPayeeSuggestions;
  final GetDebtStatuses _getDebts;

  Future<void> load(MovementType type) async {
    switch ((
      await _getCategories(const NoParams()),
      await _getPayeeSuggestions(type),
      await _getDebts(const NoParams()),
    )) {
      case (
        Ok(value: final categories),
        Ok(value: final payees),
        Ok(value: final debts),
      ):
        final income = type == MovementType.income;
        final categoryType = income
            ? CategoryType.income
            : CategoryType.expense;
        final debtType = income ? DebtType.owedToMe : DebtType.iOwe;
        emit(
          state.copyWith(
            status: CategoryGridStatus.success,
            type: type,
            categories: [
              for (final c in categories)
                if (c.type == categoryType && !c.isArchived) c,
            ],
            payees: payees,
            debts: [
              for (final (:debt, :status) in debts)
                if (debt.type == debtType && !status.isPaidOff) debt,
            ],
            paymentCategory: categories.byRole(
              income ? CategoryRole.loanRepaid : CategoryRole.debtPayment,
            ),
          ),
        );
      case (Err(:final failure), _, _) ||
          (_, Err(:final failure), _) ||
          (_, _, Err(:final failure)):
        emit(
          state.copyWith(status: CategoryGridStatus.failure, failure: failure),
        );
    }
  }

  void queryChanged(String query) => emit(state.copyWith(query: query));
}
