import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';

class WatchCurrencies implements UseCase<Stream<List<Currency>>, NoParams> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Stream<List<Currency>> call(NoParams params) => _repository.watchCurrencies();
}
