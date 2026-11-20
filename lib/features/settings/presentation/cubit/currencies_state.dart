part of 'currencies_cubit.dart';

enum CurrenciesStatus { loading, success, failure }

@freezed
abstract class CurrenciesState with _$CurrenciesState {
  const factory({
    @Default(CurrenciesStatus.loading) CurrenciesStatus status,
    @Default(<Currency>[]) List<Currency> currencies,
    Failure? failure,
  }) = _CurrenciesState;
}
