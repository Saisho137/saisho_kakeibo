import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

import '../helpers/fake_reminder_scheduler.dart';
import '../helpers/helpers.dart';

void main() {
  late FakeReminderScheduler reminders;

  setUp(() async {
    reminders = FakeReminderScheduler();
    await configureDependencies(
      database: AppDatabase(NativeDatabase.memory()),
      appInfo: const AppInfo(version: '0.1.0', buildNumber: '1'),
      reminderScheduler: reminders,
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

      await tester.goTo('Settings');
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

      await tester.goTo('Accounts');
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

      await tester.goTo('Categories');
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

      await tester.goTo('Accounts');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cash'));
      await tester.pumpAndSettle();
      expect(find.text('No movements in this period.'), findsOneWidget);

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

      await tester.tap(find.text('Expense'));
      await tester.pumpAndSettle();
      expect(find.text('Debt payment'), findsOneWidget);
      await tester.tap(find.text('Eating out'));
      await tester.pumpAndSettle();
      for (final key in ['2', '5', '000']) {
        await tester.tap(find.text(key));
      }
      await tester.enterText(find.byType(TextFormField).first, 'crepes');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      // Back on the Home: the period's expenses and the Balance.
      expect(find.text('25.000'), findsOneWidget);
      expect(
        find.text('Balance COP -25.000', findRichText: true),
        findsOneWidget,
      );

      await tester.goTo('Accounts');
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
      expect(find.text('No movements in this period.'), findsOneWidget);

      await tester.disposeDriftStreams();
    });

    testWidgets('transfers from an account and edits the transfer', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.goTo('Accounts');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bank'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Transfer'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<int>).at(1));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cash · COP').last);
      await tester.pumpAndSettle();
      expect(find.text('Cash withdrawal'), findsOneWidget);
      for (final key in ['8', '000']) {
        await tester.tap(find.text(key));
      }
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('To Cash'), findsOneWidget);
      expect(find.text('-8.000 COP'), findsOneWidget);

      await tester.tap(find.text('To Cash'));
      await tester.pumpAndSettle();
      expect(find.text('COP 8.000'), findsOne);
      await tester.tap(find.byTooltip('Delete transfer'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(find.text('No movements in this period.'), findsOneWidget);

      await tester.disposeDriftStreams();
    });

    testWidgets('a loan received creates its debt, which is then paid', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Income'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Loan received'));
      await tester.pumpAndSettle();
      for (final key in ['5', '000']) {
        await tester.tap(find.text(key));
      }
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Entity'),
        'Davivienda',
      );
      await tester.ensureVisible(find.text('Pillar'));
      await tester.tap(find.text('Pillar'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Survival').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      await tester.goTo('Debts');
      await tester.pumpAndSettle();
      expect(find.text('Davivienda'), findsOneWidget);
      expect(find.text('5.000 left'), findsOneWidget);
      await tester.tap(find.text('Davivienda'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pay'));
      await tester.pumpAndSettle();
      expect(find.text('Davivienda · 5.000 left'), findsOneWidget);
      for (final key in ['1', '000']) {
        await tester.tap(find.text(key));
      }
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('4.000 COP'), findsOneWidget);
      expect(find.text('20%'), findsOneWidget);

      await tester.disposeDriftStreams();
    });

    testWidgets('a new period creates the pending recurring movements', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      addTearDown(tester.view.reset);
      final accounts =
          (await getIt<AccountRepository>().getAccounts() as Ok<List<Account>>)
              .value;
      final categories =
          (await getIt<CategoryRepository>().getCategories()
                  as Ok<List<Category>>)
              .value;
      await getIt<RecurringRepository>().saveTemplate(
        RecurringTemplate(
          type: MovementType.expense,
          categoryId: categories.firstWhere((c) => c.name == 'Car').id,
          accountId: accounts.firstWhere((a) => a.isMain).id,
          amount: 450000,
          dueDay: 12,
          remind: true,
          createdOn: LocalDate.today().addDays(-1),
        ),
        payee: PayeeName.parse('Parking'),
      );
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Its due day is reminded at 8:00, and permission is asked once.
      await tester.pump(const Duration(seconds: 1));
      expect(reminders.scheduled.map((r) => r.name), ['Parking', 'Parking']);
      expect(reminders.minutes, 8 * 60);
      expect(reminders.permissionRequests, 1);

      await tester.goTo('Settings');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Advanced'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Start new period now'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Start'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();

      expect(find.text('450.000'), findsOneWidget);
      await tester.tap(find.byTooltip('History'));
      await tester.pumpAndSettle();
      expect(find.text('Parking · Pending'), findsOneWidget);
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Undoing that start takes its pending movement away too.
      await tester.goTo('Settings');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Advanced'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Undo this start'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.text('450.000'), findsNothing);

      await tester.disposeDriftStreams();
    });
  });
}

extension on WidgetTester {
  /// Opens [screen] from the Home's ⋮ navigation.
  Future<void> goTo(String screen) async {
    await tap(find.byTooltip('Go to'));
    await pumpAndSettle();
    await tap(find.text(screen));
  }
}
