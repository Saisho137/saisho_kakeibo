import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

/// Design tokens that Material's [ColorScheme] does not cover.
///
/// Widgets read them with `context.tokens` instead of hard-coding values,
/// so light and dark themes stay consistent.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const new({
    required this.brand,
    required this.onBrand,
    required this.income,
    required this.expense,
    required this.transfer,
    required this.neutral,
    required this.iconGlyph,
    required this.iconGlyphDark,
    required this.radius,
    required this.radiusSmall,
    required this.donutRingWidth,
    required this.pillarBorderWidth,
    required this.pillarBorderHitWidth,
  });

  static const AppTokens light = AppTokens(
    brand: Color(0xFFE5A93B),
    onBrand: Color(0xFF34260A),
    income: Color(0xFF127033),
    expense: Color(0xFFBF2626),
    transfer: Color(0xFF6B6153),
    neutral: Color(0xFFCFC6B6),
    iconGlyph: Color(0xFFFFFFFF),
    iconGlyphDark: Color(0xDE000000),
    radius: 16,
    radiusSmall: 8,
    donutRingWidth: 36,
    pillarBorderWidth: 8,
    pillarBorderHitWidth: 32,
  );

  static const AppTokens dark = AppTokens(
    brand: Color(0xFFD99D33),
    onBrand: Color(0xFF2B1F07),
    income: Color(0xFF6FD08A),
    expense: Color(0xFFFF8A80),
    transfer: Color(0xFFC2B8A7),
    neutral: Color(0xFF5C5447),
    iconGlyph: Color(0xFFFFFFFF),
    iconGlyphDark: Color(0xDE000000),
    radius: 16,
    radiusSmall: 8,
    donutRingWidth: 36,
    pillarBorderWidth: 8,
    pillarBorderHitWidth: 32,
  );

  /// The app's amber-mustard: the bars and the Balance (RF-17).
  final Color brand;

  /// Text and icons on [brand].
  final Color onBrand;

  /// Income totals and buttons.
  final Color income;

  /// Expense totals and buttons.
  final Color expense;

  /// Transfer totals.
  final Color transfer;

  /// "No pillar" border and the empty donut ring.
  final Color neutral;

  /// Glyph drawn on a category or account color circle.
  final Color iconGlyph;

  /// Glyph on a light circle (amber, orange…), where [iconGlyph] would not
  /// stand out.
  final Color iconGlyphDark;

  /// Minimum contrast of a glyph on its circle (WCAG, for graphics).
  static const double minGlyphContrast = 3;

  /// The glyph that reads on [background]: [iconGlyph] when it contrasts
  /// enough, [iconGlyphDark] otherwise (accessibility).
  Color glyphOn(Color background) =>
      contrast(iconGlyph, background) >= minGlyphContrast
      ? iconGlyph
      : iconGlyphDark;

  /// WCAG contrast ratio of two opaque colors, from 1 to 21.
  static double contrast(Color a, Color b) {
    final (la, lb) = (a.computeLuminance(), b.computeLuminance());
    final (light, dark) = la >= lb ? (la, lb) : (lb, la);
    return (light + 0.05) / (dark + 0.05);
  }

  final double radius;
  final double radiusSmall;

  /// Thickness of the donut's category ring.
  final double donutRingWidth;

  /// Thickness of the pillar border drawn outside the category ring.
  final double pillarBorderWidth;

  /// Touch area of the pillar border, wider than the visible border.
  final double pillarBorderHitWidth;

  @override
  AppTokens copyWith({
    Color? brand,
    Color? onBrand,
    Color? income,
    Color? expense,
    Color? transfer,
    Color? neutral,
    Color? iconGlyph,
    Color? iconGlyphDark,
    double? radius,
    double? radiusSmall,
    double? donutRingWidth,
    double? pillarBorderWidth,
    double? pillarBorderHitWidth,
  }) {
    return AppTokens(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      transfer: transfer ?? this.transfer,
      neutral: neutral ?? this.neutral,
      iconGlyph: iconGlyph ?? this.iconGlyph,
      iconGlyphDark: iconGlyphDark ?? this.iconGlyphDark,
      radius: radius ?? this.radius,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      donutRingWidth: donutRingWidth ?? this.donutRingWidth,
      pillarBorderWidth: pillarBorderWidth ?? this.pillarBorderWidth,
      pillarBorderHitWidth: pillarBorderHitWidth ?? this.pillarBorderHitWidth,
    );
  }

  @override
  AppTokens lerp(covariant AppTokens? other, double t) {
    if (other == null) return this;
    return AppTokens(
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      transfer: Color.lerp(transfer, other.transfer, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
      iconGlyph: Color.lerp(iconGlyph, other.iconGlyph, t)!,
      iconGlyphDark: Color.lerp(iconGlyphDark, other.iconGlyphDark, t)!,
      radius: lerpDouble(radius, other.radius, t)!,
      radiusSmall: lerpDouble(radiusSmall, other.radiusSmall, t)!,
      donutRingWidth: lerpDouble(donutRingWidth, other.donutRingWidth, t)!,
      pillarBorderWidth: lerpDouble(
        pillarBorderWidth,
        other.pillarBorderWidth,
        t,
      )!,
      pillarBorderHitWidth: lerpDouble(
        pillarBorderHitWidth,
        other.pillarBorderHitWidth,
        t,
      )!,
    );
  }
}
