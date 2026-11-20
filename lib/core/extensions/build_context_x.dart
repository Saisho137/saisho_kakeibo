import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}
