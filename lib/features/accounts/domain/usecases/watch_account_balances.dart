import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

/// Own balance of each account by id, in minor units.
class WatchAccountBalances implements UseCase<Stream<Map<int, int>>, NoParams> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Stream<Map<int, int>> call(NoParams params) => _repository.watchBalances();
}
