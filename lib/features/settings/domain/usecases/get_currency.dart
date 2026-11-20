import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';

/// The currency with the given code, or `null` if there is none.
class GetCurrency implements UseCase<Future<Result<Currency?>>, String> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Future<Result<Currency?>> call(String code) => _repository.findByCode(code);
}
