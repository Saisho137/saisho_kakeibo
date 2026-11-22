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
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/set_recurring_template_active.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

part 'recurring_cubit.freezed.dart';
part 'recurring_state.dart';

/// The Recurring screen: every template, with a switch to pause it.
class RecurringCubit extends Cubit<RecurringState> {
  new({
    required this._watchTemplates,
    required this._watchAccounts,
    required this._watchCategories,
    required this._watchPayees,
    required this._watchCurrencies,
    required this._setActive,
  }) : super(const RecurringState());

  final WatchRecurringTemplates _watchTemplates;
  final WatchAccounts _watchAccounts;
  final WatchCategories _watchCategories;
  final WatchPayees _watchPayees;
  final WatchCurrencies _watchCurrencies;
  final SetRecurringTemplateActive _setActive;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load() {
    unawaited(_cancel());
    emit(const RecurringState());
    _subscriptions.addAll([
      _watchTemplates(const NoParams()).listen(
        (templates) => _received(state.copyWith(templates: templates)),
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
      _watchCurrencies(const NoParams()).listen(
        (currencies) => _received(state.copyWith(currencies: currencies)),
        onError: _failed,
      ),
    ]);
  }

  Future<void> setActive(int id, {required bool value}) async {
    final result = await _setActive(
      SetRecurringTemplateActiveParams(id: id, active: value),
    );
    if (result case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  void _received(RecurringState next) {
    final ready =
        next.templates != null &&
        next.accounts != null &&
        next.categories != null &&
        next.payees != null &&
        next.currencies.isNotEmpty;
    emit(ready ? next.copyWith(status: RecurringStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: RecurringStatus.failure,
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
