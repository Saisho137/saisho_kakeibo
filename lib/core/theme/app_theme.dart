import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

/// Light and dark themes. The device setting picks one by default.
abstract final class AppTheme {
  static const Color _seed = Color(0xFF3F51B5);

  static ThemeData get light => _build(Brightness.light, AppTokens.light);

  static ThemeData get dark => _build(Brightness.dark, AppTokens.dark);

  static ThemeData _build(Brightness brightness, AppTokens tokens) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    return ThemeData(colorScheme: colorScheme, extensions: [tokens]);
  }
}
