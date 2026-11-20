part of 'period_starts_cubit.dart';

/// Outcome of "Start new period now", shown once by the UI.
enum PeriodStartNotice { started, alreadyStarted }

@freezed
abstract class PeriodStartsState with _$PeriodStartsState {
  const factory({
    /// Newest first.
    @Default(<LocalDate>[]) List<LocalDate> manualStarts,
    PeriodStartNotice? notice,

    /// Grows with every notice, so a repeated one is shown again.
    @Default(0) int notices,

    /// Last failure, shown once by the UI.
    Failure? failure,
  }) = _PeriodStartsState;
}
