import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

part 'debts_cubit.freezed.dart';
part 'debts_state.dart';

/// The Debts screen (RF-09): debts of one currency with what is pending,
/// and the credit cards, read only.
class DebtsCubit extends Cubit<DebtsState> {
  new({
    required this._watchDebts,
    required this._watchMovements,
    required this._watchAccounts,
    required this._watchBalances,
    required this._watchPayees,
    required this._watchPillars,
    required this._watchCurrencies,
    required this._watchSettings,
  }) : super(const DebtsState());

  final WatchDebts _watchDebts;
  final WatchMovements _watchMovements;
  final WatchAccounts _watchAccounts;
  final WatchAccountBalances _watchBalances;
  final WatchPayees _watchPayees;
  final WatchPillars _watchPillars;
  final WatchCurrencies _watchCurrencies;
  final WatchSettings _watchSettings;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load() {
    unawaited(_cancel());
    emit(const DebtsState());
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
      _watchBalances(const NoParams()).listen(
        (balances) => _received(state.copyWith(balances: balances)),
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
      _watchSettings(const NoParams()).listen(
        (settings) => _received(state.copyWith(settings: settings)),
        onError: _failed,
      ),
    ]);
  }

  void currencySelected(String code) =>
      emit(state.copyWith(selectedCurrencyCode: code));

  void _received(DebtsState next) {
    final ready =
        next.debts != null &&
        next.movements != null &&
        next.accounts != null &&
        next.balances != null &&
        next.payees != null &&
        next.pillars != null &&
        next.currencies.isNotEmpty &&
        next.settings != null;
    emit(ready ? next.copyWith(status: DebtsStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: DebtsStatus.failure,
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
