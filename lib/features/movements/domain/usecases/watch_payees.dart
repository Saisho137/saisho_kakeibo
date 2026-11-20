import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

class WatchPayees implements UseCase<Stream<List<Payee>>, NoParams> {
  const new(this._repository);

  final MovementRepository _repository;

  @override
  Stream<List<Payee>> call(NoParams params) => _repository.watchPayees();
}
