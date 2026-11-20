import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/home/domain/services/home_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_totals.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

/// The Home: the periods of the active currency with their donut and
/// totals, and the Balance (RF-02, RF-14, RF-17).
class HomeCubit extends Cubit<HomeState> {
  new({
    required this._watchSettings,
    required this._watchAccounts,
    required this._watchBalances,
    required this._watchCurrencies,
    required this._watchMovements,
    required this._watchPeriodStarts,
    required this._watchCategories,
    required this._watchPillars,
  }) : super(const HomeState());

  final WatchSettings _watchSettings;
  final WatchAccounts _watchAccounts;
  final WatchAccountBalances _watchBalances;
  final WatchCurrencies _watchCurrencies;
  final WatchMovements _watchMovements;
  final WatchPeriodStarts _watchPeriodStarts;
  final WatchCategories _watchCategories;
  final WatchPillars _watchPillars;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load() {
    unawaited(_cancel());
    emit(HomeState(today: LocalDate.today()));
    _subscriptions.addAll([
      _watchSettings(const NoParams()).listen(
        (settings) => _received(state.copyWith(settings: settings)),
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
      _watchCurrencies(const NoParams()).listen(
        (currencies) => _received(state.copyWith(currencies: currencies)),
        onError: _failed,
      ),
      _watchMovements(const NoParams()).listen(
        (movements) => _received(state.copyWith(movements: movements)),
        onError: _failed,
      ),
      _watchPeriodStarts(const NoParams()).listen(
        (starts) => _received(state.copyWith(periodStarts: starts)),
        onError: _failed,
      ),
      _watchCategories(const NoParams()).listen(
        (categories) => _received(state.copyWith(categories: categories)),
        onError: _failed,
      ),
      _watchPillars(const NoParams()).listen(
        (pillars) => _received(state.copyWith(pillars: pillars)),
        onError: _failed,
      ),
    ]);
  }

  /// Quick menu: shows the Home in [code] until the app restarts.
  void currencySelected(String code) =>
      emit(state.copyWith(selectedCurrencyCode: code));

  void _received(HomeState next) {
    final ready =
        next.settings != null &&
        next.accounts != null &&
        next.balances != null &&
        next.currencies.isNotEmpty &&
        next.movements != null &&
        next.periodStarts != null &&
        next.categories != null &&
        next.pillars != null;
    emit(ready ? next.copyWith(status: HomeStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: HomeStatus.failure,
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
