import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  final bank = account(id: 1);
  final cash = account(id: 2, type: AccountType.cash);
  final old = account(id: 3, isArchived: true);
  final accounts = [bank, cash, old];

  // A salary started a period on March 23; the cutoff day is the 27th.
  final salary = LocalDate(2026, 3, 23);
  final today = LocalDate(2026, 4, 2);

  List<PlannedOccurrence> plan(
    List<RecurringTemplate> templates, {
    List<LocalDate>? starts,
    Set<(int, LocalDate)> occurrences = const {},
    LocalDate? on,
  }) => RecurringPlanner.plan(
    templates: templates,
    accounts: accounts,
    today: on ?? today,
    dynamicStarts: starts ?? [LocalDate(2026, 2, 24), salary],
    cutoffDay: 27,
    occurrences: occurrences,
  );

  group('RecurringPlanner', () {
    test('a period template owes the latest dynamic start', () {
      final planned = plan([template()]).single;
      expect(planned.templateId, 1);
      expect(planned.periodStart, salary);
      expect(planned.movement.date, salary);
      expect(planned.movement.isPending, isTrue);
    });

    test('a monthly template owes the monthly period of today', () {
      final planned = plan([template(cadence: RecurringCadence.monthly)])
          .single;
      expect(planned.periodStart, LocalDate(2026, 3, 27));
      expect(planned.movement.date, LocalDate(2026, 3, 27));
    });

    test('an income falls on its due day', () {
      final planned = plan([template(type: MovementType.income, dueDay: 30)])
          .single;
      expect(planned.movement.date, LocalDate(2026, 3, 30));
    });

    test('nothing for the period a template was created in', () {
      expect(plan([template(createdOn: salary)]), isEmpty);
      expect(plan([template(createdOn: LocalDate(2026, 3, 25))]), isEmpty);
      expect(plan([template(createdOn: LocalDate(2026, 3, 22))]), hasLength(1));
    });

    test('nothing twice, even after a cancelled movement', () {
      expect(plan([template()], occurrences: {(1, salary)}), isEmpty);
      expect(
        plan([template()], occurrences: {(1, LocalDate(2026, 2, 24))}),
        hasLength(1),
      );
    });

    test('paused templates and archived accounts owe nothing', () {
      expect(plan([template(isActive: false)]), isEmpty);
      expect(plan([template(accountId: 3)]), isEmpty);
      expect(plan([template(accountId: 99)]), isEmpty);
      expect(
        plan([template(type: MovementType.transfer, toAccountId: 3)]),
        isEmpty,
      );
      expect(
        plan([template(type: MovementType.transfer, toAccountId: 2)]),
        hasLength(1),
      );
    });

    test('without salaries, only monthly templates owe anything', () {
      final planned = plan([
        template(),
        template(id: 2, cadence: RecurringCadence.monthly),
      ], starts: []);
      expect(planned.single.templateId, 2);
    });

    test('a future start waits for its day', () {
      final planned = plan(
        [template(createdOn: LocalDate(2026, 2, 1))],
        starts: [LocalDate(2026, 2, 24), LocalDate(2026, 4, 10)],
      );
      expect(planned.single.periodStart, LocalDate(2026, 2, 24));
      expect(plan([template()], starts: [LocalDate(2026, 4, 10)]), isEmpty);
    });

    test('occurrences compare by value', () {
      final a = plan([template()]).single;
      final b = plan([template()]).single;
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });
}
