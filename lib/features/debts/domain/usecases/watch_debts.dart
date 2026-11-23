import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';

class WatchDebts implements UseCase<Stream<List<Debt>>, NoParams> {
  const new(this._repository);

  final DebtRepository _repository;

  @override
  Stream<List<Debt>> call(NoParams params) => _repository.watchDebts();
}
