part of 'categories_cubit.dart';

enum CategoriesStatus { loading, success, failure }

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory({
    @Default(CategoriesStatus.loading) CategoriesStatus status,

    /// Every category, archived included; `null` until loaded.
    List<Category>? categories,

    /// `null` until loaded.
    List<Pillar>? pillars,

    /// Last failure of an action, shown once by the UI.
    Failure? failure,
  }) = _CategoriesState;

  const new _();

  /// Active categories of [type] in their manual order.
  List<Category> active(CategoryType type) => [
    for (final c in categories ?? const <Category>[])
      if (c.type == type && !c.isArchived) c,
  ];

  List<Category> archived(CategoryType type) => [
    for (final c in categories ?? const <Category>[])
      if (c.type == type && c.isArchived) c,
  ];

  Pillar? pillarOf(Category category) => category.hasPillar
      ? pillars?.where((p) => p.id == category.pillarId).firstOrNull
      : null;
}
