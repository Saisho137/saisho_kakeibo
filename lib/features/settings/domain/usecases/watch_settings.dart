import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

class WatchSettings implements UseCase<Stream<AppSettings>, NoParams> {
  const new(this._repository);

  final SettingsRepository _repository;

  @override
  Stream<AppSettings> call(NoParams params) => _repository.watchSettings();
}
