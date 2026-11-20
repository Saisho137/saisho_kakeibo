import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/data/repositories/settings_repository_impl.dart';

void main() {
  late AppDatabase db;
  late SettingsRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = SettingsRepositoryImpl(db.settingsDao);
  });

  tearDown(() => db.close());

  group('SettingsRepositoryImpl', () {
    test('reads the seeded settings', () async {
      final result = await repository.getSettings();

      expect((result as Ok<AppSettings>).value, const AppSettings());
    });

    test('saves every field and keeps a single row', () async {
      const changed = AppSettings(
        mainCurrencyCode: 'USD',
        periodType: PeriodType.yearly,
        cutoffDay: 31,
        minDaysBetweenPeriods: 10,
        notificationsEnabled: false,
        reminderMinutes: 21 * 60 + 30,
        themeMode: AppThemeMode.dark,
        balanceFilter: BalanceFilter.cash,
        backupsToKeep: 5,
      );

      await repository.save(changed);

      expect(await repository.watchSettings().first, changed);
      final rows = await db.select(db.settingsTable).get();
      expect(rows, hasLength(1));
    });

    test('watchSettings emits each change', () async {
      final emitted = repository.watchSettings().take(2).toList();

      await pumpEventQueue();
      await repository.save(const AppSettings(cutoffDay: 1));

      expect((await emitted).map((s) => s.cutoffDay), [27, 1]);
    });

    test('rejects a main currency that does not exist', () async {
      final result = await repository.save(
        const AppSettings(mainCurrencyCode: 'XYZ'),
      );

      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });
}
