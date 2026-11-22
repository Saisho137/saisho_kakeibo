import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_occurrence.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/delete_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/get_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/materialize_recurring.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/save_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/set_recurring_template_active.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

class _MockRecurring extends Mock implements RecurringRepository;

class _MockAccounts extends Mock implements AccountRepository;

class _MockCategories extends Mock implements CategoryRepository;

class _MockPeriods extends Mock implements PeriodRepository;

class _MockSettings extends Mock implements SettingsRepository;

void main() {
  late _MockRecurring recurring;
  late _MockAccounts accounts;
  late _MockCategories categories;
  late _MockPeriods periods;
  late _MockSettings settings;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final bank = account(id: 1);
  final old = account(id: 3, isArchived: true);

  Matcher isValidationError() => isA<Err<dynamic>>().having(
    (e) => e.failure,
    'failure',
    isA<ValidationFailure>(),
  );

  setUpAll(() {
    registerFallbackValue(template());
    registerFallbackValue(<PlannedOccurrence>[]);
    registerFallbackValue(<OccurrenceRepair>[]);
  });

  setUp(() {
    recurring = _MockRecurring();
    accounts = _MockAccounts();
    categories = _MockCategories();
    periods = _MockPeriods();
    settings = _MockSettings();
    when(() => accounts.getAccounts()).thenAnswer((_) async => Ok([bank, old]));
    when(() => categories.getCategories())
        .thenAnswer((_) async => Ok([category(id: 10)]));
    when(() => recurring.saveTemplate(any(), payee: any(named: 'payee')))
        .thenAnswer((_) async => const Ok(7));
    when(() => recurring.findTemplate(any()))
        .thenAnswer((_) async => Ok(template()));
    when(() => recurring.deleteTemplate(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => recurring.getTemplates())
        .thenAnswer((_) async => Ok([template()]));
    when(() => recurring.getOccurrences())
        .thenAnswer((_) async => const Ok([]));
    when(() => recurring.repair(any())).thenAnswer((_) async => const Ok(null));
    when(() => recurring.materialize(any()))
        .thenAnswer((_) async => const Ok(1));
    when(() => periods.getStarts())
        .thenAnswer((_) async => Ok([LocalDate(2026, 3, 23)]));
    when(() => settings.getSettings())
        .thenAnswer((_) async => const Ok(AppSettings()));
  });

  SaveRecurringTemplate save() => SaveRecurringTemplate(
    recurring: recurring,
    accounts: accounts,
    categories: categories,
  );

  group('simple calls', () {
    test('forward to the repository', () async {
      when(() => recurring.watchTemplates())
          .thenAnswer((_) => Stream.value([template()]));

      expect(await WatchRecurringTemplates(recurring)(const NoParams()).first, [
        template(),
      ]);
      expect(
        (await GetRecurringTemplate(recurring)(1) as Ok).value,
        template(),
      );
      await DeleteRecurringTemplate(recurring)(1);
      verify(() => recurring.deleteTemplate(1)).called(1);
    });
  });

  group('SaveRecurringTemplate', () {
    test('saves a normalized template with its payee', () async {
      final result = await save()(
        SaveRecurringTemplateParams(
          template(payeeId: 9, remind: true),
          payeeName: ' netflix ',
        ),
      );

      expect((result as Ok<int>).value, 7);
      final captured = verify(
        () => recurring.saveTemplate(
          captureAny(),
          payee: captureAny(named: 'payee'),
        ),
      ).captured;
      final saved = captured.first as RecurringTemplate;
      expect(saved.payeeId, isNull);
      expect(saved.remind, isFalse);
      expect((captured.last as PayeeName).name, 'Netflix');
    });

    test('a transfer takes no payee', () async {
      when(() => categories.getCategories()).thenAnswer(
        (_) async => Ok([category(id: 11, type: CategoryType.transfer)]),
      );
      when(() => accounts.getAccounts())
          .thenAnswer((_) async => Ok([bank, account(id: 2)]));
      await save()(
        SaveRecurringTemplateParams(
          template(type: MovementType.transfer, categoryId: 11, toAccountId: 2),
          payeeName: 'Someone',
        ),
      );
      verify(() => recurring.saveTemplate(any())).called(1);
    });

    test('rejects invalid templates and archived accounts', () async {
      expect(
        await save()(SaveRecurringTemplateParams(template(amount: 0))),
        isValidationError(),
      );
      expect(
        await save()(SaveRecurringTemplateParams(template(dueDay: 40))),
        isValidationError(),
      );
      expect(
        await save()(SaveRecurringTemplateParams(template(accountId: 3))),
        isValidationError(),
      );
      verifyNever(
        () => recurring.saveTemplate(any(), payee: any(named: 'payee')),
      );
    });

    test('propagates failed reads', () async {
      when(() => accounts.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        (await save()(SaveRecurringTemplateParams(template())) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('SetRecurringTemplateActive', () {
    SetRecurringTemplateActive setActive() =>
        SetRecurringTemplateActive(recurring);

    test('saves the template paused or active', () async {
      await setActive()(
        const SetRecurringTemplateActiveParams(id: 1, active: false),
      );
      final saved =
          verify(() => recurring.saveTemplate(captureAny())).captured.single
              as RecurringTemplate;
      expect(saved.isActive, isFalse);
    });

    test('rejects unknown templates and propagates failures', () async {
      when(() => recurring.findTemplate(2))
          .thenAnswer((_) async => const Ok(null));
      expect(
        await setActive()(
          const SetRecurringTemplateActiveParams(id: 2, active: true),
        ),
        isValidationError(),
      );
      when(() => recurring.findTemplate(3)).thenAnswer((_) async => dbError);
      expect(
        await setActive()(
          const SetRecurringTemplateActiveParams(id: 3, active: true),
        ),
        isA<Err<void>>(),
      );
      when(() => recurring.saveTemplate(any()))
          .thenAnswer((_) async => dbError);
      expect(
        await setActive()(
          const SetRecurringTemplateActiveParams(id: 1, active: true),
        ),
        isA<Err<void>>(),
      );
    });
  });

  group('MaterializeRecurring', () {
    MaterializeRecurring materialize() => MaterializeRecurring(
      recurring: recurring,
      periods: periods,
      settings: settings,
      accounts: accounts,
    );

    test('creates what the templates owe', () async {
      final result = await materialize()(LocalDate(2026, 3, 25));

      expect((result as Ok<int>).value, 1);
      final planned =
          verify(() => recurring.materialize(captureAny())).captured.single
              as List<PlannedOccurrence>;
      expect(planned.single.periodStart, LocalDate(2026, 3, 23));
    });

    test('does nothing when nothing is owed', () async {
      when(() => recurring.getOccurrences()).thenAnswer(
        (_) async => Ok([
          RecurringOccurrence(
            id: 1,
            templateId: 1,
            periodStart: LocalDate(2026, 3, 23),
          ),
        ]),
      );

      expect((await materialize()(LocalDate(2026, 3, 25)) as Ok<int>).value, 0);
      verifyNever(() => recurring.materialize(any()));
    });

    test('moves the pending movement of a corrected salary date', () async {
      // The salary that started a period on March 23 is now on the 21st.
      when(() => periods.getStarts())
          .thenAnswer((_) async => Ok([LocalDate(2026, 3, 21)]));
      when(() => recurring.getOccurrences()).thenAnswer(
        (_) async => Ok([
          RecurringOccurrence(
            id: 4,
            templateId: 1,
            periodStart: LocalDate(2026, 3, 23),
            movementId: 9,
            isPending: true,
          ),
        ]),
      );

      expect((await materialize()(LocalDate(2026, 3, 25)) as Ok<int>).value, 0);
      final repair =
          (verify(() => recurring.repair(captureAny())).captured.single
                  as List<OccurrenceRepair>)
              .single;
      expect(repair, isA<MoveOccurrence>());
      expect((repair as MoveOccurrence).periodStart, LocalDate(2026, 3, 21));
      expect(repair.movementId, 9);
      expect(repair.date, LocalDate(2026, 3, 21));
      verifyNever(() => recurring.materialize(any()));
    });

    test('propagates a failed repair', () async {
      when(() => periods.getStarts())
          .thenAnswer((_) async => Ok([LocalDate(2026, 3, 21)]));
      when(() => recurring.getOccurrences()).thenAnswer(
        (_) async => Ok([
          RecurringOccurrence(
            id: 4,
            templateId: 1,
            periodStart: LocalDate(2026, 3, 23),
          ),
        ]),
      );
      when(() => recurring.repair(any())).thenAnswer((_) async => dbError);

      expect(await materialize()(LocalDate(2026, 3, 25)), isA<Err<int>>());
    });

    test('propagates failed reads', () async {
      when(() => periods.getStarts()).thenAnswer((_) async => dbError);
      expect(await materialize()(LocalDate(2026, 3, 25)), isA<Err<int>>());
    });
  });
}
