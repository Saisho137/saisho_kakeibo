import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

extension PumpApp on WidgetTester {
  /// Pumps [widget] inside a MaterialApp with the app theme and English
  /// localizations. Pass a mocked [router] to verify navigation.
  Future<void> pumpApp(Widget widget, {GoRouter? router}) {
    return pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: router == null
            ? widget
            : InheritedGoRouter(goRouter: router, child: widget),
      ),
    );
  }
}
