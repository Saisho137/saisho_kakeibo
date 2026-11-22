import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

class GetRecurringTemplate
    implements UseCase<Future<Result<RecurringTemplate?>>, int> {
  const new(this._repository);

  final RecurringRepository _repository;

  @override
  Future<Result<RecurringTemplate?>> call(int id) =>
      _repository.findTemplate(id);
}
