import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/remove_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/start_period_now.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_manual_period_starts.dart';

part 'period_starts_cubit.freezed.dart';
part 'period_starts_state.dart';

/// Settings → Periods → Advanced: manual period starts (RF-05).
class PeriodStartsCubit extends Cubit<PeriodStartsState> {
  new({
    required this._watchManualStarts,
    required this._startPeriodNow,
    required this._removeStart,
  }) : super(const PeriodStartsState());

  final WatchManualPeriodStarts _watchManualStarts;
  final StartPeriodNow _startPeriodNow;
  final RemovePeriodStart _removeStart;
  StreamSubscription<List<LocalDate>>? _subscription;

  void load() {
    unawaited(_subscription?.cancel());
    _subscription = _watchManualStarts(const NoParams()).listen(
      (starts) => emit(state.copyWith(manualStarts: starts)),
      onError: (Object error) =>
          emit(state.copyWith(failure: UnexpectedFailure(error.toString()))),
    );
  }

  /// Starts a period today, unless one already starts today.
  Future<void> startNow() async {
    emit(switch (await _startPeriodNow(LocalDate.today())) {
      Ok(:final value) => state.copyWith(
        notice: value
            ? PeriodStartNotice.started
            : PeriodStartNotice.alreadyStarted,
        notices: state.notices + 1,
      ),
      Err(:final failure) => state.copyWith(failure: failure),
    });
  }

  Future<void> remove(LocalDate date) async {
    if (await _removeStart(date) case Err(:final failure)) {
      emit(state.copyWith(failure: failure));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
