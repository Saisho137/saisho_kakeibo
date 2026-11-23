import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';

import '../helpers/fake_reminder_scheduler.dart';
import '../helpers/helpers.dart';

/// The main screens meet Flutter's accessibility guidelines: labeled tap
/// targets of 48 × 48 and readable text contrast.
void main() {
  setUp(() async {
    await configureDependencies(
      database: AppDatabase(NativeDatabase.memory()),
      appInfo: const AppInfo(version: '0.1.0', buildNumber: '1'),
      reminderScheduler: FakeReminderScheduler(),
    );
  });

  tearDown(getIt.reset);

  Future<void> check(WidgetTester tester) async {
    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  }

  Future<void> start(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
  }

  testWidgets('the Home', (tester) async {
    final semantics = tester.ensureSemantics();
    await start(tester);
    await check(tester);
    await tester.disposeDriftStreams();
    semantics.dispose();
  });

  testWidgets('the quick entry', (tester) async {
    final semantics = tester.ensureSemantics();
    await start(tester);
    await tester.tap(find.text('Expense'));
    await tester.pumpAndSettle();
    await check(tester);
    await tester.tap(find.text('Eating out'));
    await tester.pumpAndSettle();
    await check(tester);
    await tester.disposeDriftStreams();
    semantics.dispose();
  });

  for (final screen in [
    'Accounts',
    'Debts',
    'Entities',
    'Categories',
    'Recurring',
    'Settings',
  ]) {
    testWidgets(screen, (tester) async {
      final semantics = tester.ensureSemantics();
      await start(tester);
      await tester.tap(find.byTooltip('Go to'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(screen));
      await tester.pumpAndSettle();
      await check(tester);
      await tester.disposeDriftStreams();
      semantics.dispose();
    });
  }
}
