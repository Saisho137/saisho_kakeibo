import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/reorder_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/update_pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';

part 'categories_cubit.freezed.dart';
part 'categories_state.dart';

/// Categories by type and the pillars, for the Categories screen.
class CategoriesCubit extends Cubit<CategoriesState> {
  new({
    required this._watchCategories,
    required this._watchPillars,
    required this._reorderCategories,
    required this._updatePillar,
  }) : super(const CategoriesState());

  final WatchCategories _watchCategories;
  final WatchPillars _watchPillars;
  final ReorderCategories _reorderCategories;
  final UpdatePillar _updatePillar;
  final List<StreamSubscription<Object>> _subscriptions = [];

  void load() {
    unawaited(_cancel());
    _subscriptions.addAll([
      _watchCategories(const NoParams()).listen(
        (categories) => _received(state.copyWith(categories: categories)),
        onError: _failed,
      ),
      _watchPillars(const NoParams()).listen(
        (pillars) => _received(state.copyWith(pillars: pillars)),
        onError: _failed,
      ),
    ]);
  }

  /// Moves the active category at [from] so it ends at [to] inside [type].
  /// Archived categories keep their place.
  Future<void> reorder(CategoryType type, int from, int to) async {
    final ids = [for (final c in state.active(type)) c.id];
    if (from < 0 || from >= ids.length) return;
    final moved = ids.removeAt(from);
    ids.insert(to.clamp(0, ids.length), moved);
    final archived = [for (final c in state.archived(type)) c.id];
    await _run(() => _reorderCategories([...ids, ...archived]));
  }

  Future<void> updatePillar(Pillar pillar) => _run(() => _updatePillar(pillar));

  Future<void> _run(Future<Result<void>> Function() action) async {
    if (await action() case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  // Waits for both streams before showing the screen.
  void _received(CategoriesState next) {
    final ready = next.categories != null && next.pillars != null;
    emit(ready ? next.copyWith(status: CategoriesStatus.success) : next);
  }

  void _failed(Object error) => emit(
    state.copyWith(
      status: CategoriesStatus.failure,
      failure: UnexpectedFailure(error.toString()),
    ),
  );

  Future<void> _cancel() async {
    final subscriptions = [..._subscriptions];
    _subscriptions.clear();
    await Future.wait(subscriptions.map((s) => s.cancel()));
  }

  @override
  Future<void> close() async {
    await _cancel();
    await super.close();
  }
}
