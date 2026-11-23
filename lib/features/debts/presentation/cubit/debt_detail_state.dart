part of 'debt_detail_cubit.dart';

enum DebtDetailStatus { loading, success, notFound, failure }

@freezed
abstract class DebtDetailState with _$DebtDetailState {
  const factory({
    @Default(DebtDetailStatus.loading) DebtDetailStatus status,
    int? debtId,

    /// Every stream's latest value; `null` until it arrives.
    List<Debt>? debts,
    List<Movement>? movements,
    List<Account>? accounts,
    List<Category>? categories,
    List<Payee>? payees,
    List<Pillar>? pillars,
    @Default(<Currency>[]) List<Currency> currencies,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _DebtDetailState;

  const new _();

  Debt? get debt => debts?.where((d) => d.id == debtId).firstOrNull;

  DebtStatus? get debtStatus {
    final debt = this.debt;
    return debt == null ? null : DebtStatus.of(debt, movements ?? const []);
  }

  Currency? get currency =>
      currencies.where((c) => c.code == debt?.currencyCode).firstOrNull;

  Payee? payeeOf(int? id) => payees?.where((p) => p.id == id).firstOrNull;

  Pillar? get pillar =>
      pillars?.where((p) => p.id == debt?.pillarId).firstOrNull;

  Category? categoryOf(Movement m) => categories?.byId(m.categoryId);

  Account? accountById(int? id) => accounts?.byId(id);

  /// A debt only goes away while nothing references it.
  bool get canDelete =>
      debt != null && !(movements ?? const []).any((m) => m.debtId == debtId);
}
