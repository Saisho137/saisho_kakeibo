import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';
import 'package:saisho_kakeibo/core/theme/app_typography.dart';

/// Light and dark themes. The device setting picks one by default.
///
/// The identity is an amber-mustard ([AppTokens.brand]) in solid bars with
/// dark ink, on a cream background that rests the eyes. Material's roles
/// come from the same seed, so its controls (switches, text buttons) use a
/// deeper amber that reads as text.
abstract final class AppTheme {
  static const Color _seed = Color(0xFFE5A93B);

  /// Cream, instead of Material's near white.
  static const Color _cream = Color(0xFFFFF8EC);

  /// A warm near black, instead of Material's neutral dark.
  static const Color _night = Color(0xFF1C1914);

  static ThemeData get light => _build(Brightness.light, AppTokens.light);

  static ThemeData get dark => _build(Brightness.dark, AppTokens.dark);

  static ThemeData _build(Brightness brightness, AppTokens tokens) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    ).copyWith(surface: brightness == Brightness.light ? _cream : _night);
    return ThemeData(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: AppTypography.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: tokens.brand,
        foregroundColor: tokens.onBrand,
        surfaceTintColor: Colors.transparent,
      ),
      extensions: [tokens],
    );
  }
}
