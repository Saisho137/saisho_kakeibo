import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

class WatchRecurringTemplates
    implements UseCase<Stream<List<RecurringTemplate>>, NoParams> {
  const new(this._repository);

  final RecurringRepository _repository;

  @override
  Stream<List<RecurringTemplate>> call(NoParams params) =>
      _repository.watchTemplates();
}
