import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/settings_rules.dart';

/// Saves the settings after checking their ranges.
class UpdateSettings implements UseCase<Future<Result<void>>, AppSettings> {
  const new(this._repository);

  final SettingsRepository _repository;

  @override
  Future<Result<void>> call(AppSettings settings) async {
    if (!SettingsRules.isValid(settings)) {
      return const Err(ValidationFailure('Settings out of range.'));
    }
    return await _repository.save(settings);
  }
}
