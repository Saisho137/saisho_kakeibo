import 'package:flutter_archetype/l10n/gen/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

export 'package:flutter_archetype/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
