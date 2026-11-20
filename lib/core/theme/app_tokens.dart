import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

/// Design tokens that Material's [ColorScheme] does not cover.
///
/// Widgets read them with `context.tokens` instead of hard-coding values,
/// so light and dark themes stay consistent.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const new({
    required this.income,
    required this.expense,
    required this.transfer,
    required this.neutral,
    required this.radius,
    required this.radiusSmall,
    required this.donutRingWidth,
    required this.pillarBorderWidth,
    required this.pillarBorderHitWidth,
  });

  static const AppTokens light = AppTokens(
    income: Color(0xFF2E7D32),
    expense: Color(0xFFC62828),
    transfer: Color(0xFF616161),
    neutral: Color(0xFFBDBDBD),
    radius: 16,
    radiusSmall: 8,
    donutRingWidth: 36,
    pillarBorderWidth: 8,
    pillarBorderHitWidth: 32,
  );

  static const AppTokens dark = AppTokens(
    income: Color(0xFF81C784),
    expense: Color(0xFFE57373),
    transfer: Color(0xFFBDBDBD),
    neutral: Color(0xFF616161),
    radius: 16,
    radiusSmall: 8,
    donutRingWidth: 36,
    pillarBorderWidth: 8,
    pillarBorderHitWidth: 32,
  );

  /// Income totals and buttons.
  final Color income;

  /// Expense totals and buttons.
  final Color expense;

  /// Transfer totals.
  final Color transfer;

  /// "No pillar" border and the empty donut ring.
  final Color neutral;

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
    Color? income,
    Color? expense,
    Color? transfer,
    Color? neutral,
    double? radius,
    double? radiusSmall,
    double? donutRingWidth,
    double? pillarBorderWidth,
    double? pillarBorderHitWidth,
  }) {
    return AppTokens(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      transfer: transfer ?? this.transfer,
      neutral: neutral ?? this.neutral,
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
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      transfer: Color.lerp(transfer, other.transfer, t)!,
      neutral: Color.lerp(neutral, other.neutral, t)!,
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
