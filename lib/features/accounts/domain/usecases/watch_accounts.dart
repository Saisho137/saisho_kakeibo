import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

class WatchAccounts implements UseCase<Stream<List<Account>>, NoParams> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Stream<List<Account>> call(NoParams params) => _repository.watchAccounts();
}
