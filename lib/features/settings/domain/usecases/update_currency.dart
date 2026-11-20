import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';

/// Fields of a currency that can change after it is created.
final class UpdateCurrencyParams {
  const new({
    required this.code,
    required this.symbol,
    required this.thousandsSeparator,
    required this.decimalSeparator,
  });

  final String code;
  final String symbol;
  final String thousandsSeparator;
  final String decimalSeparator;
}

/// Edits the symbol and separators. Code and decimals are immutable.
class UpdateCurrency
    implements UseCase<Future<Result<void>>, UpdateCurrencyParams> {
  const new(this._repository);

  final CurrencyRepository _repository;

  @override
  Future<Result<void>> call(UpdateCurrencyParams params) async {
    final found = await _repository.findByCode(params.code);
    if (found case Err(:final failure)) return Err(failure);
    final currency = (found as Ok<Currency?>).value;
    if (currency == null) {
      return Err(ValidationFailure('Unknown currency ${params.code}'));
    }
    final errors = CurrencyRules.validate(
      code: currency.code,
      symbol: params.symbol,
      decimals: currency.format.decimals,
      thousandsSeparator: params.thousandsSeparator,
      decimalSeparator: params.decimalSeparator,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid currency: $errors'));
    }
    return await _repository.update(
      currency.copyWith(
        symbol: params.symbol.trim(),
        format: CurrencyFormat(
          decimals: currency.format.decimals,
          thousandsSeparator: params.thousandsSeparator,
          decimalSeparator: params.decimalSeparator,
        ),
      ),
    );
  }
}
