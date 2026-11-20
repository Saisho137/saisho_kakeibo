import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';

/// Creates a user currency. Its decimals can never change afterwards.
class CreateCurrency implements UseCase<Future<Result<void>>, Currency> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Future<Result<void>> call(Currency currency) async {
    final existing = await _repository.findByCode(currency.code);
    if (existing case Err(:final failure)) return Err(failure);
    final errors = CurrencyRules.validate(
      code: currency.code,
      symbol: currency.symbol,
      decimals: currency.format.decimals,
      thousandsSeparator: currency.format.thousandsSeparator,
      decimalSeparator: currency.format.decimalSeparator,
      existingCodes: [if (existing case Ok(value: final found?)) found.code],
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid currency: $errors'));
    }
    return await _repository.create(
      currency.copyWith(symbol: currency.symbol.trim(), isBuiltIn: false),
    );
  }
}
