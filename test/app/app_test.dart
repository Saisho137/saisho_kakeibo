import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

import '../helpers/helpers.dart';

void main() {
  setUp(() async {
    await configureDependencies(
      database: AppDatabase(NativeDatabase.memory()),
      appInfo: const AppInfo(version: '0.1.0', buildNumber: '1'),
    );
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

    testWidgets('creates, edits and deletes a currency from Settings', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 4000);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('COP'), findsWidgets);
      expect(find.text('0.1.0 (1)'), findsOneWidget);

      await tester.tap(find.text('Add currency'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(0), 'eur');
      await tester.enterText(find.byType(TextFormField).at(1), '€');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('€ 1.234.567,89'), findsOneWidget);

      await tester.tap(find.text('EUR'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'EU');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('EU 1.234.567,89'), findsOneWidget);

      await tester.tap(find.text('EUR'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Delete currency'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('EUR'), findsNothing);

      await tester.disposeDriftStreams();
    });

    testWidgets('creates a pocket and shows it under its parent', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 4000);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('Cash'), findsOneWidget);
      expect(find.text('Bank'), findsOneWidget);

      await tester.tap(find.byTooltip('New account'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pocket'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'emergency fund',
      );
      await tester.enterText(find.byType(TextFormField).at(1), '3.000.000');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Emergency fund'), findsOneWidget);
      expect(find.text('Free'), findsOneWidget);
      expect(find.text('3.000.000'), findsWidgets);

      await tester.tap(find.text('Emergency fund'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Edit account'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Delete account'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Emergency fund'), findsNothing);

      await tester.disposeDriftStreams();
    });

    testWidgets('creates and deletes a custom category', (tester) async {
      tester.view.physicalSize = const Size(1080, 4000);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Categories'));
      await tester.pumpAndSettle();
      expect(find.text('Eating out'), findsOneWidget);
      expect(find.text('Uncategorized'), findsOneWidget);

      await tester.tap(find.byTooltip('New category'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField), 'groceries');
      await tester.tap(find.byType(DropdownButtonFormField<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Survival').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('Groceries'), findsOneWidget);

      await tester.tap(find.text('Groceries'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Delete category'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('Groceries'), findsNothing);

      await tester.disposeDriftStreams();
    });

    testWidgets('adjusts the balance of an account', (tester) async {
      tester.view.physicalSize = const Size(1080, 4000);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Accounts'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cash'));
      await tester.pumpAndSettle();
      expect(find.text('No movements yet.'), findsOneWidget);

      await tester.tap(find.text('Adjust balance'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.byType(TextFormField),
        ),
        '50.000',
      );
      await tester.pump();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('50.000 COP'), findsOneWidget);
      expect(find.text('Balance adjustment'), findsOneWidget);
      expect(find.text('+50.000'), findsOneWidget);

      await tester.disposeDriftStreams();
    });

    testWidgets('records an expense from the quick entry and edits it', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('New expense'));
      await tester.pumpAndSettle();
      expect(find.text('Debt payment'), findsNothing);
      await tester.tap(find.text('Eating out'));
      await tester.pumpAndSettle();
      for (final key in ['2', '5', '000']) {
        await tester.tap(find.text(key));
      }
      await tester.enterText(find.byType(TextFormField).first, 'crepes');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(find.text('New expense'), findsOneWidget);

      await tester.tap(find.byTooltip('Accounts'));
      await tester.pumpAndSettle();
      expect(find.text('-25.000'), findsWidgets);
      await tester.tap(find.text('Bank'));
      await tester.pumpAndSettle();
      expect(find.text('Crepes'), findsOneWidget);

      await tester.tap(find.text('Eating out'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Delete movement'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('No movements yet.'), findsOneWidget);

      await tester.disposeDriftStreams();
    });
  });
}
