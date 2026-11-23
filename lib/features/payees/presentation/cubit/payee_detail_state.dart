part of 'payee_detail_cubit.dart';

enum PayeeDetailStatus { loading, success, notFound, failure }

@freezed
abstract class PayeeDetailState with _$PayeeDetailState {
  const factory({
    @Default(PayeeDetailStatus.loading) PayeeDetailStatus status,
    int? payeeId,
    LocalDate? today,

    /// Every stream's latest value; `null` until it arrives.
    List<Payee>? payees,
    List<Movement>? movements,
    List<Account>? accounts,
    List<Category>? categories,
    List<Debt>? debts,
    List<LocalDate>? periodStarts,
    @Default(<Currency>[]) List<Currency> currencies,
    AppSettings? settings,

    /// Currency picked on the screen; that of the latest movement until
    /// then.
    String? selectedCurrencyCode,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _PayeeDetailState;

  const new _();

  Payee? get payee => payees?.where((p) => p.id == payeeId).firstOrNull;

  /// The entity's movements, newest first.
  List<Movement> get _all =>
      [
        for (final m in movements ?? const <Movement>[])
          if (m.payeeId == payeeId) m,
      ]..sort((a, b) {
        final byDate = b.date.compareTo(a.date);
        return byDate != 0 ? byDate : b.id.compareTo(a.id);
      });

  String? _codeOf(Movement m) => accounts?.byId(m.accountId)?.currencyCode;

  String? get currencyCode =>
      selectedCurrencyCode ??
      _all.map(_codeOf).nonNulls.firstOrNull ??
      settings?.mainCurrencyCode;

  Currency? get currency =>
      currencies.where((c) => c.code == currencyCode).firstOrNull;

  /// Currencies the entity has movements in, plus the shown one.
  List<Currency> get currencyOptions {
    final codes = {?currencyCode, ..._all.map(_codeOf).nonNulls};
    return [
      for (final c in currencies)
        if (codes.contains(c.code)) c,
    ];
  }

  /// Movements in the shown currency, newest first.
  List<Movement> get payeeMovements => [
    for (final m in _all)
      if (_codeOf(m) == currencyCode) m,
  ];

  /// Today's period in the Home's view.
  Period? get period {
    final settings = this.settings;
    final today = this.today;
    if (settings == null || today == null) return null;
    return PeriodCalculator(
      type: settings.periodType,
      cutoffDay: settings.cutoffDay,
      starts: periodStarts ?? const [],
    ).periodOf(today);
  }

  PayeeStats get allTime => PayeeStats.of(payeeMovements);

  PayeeStats get thisPeriod => PayeeStats.of([
    for (final m in payeeMovements)
      if (period?.contains(m.date) ?? false) m,
  ]);

  /// The debt that is this entity (RF-09), which keeps it from being
  /// deleted.
  Debt? get debt => debts?.where((d) => d.payeeId == payeeId).firstOrNull;

  /// Other entities to merge into, by name.
  List<Payee> get mergeTargets => [
    for (final p in payees ?? const <Payee>[])
      if (p.id != payeeId) p,
  ]..sort((a, b) => a.key.compareTo(b.key));

  /// Whether another entity already has the name [key]; renaming to it
  /// asks for a merge instead.
  bool nameTaken(String key) =>
      (payees ?? const <Payee>[]).any((p) => p.key == key && p.id != payeeId);

  Category? categoryOf(Movement m) => categories?.byId(m.categoryId);

  Account? accountById(int? id) => accounts?.byId(id);
}
