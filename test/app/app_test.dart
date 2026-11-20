import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

import '../helpers/helpers.dart';

void main() {
  setUp(() async {
    await configureDependencies(database: AppDatabase(NativeDatabase.memory()));
  });

  tearDown(getIt.reset);

  group('App', () {
    testWidgets('renders HomePage as the initial route', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);

      await tester.disposeDriftStreams();
    });

    testWidgets('follows the stored theme mode', (tester) async {
      await getIt<SettingsRepository>().save(
        const AppSettings(themeMode: AppThemeMode.dark),
      );

      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.themeMode, ThemeMode.dark);

      await tester.disposeDriftStreams();
    });
  });
}
