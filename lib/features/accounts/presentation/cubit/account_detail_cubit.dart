import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/adjust_account_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_account_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

part 'account_detail_cubit.freezed.dart';
part 'account_detail_state.dart';

/// An account with its balance and movements, for its detail screen.
class AccountDetailCubit extends Cubit<AccountDetailState> {
  new({
    required this._watchAccounts,
    required this._watchBalances,
    required this._watchCurrencies,
    required this._watchMovements,
    required this._watchCategories,
    required this._watchPayees,
    required this._adjustBalance,
    required this._deleteMovement,
  }) : super(const AccountDetailState());

  final WatchAccounts _watchAccounts;
  final WatchAccountBalances _watchBalances;
  final WatchCurrencies _watchCurrencies;
  final WatchAccountMovements _watchMovements;
  final WatchCategories _watchCategories;
  final WatchPayees _watchPayees;
  final AdjustAccountBalance _adjustBalance;
  final DeleteMovement _deleteMovement;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load(int accountId) {
    unawaited(_cancel());
    emit(AccountDetailState(accountId: accountId));
    _subscriptions.addAll([
      _watchAccounts(const NoParams()).listen(
        (accounts) => _received(state.copyWith(accounts: accounts)),
        onError: _failed,
      ),
      _watchBalances(const NoParams()).listen(
        (balances) => _received(state.copyWith(balances: balances)),
        onError: _failed,
      ),
      _watchCurrencies(const NoParams()).listen(
        (currencies) => _received(state.copyWith(currencies: currencies)),
        onError: _failed,
      ),
      _watchMovements(accountId).listen(
        (movements) => _received(state.copyWith(movements: movements)),
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
    ]);
  }

  /// Saves the difference with the real [balance] as an adjustment today.
  Future<void> adjustBalance(int balance) async {
    final id = state.accountId;
    if (id == null) return;
    await _run(
      () => _adjustBalance(
        AdjustAccountBalanceParams(
          accountId: id,
          actualBalance: balance,
          date: LocalDate.today(),
        ),
      ),
    );
  }

  Future<void> deleteMovement(int id) => _run(() => _deleteMovement(id));

  Future<void> _run(Future<Result<void>> Function() action) async {
    if (await action() case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  void _received(AccountDetailState next) {
    final ready =
        next.accounts != null &&
        next.balances != null &&
        next.currencies.isNotEmpty &&
        next.movements != null &&
        next.categories != null &&
        next.payees != null;
    if (!ready) return emit(next);
    emit(
      next.copyWith(
        status: next.account == null
            ? AccountDetailStatus.notFound
            : AccountDetailStatus.success,
      ),
    );
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: AccountDetailStatus.failure,
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
