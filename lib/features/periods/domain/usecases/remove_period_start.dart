import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

/// Undoes a manual period start: its period joins the previous one. A
/// salary on that day still starts a period.
class RemovePeriodStart implements UseCase<Future<Result<void>>, LocalDate> {
  const new(this._repository);

  final PeriodRepository _repository;

  @override
  Future<Result<void>> call(LocalDate date) => _repository.removeStart(date);
}
