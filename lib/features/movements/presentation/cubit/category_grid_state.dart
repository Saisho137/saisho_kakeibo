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

  /// Payees that match the search; none until something is typed.
  List<Payee> get visiblePayees => _key.isEmpty
      ? const []
      : [
          for (final p in payees)
            if (p.key.contains(_key)) p,
        ];
}
