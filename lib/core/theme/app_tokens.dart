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
    required this.radius,
  });

  static const AppTokens light = AppTokens(
    income: Color(0xFF2E7D32),
    expense: Color(0xFFC62828),
    transfer: Color(0xFF616161),
    radius: 16,
  );

  static const AppTokens dark = AppTokens(
    income: Color(0xFF81C784),
    expense: Color(0xFFE57373),
    transfer: Color(0xFFBDBDBD),
    radius: 16,
  );

  final Color income;
  final Color expense;
  final Color transfer;
  final double radius;

  @override
  AppTokens copyWith({
    Color? income,
    Color? expense,
    Color? transfer,
    double? radius,
  }) {
    return AppTokens(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      transfer: transfer ?? this.transfer,
      radius: radius ?? this.radius,
    );
  }

  @override
  AppTokens lerp(covariant AppTokens? other, double t) {
    if (other == null) return this;
    return AppTokens(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      transfer: Color.lerp(transfer, other.transfer, t)!,
      radius: lerpDouble(radius, other.radius, t)!,
    );
  }
}
