import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/services/payee_stats.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/delete_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/merge_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/rename_payee.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

part 'payee_detail_cubit.freezed.dart';
part 'payee_detail_state.dart';

/// An entity's totals, prices and movements, with *Rename*, *Merge into…*
/// and *Delete* (RF-08).
class PayeeDetailCubit extends Cubit<PayeeDetailState> {
  new({
    required this._watchPayees,
    required this._watchMovements,
    required this._watchAccounts,
    required this._watchCategories,
    required this._watchDebts,
    required this._watchPeriodStarts,
    required this._watchCurrencies,
    required this._watchSettings,
    required this._rename,
    required this._merge,
    required this._delete,
  }) : super(const PayeeDetailState());

  final WatchPayees _watchPayees;
  final WatchMovements _watchMovements;
  final WatchAccounts _watchAccounts;
  final WatchCategories _watchCategories;
  final WatchDebts _watchDebts;
  final WatchPeriodStarts _watchPeriodStarts;
  final WatchCurrencies _watchCurrencies;
  final WatchSettings _watchSettings;
  final RenamePayee _rename;
  final MergePayee _merge;
  final DeletePayee _delete;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load(int id) {
    unawaited(_cancel());
    emit(PayeeDetailState(payeeId: id, today: LocalDate.today()));
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
      _watchDebts(const NoParams()).listen(
        (debts) => _received(state.copyWith(debts: debts)),
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

  Future<void> rename(String name) async {
    final id = state.payeeId;
    if (id == null) return;
    _report(await _rename(RenamePayeeParams(id: id, name: name)));
  }

  Future<void> mergeInto(int into) async {
    final id = state.payeeId;
    if (id == null) return;
    _report(await _merge(MergePayeeParams(from: id, into: into)));
  }

  Future<void> delete() async {
    final id = state.payeeId;
    if (id == null) return;
    _report(await _delete(id));
  }

  void _report(Result<void> result) {
    if (result case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  void _received(PayeeDetailState next) {
    final ready =
        next.payees != null &&
        next.movements != null &&
        next.accounts != null &&
        next.categories != null &&
        next.debts != null &&
        next.periodStarts != null &&
        next.currencies.isNotEmpty &&
        next.settings != null;
    if (!ready) return emit(next);
    emit(
      next.copyWith(
        status: next.payee == null
            ? PayeeDetailStatus.notFound
            : PayeeDetailStatus.success,
      ),
    );
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: PayeeDetailStatus.failure,
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
