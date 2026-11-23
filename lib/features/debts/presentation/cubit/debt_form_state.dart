part of 'debt_form_cubit.dart';

enum DebtFormStatus { loading, editing, saving, saved, notFound }

@freezed
abstract class DebtFormState with _$DebtFormState {
  const factory({
    @Default(DebtFormStatus.loading) DebtFormStatus status,

    /// The stored debt when editing; `null` when creating.
    Debt? original,
    @Default(DebtType.iOwe) DebtType type,
    @Default('') String name,
    @Default('') String iconKey,
    @Default(0) int color,
    @Default('') String currencyCode,

    /// A debt with movements keeps its currency.
    @Default(false) bool currencyLocked,

    /// The pending amount when it was registered.
    @Default('') String pendingText,
    int? pillarId,
    @Default('') String installmentText,
    int? dueDay,
    LocalDate? dueDate,
    @Default(<Pillar>[]) List<Pillar> pillars,
    @Default(<Currency>[]) List<Currency> currencies,
    @Default(<DebtError>{}) Set<DebtError> errors,
    @Default(false) bool showErrors,

    /// Last failure of a save, shown once by the UI.
    Failure? failure,
  }) = _DebtFormState;

  const new _();

  bool get isEditing => original != null;

  bool get iOwe => type == DebtType.iOwe;

  CurrencyFormat get format =>
      currencies.where((c) => c.code == currencyCode).firstOrNull?.format ??
      CurrencyFormat.cop;
}
