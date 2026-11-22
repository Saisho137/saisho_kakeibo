part of 'recurring_cubit.dart';

enum RecurringStatus { loading, success, failure }

@freezed
abstract class RecurringState with _$RecurringState {
  const factory({
    @Default(RecurringStatus.loading) RecurringStatus status,

    /// Every stream's latest value; `null` until it arrives.
    List<RecurringTemplate>? templates,
    List<Account>? accounts,
    List<Category>? categories,
    List<Payee>? payees,
    @Default(<Currency>[]) List<Currency> currencies,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _RecurringState;

  const new _();

  Account? accountOf(int? id) => accounts?.byId(id);

  Category? categoryOf(RecurringTemplate template) =>
      categories?.byId(template.categoryId);

  Payee? payeeOf(RecurringTemplate template) =>
      payees?.where((p) => p.id == template.payeeId).firstOrNull;

  Currency? currencyOf(RecurringTemplate template) {
    final code = accountOf(template.accountId)?.currencyCode;
    return currencies.where((c) => c.code == code).firstOrNull;
  }
}
