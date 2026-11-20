import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';

/// Saves the order of a list of accounts after dragging one of them.
class ReorderAccounts implements UseCase<Future<Result<void>>, List<int>> {
  const new(this._repository);

  final AccountRepository _repository;

  @override
  Future<Result<void>> call(List<int> ids) => _repository.reorder(ids);
}
