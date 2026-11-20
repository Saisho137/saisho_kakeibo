import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';

extension AppThemeModeX on AppThemeMode {
  ThemeMode get themeMode => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}
