import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

/// Settings → Periods → Advanced: starts a dynamic period on [LocalDate]
/// (today), to correct a period that no salary started (RF-05). Returns
/// `false` when a period already starts that day.
class StartPeriodNow implements UseCase<Future<Result<bool>>, LocalDate> {
  const new(this._repository);

  final PeriodRepository _repository;

  @override
  Future<Result<bool>> call(LocalDate date) async {
    switch (await _repository.getStarts()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: final starts) when starts.contains(date):
        return const Ok(false);
      case Ok():
        return switch (await _repository.addStart(date)) {
          Ok() => const Ok(true),
          Err(:final failure) => Err(failure),
        };
    }
  }
}
