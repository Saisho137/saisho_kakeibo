import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

/// The app's own colors stay readable in both themes (accessibility): the
/// money colors are text (4.5:1, WCAG AA) and the icon glyphs sit on the
/// palette colors (3:1 for graphics).
void main() {
  for (final theme in [AppTheme.light, AppTheme.dark]) {
    final tokens = theme.extension<AppTokens>()!;
    final scheme = theme.colorScheme;
    group('${theme.brightness.name} theme', () {
      for (final (name, color) in [
        ('income', tokens.income),
        ('expense', tokens.expense),
        ('transfer', tokens.transfer),
      ]) {
        for (final (surfaceName, surface) in [
          ('surface', scheme.surface),
          ('surfaceContainerHighest', scheme.surfaceContainerHighest),
        ]) {
          test('$name text on $surfaceName', () {
            expect(
              AppTokens.contrast(color, surface),
              greaterThanOrEqualTo(4.5),
            );
          });
        }
      }
    });
  }

  test('icon glyphs on every palette color and the neutral one', () {
    for (final tokens in [AppTokens.light, AppTokens.dark]) {
      for (final color in [...IconCatalog.palette, tokens.neutral]) {
        expect(
          AppTokens.contrast(tokens.glyphOn(color), color),
          greaterThanOrEqualTo(AppTokens.minGlyphContrast),
          reason: '$color',
        );
      }
    }
    expect(AppTokens.light.glyphOn(const Color(0xFF3949AB)), Colors.white);
    expect(
      AppTokens.light.glyphOn(const Color(0xFFFFB300)),
      AppTokens.light.iconGlyphDark,
    );
  });
}
