import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

part 'currencies_cubit.freezed.dart';
part 'currencies_state.dart';

/// Currencies listed in Settings and in the main currency picker.
class CurrenciesCubit extends Cubit<CurrenciesState> {
  new({required this._watchCurrencies}) : super(const CurrenciesState());

  final WatchCurrencies _watchCurrencies;
  StreamSubscription<List<Currency>>? _subscription;

  void load() {
    unawaited(_subscription?.cancel());
    _subscription = _watchCurrencies(const NoParams()).listen(
      (currencies) => emit(
        state.copyWith(
          status: CurrenciesStatus.success,
          currencies: currencies,
        ),
      ),
      onError: (Object error) => emit(
        state.copyWith(
          status: CurrenciesStatus.failure,
          failure: UnexpectedFailure(error.toString()),
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
