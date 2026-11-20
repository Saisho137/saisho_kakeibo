import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';

final class SuggestPeriodStartParams {
  const new({required this.date, required this.minDays});

  /// Date of the salary being entered.
  final LocalDate date;

  /// Settings → Periods: minimum days between period starts.
  final int minDays;
}

/// Whether a salary on [SuggestPeriodStartParams.date] should start a
/// period by default: when there is none yet, or N days or more have
/// passed since the last start (RF-05).
class SuggestPeriodStart
    implements UseCase<Future<Result<bool>>, SuggestPeriodStartParams> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Future<Result<bool>> call(SuggestPeriodStartParams params) async =>
      switch (await _repository.lastPeriodStart()) {
        Ok(value: final last) => Ok(
          last == null || last.daysUntil(params.date) >= params.minDays,
        ),
        Err(:final failure) => Err(failure),
      };
}
