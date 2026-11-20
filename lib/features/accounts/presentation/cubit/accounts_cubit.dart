import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/services/accounts_overview.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/reorder_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

part 'accounts_cubit.freezed.dart';
part 'accounts_state.dart';

/// Accounts with their balances, for the Accounts screen and the Balance
/// section of Settings.
class AccountsCubit extends Cubit<AccountsState> {
  new({
    required this._watchAccounts,
    required this._watchBalances,
    required this._watchCurrencies,
    required this._updateAccount,
    required this._reorderAccounts,
  }) : super(const AccountsState());

  final WatchAccounts _watchAccounts;
  final WatchAccountBalances _watchBalances;
  final WatchCurrencies _watchCurrencies;
  final UpdateAccount _updateAccount;
  final ReorderAccounts _reorderAccounts;
  final List<StreamSubscription<Object>> _subscriptions = [];

  /// Starts listening. The screen shows [currencyCode] until the user picks
  /// another one.
  void load(String currencyCode) {
    unawaited(_cancel());
    emit(state.copyWith(currencyCode: currencyCode));
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
    ]);
  }

  void currencySelected(String code) =>
      emit(state.copyWith(currencyCode: code));

  void showArchivedToggled() =>
      emit(state.copyWith(showArchived: !state.showArchived));

  Future<void> setIncludeInBalance(Account account, {required bool value}) =>
      _run(() => _updateAccount(account.copyWith(includeInBalance: value)));

  /// Moves the line at [from] so it ends at [to] inside [group].
  Future<void> reorder(AccountGroup group, int from, int to) async {
    final lines = state.overview?.groups[group];
    if (lines == null) return;
    final ids = [for (final line in lines) line.account.id];
    final moved = ids.removeAt(from);
    ids.insert(to, moved);
    await _run(() => _reorderAccounts(ids));
  }

  Future<void> _run(Future<Result<void>> Function() action) async {
    if (await action() case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  // Waits for the three streams before showing the screen.
  void _received(AccountsState next) {
    final ready =
        next.accounts != null &&
        next.balances != null &&
        next.currencies.isNotEmpty;
    emit(ready ? next.copyWith(status: AccountsStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: AccountsStatus.failure,
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
