import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/settings_rules.dart';

void main() {
  group('SettingsRules.isValid', () {
    test('accepts the defaults and the range limits', () {
      expect(SettingsRules.isValid(const AppSettings()), isTrue);
      expect(
        SettingsRules.isValid(
          const AppSettings(
            cutoffDay: 1,
            minDaysBetweenPeriods: 60,
            reminderMinutes: 0,
            backupsToKeep: 5,
          ),
        ),
        isTrue,
      );
      expect(
        SettingsRules.isValid(
          const AppSettings(
            cutoffDay: 31,
            minDaysBetweenPeriods: 1,
            reminderMinutes: 23 * 60 + 59,
          ),
        ),
        isTrue,
      );
    });

    test('rejects values out of range', () {
      const invalid = [
        AppSettings(cutoffDay: 0),
        AppSettings(cutoffDay: 32),
        AppSettings(minDaysBetweenPeriods: 0),
        AppSettings(minDaysBetweenPeriods: 61),
        AppSettings(reminderMinutes: -1),
        AppSettings(reminderMinutes: 24 * 60),
        AppSettings(backupsToKeep: 2),
        AppSettings(backupsToKeep: 6),
      ];

      for (final settings in invalid) {
        expect(SettingsRules.isValid(settings), isFalse, reason: '$settings');
      }
    });
  });
}
