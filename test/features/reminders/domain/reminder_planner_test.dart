import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';
import 'package:saisho_kakeibo/features/reminders/domain/services/reminder_planner.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final bank = account(id: 1);
  final visa = account(
    id: 5,
    name: 'Visa',
    type: AccountType.creditCard,
    paymentDay: 31,
  );
  final old = account(id: 6, type: AccountType.creditCard, paymentDay: 2);

  List<Reminder> plan(
    List<RecurringTemplate> templates, {
    List<Account>? accounts,
    LocalDate? today,
  }) => ReminderPlanner.plan(
    templates: templates,
    accounts: accounts ?? [bank],
    categories: [category(id: 10, name: 'Gym')],
    payees: const [Payee(id: 4, name: 'Netflix', key: 'netflix')],
    currencies: const [cop],
    today: today ?? LocalDate(2026, 1, 20),
  );

  group('ReminderPlanner', () {
    test('reminds a template on its next two due days', () {
      final reminders = plan([
        template(payeeId: 4, amount: 44900, dueDay: 12, remind: true),
      ]);

      expect(reminders.map((r) => r.date), [
        LocalDate(2026, 2, 12),
        LocalDate(2026, 3, 12),
      ]);
      expect(reminders.first.name, 'Netflix');
      expect(reminders.first.amount, 'COP 44.900');
      expect(reminders.first.kind, ReminderKind.recurring);
      expect(reminders.map((r) => r.id), [100010, 100011]);
    });

    test('today still counts; a missing payee uses the category', () {
      final reminders = plan([template(dueDay: 20, remind: true)]);
      expect(reminders.first.date, LocalDate(2026, 1, 20));
      expect(reminders.first.name, 'Gym');
    });

    test('skips templates without a reminder, paused or archived', () {
      expect(plan([template(dueDay: 12)]), isEmpty);
      expect(
        plan([template(dueDay: 12, remind: true, isActive: false)]),
        isEmpty,
      );
      expect(
        plan(
          [template(dueDay: 12, remind: true)],
          accounts: [bank.copyWith(isArchived: true)],
        ),
        isEmpty,
      );
    });

    test('reminds active cards on their payment day, clamped', () {
      final reminders = plan(
        [],
        accounts: [bank, visa, old.copyWith(isArchived: true)],
      );
      expect(reminders.map((r) => r.date), [
        LocalDate(2026, 1, 31),
        LocalDate(2026, 2, 28),
      ]);
      expect(reminders.first.kind, ReminderKind.cardPayment);
      expect(reminders.first.name, 'Visa');
      expect(reminders.first.amount, isNull);
      expect(reminders.first.id, 200050);
    });

    test('a template without a known currency has no amount', () {
      final reminders = ReminderPlanner.plan(
        templates: [template(dueDay: 12, remind: true)],
        accounts: [bank],
        categories: const [],
        payees: const [],
        currencies: const [],
        today: LocalDate(2026, 1, 20),
      );
      expect(reminders.first.amount, isNull);
      expect(reminders.first.name, '');
    });
  });
}
