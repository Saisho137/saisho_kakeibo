import 'dart:math';

import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/reminders/domain/entities/reminder.dart';

/// Decides the reminders to schedule (RF-03, RF-06, RT-11): the due day of
/// each active template with its reminder on, and the payment day of each
/// active credit card. Each one is scheduled for its next days (two by
/// default) from today on, so it still fires if the app is not opened for
/// a while; a day the month lacks falls on its last day.
abstract final class ReminderPlanner {
  static const int recurringIds = 100000;
  static const int cardIds = 200000;

  static List<Reminder> plan({
    required List<RecurringTemplate> templates,
    required List<Account> accounts,
    required List<Category> categories,
    required List<Payee> payees,
    required List<Currency> currencies,
    required LocalDate today,
    int months = 2,
  }) {
    List<LocalDate> nextDays(int day) => [
      for (var k = 0; k <= months; k++)
        if (_dayIn(today.year, today.month + k, day) case final date
            when !date.isBefore(today))
          date,
    ].take(months).toList();

    bool active(Account? a) => a != null && !a.isArchived;

    return [
      for (final t in templates)
        if (t.isActive && t.remind && active(accounts.byId(t.accountId)))
          if (t.dueDay case final day?)
            for (final (index, date) in nextDays(day).indexed)
              Reminder(
                id: recurringIds + t.id * 10 + index,
                kind: ReminderKind.recurring,
                name:
                    payees.where((p) => p.id == t.payeeId).firstOrNull?.name ??
                    categories.byId(t.categoryId)?.name ??
                    '',
                date: date,
                amount: _amount(t, accounts, currencies),
              ),
      for (final a in accounts)
        if (a.type == AccountType.creditCard && !a.isArchived)
          if (a.paymentDay case final day?)
            for (final (index, date) in nextDays(day).indexed)
              Reminder(
                id: cardIds + a.id * 10 + index,
                kind: ReminderKind.cardPayment,
                name: a.name,
                date: date,
              ),
    ];
  }

  static LocalDate _dayIn(int year, int month, int day) {
    final first = LocalDate(year, month, 1);
    return LocalDate(first.year, first.month, min(day, first.daysInMonth));
  }

  static String? _amount(
    RecurringTemplate t,
    List<Account> accounts,
    List<Currency> currencies,
  ) {
    final code = accounts.byId(t.accountId)?.currencyCode;
    final currency = currencies.where((c) => c.code == code).firstOrNull;
    if (currency == null) return null;
    final amount = MoneyFormatter.format(
      Money(t.amount, currency.code),
      currency.format,
    );
    return '${currency.code} $amount';
  }
}
