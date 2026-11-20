part of 'currency_form_cubit.dart';

enum CurrencyFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class CurrencyFormState with _$CurrencyFormState {
  const factory({
    @Default(CurrencyFormStatus.loading) CurrencyFormStatus status,

    /// The stored currency when editing; `null` when creating.
    Currency? original,

    /// Whether an account uses the edited currency, which cannot then be
    /// deleted.
    @Default(false) bool inUse,
    @Default('') String code,
    @Default('') String symbol,
    @Default(2) int decimals,
    @Default('.') String thousandsSeparator,
    @Default(',') String decimalSeparator,
    @Default(<CurrencyError>{}) Set<CurrencyError> errors,

    /// Errors appear after the first submit, then update while typing.
    @Default(false) bool showErrors,

    /// Last failure of a save or delete, shown once by the UI.
    Failure? failure,
  }) = _CurrencyFormState;

  const new _();

  bool get isEditing => original != null;

  /// The format being edited, for the live preview. `null` while the
  /// separators are equal.
  CurrencyFormat? get format => thousandsSeparator == decimalSeparator
      ? null
      : CurrencyFormat(
          decimals: decimals,
          thousandsSeparator: thousandsSeparator,
          decimalSeparator: decimalSeparator,
        );
}
