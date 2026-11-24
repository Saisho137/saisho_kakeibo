import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

/// The app's own colors stay readable in both themes (accessibility): the
/// money colors are text (4.5:1, WCAG AA) and the icon glyphs sit on the
/// palette colors (3:1 for graphics). The ink on the brand bars is text.
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

      test('the Expense, Transfer and Income rings', () {
        for (final color in [
          tokens.incomeAccent,
          tokens.expenseAccent,
          tokens.transfer,
        ]) {
          expect(
            AppTokens.contrast(color, scheme.surface),
            greaterThanOrEqualTo(AppTokens.minGlyphContrast),
            reason: '$color',
          );
        }
      });

      test('line icons and their text in any palette color', () {
        for (final color in IconCatalog.palette) {
          expect(
            AppTokens.contrast(
              AppTokens.readable(color, on: scheme.surface),
              scheme.surface,
            ),
            greaterThanOrEqualTo(AppTokens.minGlyphContrast),
          );
          expect(
            AppTokens.contrast(
              AppTokens.readable(
                color,
                on: scheme.surface,
                min: AppTokens.minTextContrast,
              ),
              scheme.surface,
            ),
            greaterThanOrEqualTo(AppTokens.minTextContrast),
          );
        }
      });

      test('ink on the brand color', () {
        expect(
          AppTokens.contrast(tokens.onBrand, tokens.brand),
          greaterThanOrEqualTo(4.5),
        );
      });

      test('Material primary reads as text on the surface', () {
        expect(
          AppTokens.contrast(scheme.primary, scheme.surface),
          greaterThanOrEqualTo(4.5),
        );
      });
    });
  }

  test('readable ends on any surface, mid-gray ones too', () {
    // A theme animation crosses every gray between cream and night; on
    // those no color reaches 3:1, which once froze the app (ANR).
    const purple = Color(0xFF8E24AA);
    for (var t = 0.0; t <= 1; t += 0.05) {
      final surface = Color.lerp(
        AppTheme.light.colorScheme.surface,
        AppTheme.dark.colorScheme.surface,
        t,
      )!;
      final result = AppTokens.readable(purple, on: surface);
      expect(
        AppTokens.contrast(result, surface),
        greaterThanOrEqualTo(
          AppTokens.contrast(
            purple,
            surface,
          ).clamp(0, AppTokens.minGlyphContrast),
        ),
      );
    }
    // The extreme when nothing reaches the contrast.
    expect(
      AppTokens.readable(purple, on: const Color(0xFF777777), min: 21),
      Colors.black,
    );
  });

  test('readable keeps a color that already contrasts', () {
    const indigo = Color(0xFF3949AB);
    expect(AppTokens.readable(indigo, on: Colors.white), indigo);
    expect(
      AppTokens.readable(const Color(0xFFFFB300), on: Colors.white),
      isNot(const Color(0xFFFFB300)),
    );
  });

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
