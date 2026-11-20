import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/settings_dao.dart';
import 'package:saisho_kakeibo/features/settings/data/models/settings_row_mapper.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const new(this._dao);

  final SettingsDao _dao;

  @override
  Stream<AppSettings> watchSettings() =>
      _dao.watch().map((row) => row.toEntity());

  @override
  Future<Result<AppSettings>> getSettings() =>
      guardDatabase(() async => (await _dao.get()).toEntity());

  @override
  Future<Result<void>> save(AppSettings settings) =>
      guardDatabase(() => _dao.write(settings.toCompanion()));
}
