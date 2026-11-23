import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/services/payee_stats.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

part 'payees_cubit.freezed.dart';
part 'payees_state.dart';

/// The Entities screen (RF-08): what each entity adds up to in one
/// currency, in the current period or ever.
class PayeesCubit extends Cubit<PayeesState> {
  new({
    required this._watchPayees,
    required this._watchMovements,
    required this._watchAccounts,
    required this._watchCategories,
    required this._watchPeriodStarts,
    required this._watchCurrencies,
    required this._watchSettings,
  }) : super(const PayeesState());

  final WatchPayees _watchPayees;
  final WatchMovements _watchMovements;
  final WatchAccounts _watchAccounts;
  final WatchCategories _watchCategories;
  final WatchPeriodStarts _watchPeriodStarts;
  final WatchCurrencies _watchCurrencies;
  final WatchSettings _watchSettings;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load() {
    unawaited(_cancel());
    emit(PayeesState(today: LocalDate.today()));
    _subscriptions.addAll([
      _watchPayees(const NoParams()).listen(
        (payees) => _received(state.copyWith(payees: payees)),
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
      _watchPeriodStarts(const NoParams()).listen(
        (starts) => _received(state.copyWith(periodStarts: starts)),
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

  void scopeChanged(PayeeScope scope) => emit(state.copyWith(scope: scope));

  void sortChanged(PayeeSort sort) => emit(state.copyWith(sort: sort));

  void queryChanged(String query) => emit(state.copyWith(query: query));

  void _received(PayeesState next) {
    final ready =
        next.payees != null &&
        next.movements != null &&
        next.accounts != null &&
        next.categories != null &&
        next.periodStarts != null &&
        next.currencies.isNotEmpty &&
        next.settings != null;
    emit(ready ? next.copyWith(status: PayeesStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: PayeesStatus.failure,
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
