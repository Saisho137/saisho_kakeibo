import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a MaterialApp with the app theme and English
  /// localizations.
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }
}
