part of 'category_grid_cubit.dart';

enum CategoryGridStatus { loading, success, failure }

@freezed
abstract class CategoryGridState with _$CategoryGridState {
  const factory({
    @Default(CategoryGridStatus.loading) CategoryGridStatus status,
    @Default(MovementType.expense) MovementType type,

    /// Active categories of the type, in the order of the grid.
    @Default(<Category>[]) List<Category> categories,

    /// Payees used with the type.
    @Default(<Payee>[]) List<Payee> payees,

    /// Open debts the type pays (I owe) or collects (owed to me).
    @Default(<Debt>[]) List<Debt> debts,

    /// Debt payment or Loan repaid, which a found debt opens.
    Category? paymentCategory,
    @Default('') String query,
    Failure? failure,
  }) = _CategoryGridState;

  const new _();

  String get _key => TextNormalizer.key(query);

  /// Categories whose name matches the search, in grid order.
  List<Category> get visibleCategories => _key.isEmpty
      ? categories
      : [
          for (final c in categories)
            if (TextNormalizer.key(c.name).contains(_key)) c,
        ];

  /// Open debts whose name matches the search; none until something is
  /// typed, nor without the category that pays them.
  List<Debt> get visibleDebts => _key.isEmpty || paymentCategory == null
      ? const []
      : [
          for (final d in debts)
            if (TextNormalizer.key(d.name).contains(_key)) d,
        ];

  /// Payees that match the search, but the debts' own; none until something
  /// is typed.
  List<Payee> get visiblePayees {
    if (_key.isEmpty) return const [];
    final ofDebts = {for (final d in visibleDebts) d.payeeId};
    return [
      for (final p in payees)
        if (p.key.contains(_key) && !ofDebts.contains(p.id)) p,
    ];
  }
}
