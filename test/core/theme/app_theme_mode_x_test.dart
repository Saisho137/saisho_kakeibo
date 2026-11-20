import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/theme/app_theme_mode_x.dart';

void main() {
  test('maps every AppThemeMode to its ThemeMode', () {
    expect(AppThemeMode.system.themeMode, ThemeMode.system);
    expect(AppThemeMode.light.themeMode, ThemeMode.light);
    expect(AppThemeMode.dark.themeMode, ThemeMode.dark);
  });
}
