import 'package:flutter_archetype/core/theme/app_theme.dart';
import 'package:flutter_archetype/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

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
