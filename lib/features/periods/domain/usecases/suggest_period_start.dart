import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

final class SuggestPeriodStartParams {
  const new({required this.date, required this.minDays});

  /// Date of the salary being entered.
  final LocalDate date;

  /// Settings → Periods: minimum days between period starts.
  final int minDays;
}

/// Whether a salary on [SuggestPeriodStartParams.date] should start a
/// period by default: when no period starts on or before that date, or N
/// days or more have passed since the latest one (RF-05).
class SuggestPeriodStart
    implements UseCase<Future<Result<bool>>, SuggestPeriodStartParams> {
  const new(this._repository);

  final PeriodRepository _repository;

  @override
  Future<Result<bool>> call(SuggestPeriodStartParams params) async {
    switch (await _repository.getStarts()) {
      case Ok(value: final starts):
        final last = starts.where((s) => !s.isAfter(params.date)).lastOrNull;
        return Ok(
          last == null || last.daysUntil(params.date) >= params.minDays,
        );
      case Err(:final failure):
        return Err(failure);
    }
  }
}
