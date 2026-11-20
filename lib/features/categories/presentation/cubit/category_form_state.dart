part of 'category_form_cubit.dart';

enum CategoryFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class CategoryFormState with _$CategoryFormState {
  const factory({
    @Default(CategoryFormStatus.loading) CategoryFormStatus status,

    /// The stored category when editing; `null` when creating.
    Category? original,

    /// Movements of the edited category, shown before deleting it.
    @Default(0) int movementCount,

    /// Every category, for unique names, colors and delete targets.
    @Default(<Category>[]) List<Category> categories,
    @Default(<Pillar>[]) List<Pillar> pillars,
    @Default(CategoryType.expense) CategoryType type,
    @Default('') String name,
    @Default('') String iconKey,
    @Default(0) int color,
    int? pillarId,
    @Default(<CategoryError>{}) Set<CategoryError> errors,

    /// Times the form was reset to default, so text fields refill.
    @Default(0) int resets,

    /// Errors appear after the first submit, then update while typing.
    @Default(false) bool showErrors,

    /// Last failure of a save, archive or delete, shown once by the UI.
    Failure? failure,
  }) = _CategoryFormState;

  const new _();

  bool get isEditing => original != null;

  bool get isCore => original?.isCore ?? false;

  CategoryRole get role => original?.role ?? CategoryRole.custom;

  /// Whether the form shows the pillar picker: custom expenses only.
  bool get hasPillar => type == CategoryType.expense && !isCore;

  bool get canArchive => isEditing && !isCore;

  bool get canDelete => isEditing && !isCore;

  /// Color of [iconKey] for this category: the icon's suggested color, or
  /// the closest one no other active category of the type uses (RF-13).
  int suggestedColor(String iconKey) => ColorVariants.closestFree(
    IconCatalog.resolve(iconKey).color,
    categories.colorsInUse(type, exceptId: original?.id).map(Color.new),
  ).toARGB32();

  /// Whether a core category differs from its default name, icon or color.
  bool get canReset {
    final original = this.original;
    final defaultName = original?.defaultName;
    final defaultIconKey = original?.defaultIconKey;
    if (defaultName == null || defaultIconKey == null) return false;
    return name != defaultName ||
        iconKey != defaultIconKey ||
        color != suggestedColor(defaultIconKey);
  }

  /// Categories that can receive the movements of the edited one.
  List<Category> get deleteTargets {
    final original = this.original;
    if (original == null) return const [];
    return [
      for (final c in categories)
        if (CategoryRules.canReceive(c, deleted: original)) c,
    ];
  }

  /// Target picked by default: Uncategorized or Between accounts. Incomes
  /// have none.
  Category? get defaultDeleteTarget =>
      switch (CategoryRules.defaultTargetRole(type)) {
        final role? => deleteTargets.where((c) => c.role == role).firstOrNull,
        null => null,
      };
}
