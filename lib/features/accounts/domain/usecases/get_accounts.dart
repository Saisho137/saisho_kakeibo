import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

/// Every account once, archived included, by order.
class GetAccounts implements UseCase<Future<Result<List<Account>>>, NoParams> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<List<Account>>> call(NoParams params) =>
      _repository.getAccounts();
}
