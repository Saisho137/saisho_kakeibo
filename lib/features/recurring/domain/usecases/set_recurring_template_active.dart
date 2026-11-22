import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

final class SetRecurringTemplateActiveParams {
  const new({required this.id, required this.active});

  final int id;
  final bool active;
}

/// Pauses or resumes a template (RF-06).
class SetRecurringTemplateActive
    implements UseCase<Future<Result<void>>, SetRecurringTemplateActiveParams> {
  const new(this._repository);

  final RecurringRepository _repository;

  @override
  Future<Result<void>> call(SetRecurringTemplateActiveParams params) async {
    switch (await _repository.findTemplate(params.id)) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: null):
        return Err(ValidationFailure('Unknown template ${params.id}'));
      case Ok(value: final template?):
        return switch (await _repository.saveTemplate(
          template.copyWith(isActive: params.active),
        )) {
          Ok() => const Ok(null),
          Err(:final failure) => Err(failure),
        };
    }
  }
}
