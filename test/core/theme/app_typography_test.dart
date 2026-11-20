import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_typography.dart';

void main() {
  group('AppTypography', () {
    test('themes use Roboto Flex', () {
      for (final theme in [AppTheme.light, AppTheme.dark]) {
        expect(theme.textTheme.bodyMedium?.fontFamily, 'RobotoFlex');
        expect(theme.primaryTextTheme.titleLarge?.fontFamily, 'RobotoFlex');
      }
    });

    test('every style drives the weight axis from its font weight', () {
      final styles = [
        AppTheme.light.textTheme.displayLarge,
        AppTheme.light.textTheme.titleMedium,
        AppTheme.light.textTheme.labelSmall,
      ];

      for (final style in styles) {
        final weight = style!.fontWeight ?? FontWeight.normal;
        expect(style.fontVariations, [
          FontVariation('wght', weight.value.toDouble()),
        ]);
      }
    });

    test('withWeight sets both the weight and the axis', () {
      final style = const TextStyle().withWeight(FontWeight.w700);

      expect(style.fontWeight, FontWeight.w700);
      expect(style.fontVariations, [const FontVariation('wght', 700)]);
    });

    test('keeps missing styles empty', () {
      final theme = AppTypography.apply(const TextTheme());

      expect(theme.bodyMedium, isNull);
    });
  });
}
