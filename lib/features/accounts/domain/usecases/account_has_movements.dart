import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

/// Whether the account has movements, which locks its currency and blocks
/// deleting it (RF-15).
class AccountHasMovements implements UseCase<Future<Result<bool>>, int> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<bool>> call(int id) => _repository.hasMovements(id);
}
