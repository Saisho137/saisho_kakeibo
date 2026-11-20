import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:material_ui/material_ui.dart' show Color;
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/icons/color_variants.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/count_category_movements.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/create_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/delete_category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_pillars.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/set_category_archived.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_category.dart';

part 'category_form_cubit.freezed.dart';
part 'category_form_state.dart';

/// Creates a custom category or edits any category.
class CategoryFormCubit extends Cubit<CategoryFormState> {
  new({
    required this._getCategories,
    required this._getPillars,
    required this._countMovements,
    required this._createCategory,
    required this._updateCategory,
    required this._setArchived,
    required this._deleteCategory,
  }) : super(const CategoryFormState());

  /// Icon of a new category until the user picks one.
  static const String newIconKey = 'label';

  final GetCategories _getCategories;
  final GetPillars _getPillars;
  final CountCategoryMovements _countMovements;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final SetCategoryArchived _setArchived;
  final DeleteCategory _deleteCategory;

  /// Starts a new category of [type], or loads [id] to edit it.
  Future<void> load({CategoryType type = CategoryType.expense, int? id}) async {
    final List<Category> categories;
    final List<Pillar> pillars;
    switch ((
      await _getCategories(const NoParams()),
      await _getPillars(const NoParams()),
    )) {
      case (Ok(value: final c), Ok(value: final p)):
        (categories, pillars) = (c, p);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        emit(
          state.copyWith(status: CategoryFormStatus.notFound, failure: failure),
        );
        return;
    }

    final loaded = state.copyWith(categories: categories, pillars: pillars);
    if (id == null) {
      emit(
        _withIcon(
          loaded.copyWith(status: CategoryFormStatus.editing, type: type),
          newIconKey,
        ),
      );
      return;
    }
    final category = categories.byId(id);
    if (category == null) {
      emit(loaded.copyWith(status: CategoryFormStatus.notFound));
      return;
    }
    final counted = await _countMovements(id);
    emit(
      loaded.copyWith(
        status: CategoryFormStatus.editing,
        original: category,
        movementCount: counted is Ok<int> ? counted.value : 0,
        type: category.type,
        name: category.name,
        iconKey: category.iconKey,
        color: category.color,
        pillarId: category.pillarId,
      ),
    );
  }

  /// Only a new category changes type. Its color is suggested again among
  /// the categories of the new type.
  void typeChanged(CategoryType type) {
    if (state.isEditing || type == state.type) return;
    _change(_withIcon(state.copyWith(type: type), state.iconKey));
  }

  void nameChanged(String name) => _change(state.copyWith(name: name));

  /// Picking an icon assigns its suggested color, or a close free variant.
  void iconChanged(String key) => _change(_withIcon(state, key));

  void colorChanged(int color) => _change(state.copyWith(color: color));

  void pillarChanged(int id) => _change(state.copyWith(pillarId: id));

  /// Restores the default name, icon and color of a core category. Saving
  /// keeps the change.
  void resetToDefault() {
    final original = state.original;
    final name = original?.defaultName;
    final iconKey = original?.defaultIconKey;
    if (name == null || iconKey == null) return;
    _change(
      _withIcon(state.copyWith(name: name, resets: state.resets + 1), iconKey),
    );
  }

  /// Validates and saves. Field errors are shown only after the first try.
  Future<void> submit() async {
    final (category, errors) = _read(state);
    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: CategoryFormStatus.saving, errors: {}));
    final result = state.isEditing
        ? await _updateCategory(category)
        : await _createCategory(category);
    _finish(result, CategoryFormStatus.saved);
  }

  Future<void> setArchived({required bool archived}) async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: CategoryFormStatus.saving));
    _finish(
      await _setArchived(SetCategoryArchivedParams(id: id, archived: archived)),
      CategoryFormStatus.saved,
    );
  }

  /// Deletes the category, moving its movements to [reassignTo].
  Future<void> delete({int? reassignTo}) async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: CategoryFormStatus.saving));
    _finish(
      await _deleteCategory(
        DeleteCategoryParams(id: id, reassignTo: reassignTo),
      ),
      CategoryFormStatus.deleted,
    );
  }

  void _finish(Result<void> result, CategoryFormStatus done) =>
      emit(switch (result) {
        Ok() => state.copyWith(status: done),
        Err(:final failure) => state.copyWith(
          status: CategoryFormStatus.editing,
          failure: failure,
        ),
      });

  void _change(CategoryFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  static CategoryFormState _withIcon(CategoryFormState form, String key) =>
      form.copyWith(iconKey: key, color: form.suggestedColor(key));

  /// The category the form describes, normalized, and its errors.
  static (Category, Set<CategoryError>) _read(CategoryFormState form) {
    final category = CategoryRules.normalize(
      (form.original ??
              Category(name: '', iconKey: '', color: 0, type: form.type))
          .copyWith(
            name: form.name,
            iconKey: form.iconKey,
            color: form.color,
            pillarId: form.pillarId,
          ),
    );
    return (
      category,
      CategoryRules.validate(
        category,
        categories: form.categories,
        pillars: form.pillars,
      ),
    );
  }
}
