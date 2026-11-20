import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';

/// Contract implemented by the data layer. Settings are a single row.
abstract interface class SettingsRepository {
  Stream<AppSettings> watchSettings();

  Future<Result<AppSettings>> getSettings();

  Future<Result<void>> save(AppSettings settings);
}
