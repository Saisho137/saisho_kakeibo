import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/create_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/delete_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_currency.dart';

part 'currency_form_cubit.freezed.dart';
part 'currency_form_state.dart';

/// Creates a currency or edits the symbol and separators of an existing one.
class CurrencyFormCubit extends Cubit<CurrencyFormState> {
  new({
    required this._getCurrency,
    required this._createCurrency,
    required this._updateCurrency,
    required this._deleteCurrency,
  }) : super(const CurrencyFormState());

  final GetCurrency _getCurrency;
  final CreateCurrency _createCurrency;
  final UpdateCurrency _updateCurrency;
  final DeleteCurrency _deleteCurrency;

  /// Starts a new currency, or loads [code] to edit it.
  Future<void> load(String? code) async {
    if (code == null) {
      emit(state.copyWith(status: CurrencyFormStatus.editing));
      return;
    }
    switch (await _getCurrency(code)) {
      case Ok(value: final currency?):
        emit(
          state.copyWith(
            status: CurrencyFormStatus.editing,
            original: currency,
            code: currency.code,
            symbol: currency.symbol,
            decimals: currency.format.decimals,
            thousandsSeparator: currency.format.thousandsSeparator,
            decimalSeparator: currency.format.decimalSeparator,
          ),
        );
      case Ok():
        emit(state.copyWith(status: CurrencyFormStatus.notFound));
      case Err(:final failure):
        emit(
          state.copyWith(status: CurrencyFormStatus.notFound, failure: failure),
        );
    }
  }

  void codeChanged(String code) =>
      _change(state.copyWith(code: code.trim().toUpperCase()));

  void symbolChanged(String symbol) => _change(state.copyWith(symbol: symbol));

  void decimalsChanged(int decimals) {
    if (state.isEditing) return;
    _change(state.copyWith(decimals: decimals));
  }

  void thousandsSeparatorChanged(String separator) =>
      _change(state.copyWith(thousandsSeparator: separator));

  void decimalSeparatorChanged(String separator) =>
      _change(state.copyWith(decimalSeparator: separator));

  /// Validates and saves. Field errors are shown only after the first try.
  Future<void> submit() async {
    final errors = _validate(state);
    if (!state.isEditing && errors.isEmpty) {
      final existing = await _getCurrency(state.code);
      if (existing case Ok(value: _?)) errors.add(CurrencyError.duplicateCode);
    }
    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: CurrencyFormStatus.saving, errors: {}));
    final result = state.isEditing
        ? await _updateCurrency(
            UpdateCurrencyParams(
              code: state.code,
              symbol: state.symbol,
              thousandsSeparator: state.thousandsSeparator,
              decimalSeparator: state.decimalSeparator,
            ),
          )
        : await _createCurrency(
            Currency(
              code: state.code,
              symbol: state.symbol,
              format: CurrencyFormat(
                decimals: state.decimals,
                thousandsSeparator: state.thousandsSeparator,
                decimalSeparator: state.decimalSeparator,
              ),
            ),
          );
    _finish(result, CurrencyFormStatus.saved);
  }

  Future<void> delete() async {
    emit(state.copyWith(status: CurrencyFormStatus.saving));
    _finish(await _deleteCurrency(state.code), CurrencyFormStatus.deleted);
  }

  void _finish(Result<void> result, CurrencyFormStatus done) =>
      emit(switch (result) {
        Ok() => state.copyWith(status: done),
        Err(:final failure) => state.copyWith(
          status: CurrencyFormStatus.editing,
          failure: failure,
        ),
      });

  void _change(CurrencyFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _validate(next) : const {}));

  Set<CurrencyError> _validate(CurrencyFormState form) =>
      CurrencyRules.validate(
        code: form.code,
        symbol: form.symbol,
        decimals: form.decimals,
        thousandsSeparator: form.thousandsSeparator,
        decimalSeparator: form.decimalSeparator,
      );
}
