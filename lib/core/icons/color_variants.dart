import 'package:material_ui/material_ui.dart';

/// Picks a color close to a suggested one that is not in use yet (RF-13),
/// so the user never has to keep category colors unique by hand.
abstract final class ColorVariants {
  // Closest first: lightness shifts of the same hue, then nearby hues.
  static const List<double> _hueShifts = [0, 15, -15, 30, -30, 45, -45];
  static const List<double> _lightnessShifts = [0, -0.1, 0.1, -0.2, 0.2];

  // Keeps variants readable under a white glyph.
  static const double _minLightness = 0.2;
  static const double _maxLightness = 0.7;

  /// Returns [suggested] if no color in [inUse] equals it; otherwise the
  /// closest free variant. If every variant is taken, returns [suggested].
  static Color closestFree(Color suggested, Iterable<Color> inUse) {
    final used = {for (final color in inUse) color.toARGB32()};
    if (!used.contains(suggested.toARGB32())) return suggested;

    final base = HSLColor.fromColor(suggested);
    for (final hueShift in _hueShifts) {
      for (final lightnessShift in _lightnessShifts) {
        final candidate = base
            .withHue((base.hue + hueShift) % 360)
            .withLightness(
              (base.lightness + lightnessShift).clamp(
                _minLightness,
                _maxLightness,
              ),
            )
            .toColor();
        if (!used.contains(candidate.toARGB32())) return candidate;
      }
    }
    return suggested;
  }
}
