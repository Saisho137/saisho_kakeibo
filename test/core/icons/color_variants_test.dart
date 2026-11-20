import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/icons/color_variants.dart';

void main() {
  const orange = Color(0xFFFB8C00);
  const blue = Color(0xFF1E88E5);

  group('ColorVariants.closestFree', () {
    test('keeps the suggested color when it is free', () {
      expect(ColorVariants.closestFree(orange, [blue]), orange);
      expect(ColorVariants.closestFree(orange, const []), orange);
    });

    test('picks a different color when the suggested one is in use', () {
      final variant = ColorVariants.closestFree(orange, [orange]);

      expect(variant, isNot(orange));
    });

    test('prefers the same hue first', () {
      final variant = ColorVariants.closestFree(orange, [orange]);

      expect(
        HSLColor.fromColor(variant).hue,
        closeTo(HSLColor.fromColor(orange).hue, 1),
      );
    });

    test('returns a free color on every new pick', () {
      final used = <Color>[orange];
      for (var i = 0; i < 10; i++) {
        final next = ColorVariants.closestFree(orange, used);

        expect(used, isNot(contains(next)));
        used.add(next);
      }
    });

    test('keeps variants readable under a white glyph', () {
      final used = <Color>[orange];
      for (var i = 0; i < 10; i++) {
        used.add(ColorVariants.closestFree(orange, used));
      }

      for (final color in used.skip(1)) {
        final lightness = HSLColor.fromColor(color).lightness;
        expect(lightness, inInclusiveRange(0.2, 0.7));
      }
    });

    test('falls back to the suggested color when every variant is taken', () {
      final used = <Color>[orange];
      for (var i = 0; i < 40; i++) {
        used.add(ColorVariants.closestFree(orange, used));
      }

      expect(ColorVariants.closestFree(orange, used), orange);
    });
  });
}
