import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';

/// Every currency once, built-in first.
class GetCurrencies
    implements UseCase<Future<Result<List<Currency>>>, NoParams> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Future<Result<List<Currency>>> call(NoParams params) =>
      _repository.getCurrencies();
}
