import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

/// Deletes a template. The movements it created stay as they are.
class DeleteRecurringTemplate implements UseCase<Future<Result<void>>, int> {
  const new(this._repository);

  final RecurringRepository _repository;

  @override
  Future<Result<void>> call(int id) => _repository.deleteTemplate(id);
}
