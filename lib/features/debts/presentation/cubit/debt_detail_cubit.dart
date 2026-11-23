import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/delete_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/edit_debt_pending.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

part 'debt_detail_cubit.freezed.dart';
part 'debt_detail_state.dart';

/// A debt with what is pending and its payments (RF-09).
class DebtDetailCubit extends Cubit<DebtDetailState> {
  new({
    required this._watchDebts,
    required this._watchMovements,
    required this._watchAccounts,
    required this._watchCategories,
    required this._watchPayees,
    required this._watchPillars,
    required this._watchCurrencies,
    required this._editPending,
    required this._deleteDebt,
  }) : super(const DebtDetailState());

  final WatchDebts _watchDebts;
  final WatchMovements _watchMovements;
  final WatchAccounts _watchAccounts;
  final WatchCategories _watchCategories;
  final WatchPayees _watchPayees;
  final WatchPillars _watchPillars;
  final WatchCurrencies _watchCurrencies;
  final EditDebtPending _editPending;
  final DeleteDebt _deleteDebt;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load(int id) {
    unawaited(_cancel());
    emit(DebtDetailState(debtId: id));
    _subscriptions.addAll([
      _watchDebts(const NoParams()).listen(
        (debts) => _received(state.copyWith(debts: debts)),
        onError: _failed,
      ),
      _watchMovements(const NoParams()).listen(
        (movements) => _received(state.copyWith(movements: movements)),
        onError: _failed,
      ),
      _watchAccounts(const NoParams()).listen(
        (accounts) => _received(state.copyWith(accounts: accounts)),
        onError: _failed,
      ),
      _watchCategories(const NoParams()).listen(
        (categories) => _received(state.copyWith(categories: categories)),
        onError: _failed,
      ),
      _watchPayees(const NoParams()).listen(
        (payees) => _received(state.copyWith(payees: payees)),
        onError: _failed,
      ),
      _watchPillars(const NoParams()).listen(
        (pillars) => _received(state.copyWith(pillars: pillars)),
        onError: _failed,
      ),
      _watchCurrencies(const NoParams()).listen(
        (currencies) => _received(state.copyWith(currencies: currencies)),
        onError: _failed,
      ),
    ]);
  }

  /// Sets what is really pending, moving no money.
  Future<void> editPending(int pending) async {
    final id = state.debtId;
    if (id == null) return;
    final result = await _editPending(
      EditDebtPendingParams(id: id, pending: pending),
    );
    if (result case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  Future<void> delete() async {
    final id = state.debtId;
    if (id == null) return;
    if (await _deleteDebt(id) case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  void _received(DebtDetailState next) {
    final ready =
        next.debts != null &&
        next.movements != null &&
        next.accounts != null &&
        next.categories != null &&
        next.payees != null &&
        next.pillars != null &&
        next.currencies.isNotEmpty;
    if (!ready) return emit(next);
    emit(
      next.copyWith(
        status: next.debt == null
            ? DebtDetailStatus.notFound
            : DebtDetailStatus.success,
      ),
    );
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: DebtDetailStatus.failure,
      failure: UnexpectedFailure(error.toString()),
    ),
  );

  Future<void> _cancel() async {
    final subscriptions = [..._subscriptions];
    _subscriptions.clear();
    await Future.wait(subscriptions.map((s) => s.cancel()));
  }

  @override
  Future<void> close() async {
    await _cancel();
    await super.close();
  }
}
