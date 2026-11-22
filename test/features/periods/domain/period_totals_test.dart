import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_totals.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  final bank = account(id: 1);
  final cash = account(id: 2, type: AccountType.cash);
  final pocket = account(id: 3, type: AccountType.pocket, parentAccountId: 1);
  final usd = account(id: 4, currencyCode: 'USD');
  final accounts = [bank, cash, pocket, usd];

  Map<String, CurrencyTotals> totals(List<Movement> movements) =>
      PeriodTotals.of(movements, accounts);

  group('PeriodTotals', () {
    test('is empty without movements', () {
      expect(totals([]), isEmpty);
    });

    test('adds incomes and expenses by currency', () {
      expect(
        totals([
          movement(type: MovementType.income, amount: 5000),
          movement(amount: 1200),
          movement(accountId: 2, amount: 300),
          movement(accountId: 4, amount: 7),
        ]),
        {
          'COP': const CurrencyTotals(income: 5000, expenses: 1500),
          'USD': const CurrencyTotals(expenses: 7),
        },
      );
    });

    test('a pending income waits, a pending expense counts', () {
      expect(
        totals([
          movement(type: MovementType.income, amount: 5000, isPending: true),
          movement(amount: 800, isPending: true),
        ]),
        {'COP': const CurrencyTotals(expenses: 800)},
      );
    });

    test('adjustments add to no total', () {
      expect(
        totals([movement(type: MovementType.adjustment, amount: -400)]),
        isEmpty,
      );
    });

    test('a transfer adds once in its currency', () {
      expect(
        totals([
          movement(type: MovementType.transfer, toAccountId: 2, toAmount: 1000),
        ]),
        {'COP': const CurrencyTotals(transfers: 1000)},
      );
    });

    test('between currencies each side adds to its own', () {
      expect(
        totals([
          movement(
            type: MovementType.transfer,
            accountId: 4,
            amount: 10000,
            toAccountId: 1,
            toAmount: 41000000,
          ),
        ]),
        {
          'USD': const CurrencyTotals(transfers: 10000),
          'COP': const CurrencyTotals(transfers: 41000000),
        },
      );
    });

    test('a transfer inside an account adds nothing', () {
      expect(
        totals([
          movement(type: MovementType.transfer, toAccountId: 3),
          movement(type: MovementType.transfer, accountId: 3, toAccountId: 1),
        ]),
        isEmpty,
      );
    });

    test('skips movements of unknown accounts', () {
      expect(
        totals([
          movement(accountId: 99),
          movement(type: MovementType.transfer, toAccountId: 99),
        ]),
        isEmpty,
      );
    });

    test('byCategory ranks the categories of a type in a currency', () {
      final movements = [
        movement(categoryId: 1, amount: 100),
        movement(categoryId: 2, amount: 300),
        movement(categoryId: 1, amount: 50),
        movement(categoryId: 1, accountId: 4, amount: 9),
        movement(amount: 70),
        movement(type: MovementType.income, categoryId: 3, amount: 5),
        movement(
          type: MovementType.income,
          categoryId: 3,
          amount: 5,
          isPending: true,
        ),
      ];
      expect(
        PeriodTotals.byCategory(
          movements,
          accounts,
          currencyCode: 'COP',
          type: MovementType.expense,
        ),
        [(categoryId: 2, amount: 300), (categoryId: 1, amount: 150)],
      );
      expect(
        PeriodTotals.byCategory(
          movements,
          accounts,
          currencyCode: 'COP',
          type: MovementType.income,
        ),
        [(categoryId: 3, amount: 5)],
      );
    });
  });
}
