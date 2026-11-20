import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

/// Manual period starts, newest first, so a mistaken one can be undone.
class WatchManualPeriodStarts
    implements UseCase<Stream<List<LocalDate>>, NoParams> {
  const new(this._repository);

  final PeriodRepository _repository;

  @override
  Stream<List<LocalDate>> call(NoParams params) =>
      _repository.watchManualStarts();
}
