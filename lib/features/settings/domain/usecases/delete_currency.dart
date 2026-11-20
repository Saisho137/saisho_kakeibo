import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

/// Deletes a user currency (RF-16). Built-in currencies and the main
/// currency cannot be deleted.
class DeleteCurrency implements UseCase<Future<Result<void>>, String> {
  const new(this._currencies, this._settings);

  final CurrencyRepository _currencies;
  final SettingsRepository _settings;

  @override
  Future<Result<void>> call(String code) async {
    final found = await _currencies.findByCode(code);
    if (found case Err(:final failure)) return Err(failure);
    if (found case Ok(value: final currency?) when currency.isBuiltIn) {
      return const Err(ValidationFailure('Built-in currencies stay.'));
    }
    final settings = await _settings.getSettings();
    if (settings case Err(:final failure)) return Err(failure);
    if (settings case Ok(:final value) when value.mainCurrencyCode == code) {
      return const Err(ValidationFailure('The main currency stays.'));
    }
    return await _currencies.delete(code);
  }
}
