import 'package:material_ui/material_ui.dart';

/// Roboto Flex, bundled as an asset so it works offline.
///
/// It is a variable font: the weight comes from its `wght` axis, so every
/// style sets [FontVariation] to match its [FontWeight].
abstract final class AppTypography {
  static const String fontFamily = 'RobotoFlex';

  /// Adds the matching weight axis to every style of [textTheme].
  static TextTheme apply(TextTheme textTheme) => TextTheme(
    displayLarge: _withWeightAxis(textTheme.displayLarge),
    displayMedium: _withWeightAxis(textTheme.displayMedium),
    displaySmall: _withWeightAxis(textTheme.displaySmall),
    headlineLarge: _withWeightAxis(textTheme.headlineLarge),
    headlineMedium: _withWeightAxis(textTheme.headlineMedium),
    headlineSmall: _withWeightAxis(textTheme.headlineSmall),
    titleLarge: _withWeightAxis(textTheme.titleLarge),
    titleMedium: _withWeightAxis(textTheme.titleMedium),
    titleSmall: _withWeightAxis(textTheme.titleSmall),
    bodyLarge: _withWeightAxis(textTheme.bodyLarge),
    bodyMedium: _withWeightAxis(textTheme.bodyMedium),
    bodySmall: _withWeightAxis(textTheme.bodySmall),
    labelLarge: _withWeightAxis(textTheme.labelLarge),
    labelMedium: _withWeightAxis(textTheme.labelMedium),
    labelSmall: _withWeightAxis(textTheme.labelSmall),
  );

  static TextStyle? _withWeightAxis(TextStyle? style) =>
      style?.withWeight(style.fontWeight ?? FontWeight.normal);
}

extension TextStyleWeightX on TextStyle {
  /// Sets [weight] on both [TextStyle.fontWeight] and the variable font's
  /// `wght` axis. Use it instead of `copyWith(fontWeight: ...)`.
  TextStyle withWeight(FontWeight weight) => copyWith(
    fontWeight: weight,
    fontVariations: [FontVariation('wght', weight.value.toDouble())],
  );
}
