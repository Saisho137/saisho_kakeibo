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

  /// Every movement of the debt, newest first: the loan that created it
  /// too, not only its payments.
  List<Movement> get debtMovements => [
    for (final m in movements ?? const <Movement>[])
      if (m.debtId == debtId) m,
  ];

  Currency? get currency =>
      currencies.where((c) => c.code == debt?.currencyCode).firstOrNull;

  Payee? payeeOf(int? id) => payees?.where((p) => p.id == id).firstOrNull;

  Pillar? get pillar =>
      pillars?.where((p) => p.id == debt?.pillarId).firstOrNull;

  Category? categoryOf(Movement m) => categories?.byId(m.categoryId);

  Account? accountById(int? id) => accounts?.byId(id);

  /// Category of a payment of this debt: Debt payment for what I owe,
  /// Loan repaid for what I am owed (RF-09).
  Category? get paymentCategory => categories?.byRole(
    debt?.iOwe ?? true ? CategoryRole.debtPayment : CategoryRole.loanRepaid,
  );

  /// A debt only goes away while nothing references it.
  bool get canDelete =>
      debt != null && !(movements ?? const []).any((m) => m.debtId == debtId);
}
