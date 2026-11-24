import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';

import '../helpers/fake_reminder_scheduler.dart';
import '../helpers/helpers.dart';

/// Every main screen at large text sizes on a small phone (360 × 740
/// logical pixels) lays out without overflowing (accessibility).
void main() {
  setUp(() async {
    await configureDependencies(
      database: AppDatabase(NativeDatabase.memory()),
      appInfo: const AppInfo(version: '0.1.0', buildNumber: '1'),
      reminderScheduler: FakeReminderScheduler(),
    );
  });

  tearDown(getIt.reset);

  Future<void> start(WidgetTester tester, double scale) async {
    tester.view.physicalSize = const Size(1080, 2220);
    tester.view.devicePixelRatio = 3;
    tester.platformDispatcher.textScaleFactorTestValue = scale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
  }

  for (final scale in [1.5, 2.0]) {
    group('At ${scale}x text', () {
      testWidgets('the Home and its quick menu fit', (tester) async {
        await start(tester, scale);
        await tester.tap(find.byTooltip('Quick menu'));
        await tester.pumpAndSettle();
        await tester.disposeDriftStreams();
      });

      testWidgets('the quick entry fits', (tester) async {
        await start(tester, scale);
        await tester.tap(find.byTooltip('Expense'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Eating out'));
        await tester.pumpAndSettle();
        await tester.disposeDriftStreams();
      });

      testWidgets('the history fits', (tester) async {
        await start(tester, scale);
        await tester.tap(find.byTooltip('History'));
        await tester.pumpAndSettle();
        await tester.disposeDriftStreams();
      });

      for (final (screen, tooltip, then) in [
        ('Accounts', null, 'Bank'),
        ('Debts', 'New debt', null),
        ('Categories', 'New category', null),
        ('Categories', 'Pillars', null),
        ('Recurring', 'New recurring', null),
        ('Settings', null, 'Advanced'),
      ]) {
        testWidgets('a form or detail of $screen fits', (tester) async {
          await start(tester, scale);
          await tester.tap(find.byTooltip('Go to'));
          await tester.pumpAndSettle();
          await tester.tap(find.text(screen));
          await tester.pumpAndSettle();
          if (tooltip != null) {
            await tester.tap(find.byTooltip(tooltip));
          } else {
            // `.first` throws while nothing matches, so the scroll looks
            // for every match.
            final target = find.text(then!);
            await tester.scrollUntilVisible(
              target,
              300,
              // The routes below stay in the tree: the top page's list is last.
              scrollable: find.byType(Scrollable).last,
            );
            await tester.tap(target.first);
          }
          await tester.pumpAndSettle();
          await tester.disposeDriftStreams();
        });
      }

      for (final screen in [
        'Accounts',
        'Debts',
        'Entities',
        'Categories',
        'Recurring',
        'Settings',
      ]) {
        testWidgets('$screen fits', (tester) async {
          await start(tester, scale);
          await tester.tap(find.byTooltip('Go to'));
          await tester.pumpAndSettle();
          await tester.tap(find.text(screen));
          await tester.pumpAndSettle();
          await tester.disposeDriftStreams();
        });
      }
    });
  }
}
