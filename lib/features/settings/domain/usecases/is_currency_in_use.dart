import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';

/// Whether any account uses the currency, which blocks deleting it.
class IsCurrencyInUse implements UseCase<Future<Result<bool>>, String> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Future<Result<bool>> call(String code) => _repository.isInUse(code);
}
