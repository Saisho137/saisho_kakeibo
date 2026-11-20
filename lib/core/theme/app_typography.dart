/// Roboto Flex, bundled as an asset so it works offline.
///
/// It is a variable font. Flutter maps `FontWeight` to its `wght` axis, so
/// styles must not set `fontVariations` for the weight: a fixed axis value
/// would override later `copyWith(fontWeight: ...)` calls.
abstract final class AppTypography {
  static const String fontFamily = 'RobotoFlex';
}
