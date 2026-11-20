import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

/// Dates that start a dynamic period, oldest first.
class WatchPeriodStarts implements UseCase<Stream<List<LocalDate>>, NoParams> {
  const new(this._repository);

  final PeriodRepository _repository;

  @override
  Stream<List<LocalDate>> call(NoParams params) => _repository.watchStarts();
}
