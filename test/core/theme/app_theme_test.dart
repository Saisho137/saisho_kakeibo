import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

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
      expect(
        mid.neutral,
        Color.lerp(AppTokens.light.neutral, AppTokens.dark.neutral, 0.5),
      );
      expect(mid.donutRingWidth, AppTokens.light.donutRingWidth);
    });

    test('lerp with null keeps the tokens', () {
      expect(AppTokens.light.lerp(null, 0.5), AppTokens.light);
    });

    test('copyWith replaces only the given tokens', () {
      final copy = AppTokens.light.copyWith(
        neutral: const Color(0xFF000000),
        pillarBorderHitWidth: 40,
      );

      expect(copy.neutral, const Color(0xFF000000));
      expect(copy.pillarBorderHitWidth, 40);
      expect(copy.income, AppTokens.light.income);
      expect(copy.donutRingWidth, AppTokens.light.donutRingWidth);
      expect(AppTokens.light.copyWith().radius, AppTokens.light.radius);
    });

    test('the pillar border hit area is wider than the border', () {
      for (final tokens in [AppTokens.light, AppTokens.dark]) {
        expect(
          tokens.pillarBorderHitWidth,
          greaterThan(tokens.pillarBorderWidth),
        );
      }
    });
  });
}
