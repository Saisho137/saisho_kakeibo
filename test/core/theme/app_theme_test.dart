import 'package:flutter_archetype/core/theme/app_theme.dart';
import 'package:flutter_archetype/core/theme/app_tokens.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  group('AppTheme', () {
    test('light and dark expose their design tokens', () {
      expect(AppTheme.light.extension<AppTokens>(), AppTokens.light);
      expect(AppTheme.dark.extension<AppTokens>(), AppTokens.dark);
    });

    test('dark theme uses dark brightness', () {
      expect(AppTheme.dark.colorScheme.brightness, Brightness.dark);
    });
  });

  group('AppTokens', () {
    test('lerp interpolates between light and dark', () {
      final mid = AppTokens.light.lerp(AppTokens.dark, 0.5);

      expect(
        mid.income,
        Color.lerp(AppTokens.light.income, AppTokens.dark.income, 0.5),
      );
    });
  });
}
