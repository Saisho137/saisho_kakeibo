import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/home/domain/services/home_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  final cash = account(id: 1, type: AccountType.cash, includeInBalance: true);
  final bank = account(id: 2, includeInBalance: true);
  final pocket = account(
    id: 3,
    type: AccountType.pocket,
    parentAccountId: 2,
    includeInBalance: true,
  );
  final other = account(id: 4);
  final usd = account(id: 5, currencyCode: 'USD', includeInBalance: true);
  final accounts = [cash, bank, pocket, other, usd];
  const balances = {1: 100, 2: 200, 3: 30, 4: 4000, 5: 7};

  Money balance(BalanceFilter filter, {String code = 'COP'}) => homeBalance(
    accounts: accounts,
    balances: balances,
    currencyCode: code,
    filter: filter,
  );

  group('homeBalance', () {
    test('sums the accounts in the Balance of the currency', () {
      expect(balance(BalanceFilter.both), const Money(330, 'COP'));
      expect(balance(BalanceFilter.both, code: 'USD'), const Money(7, 'USD'));
    });

    test('Cash keeps cash, Bank the rest with pockets', () {
      expect(balance(BalanceFilter.cash), const Money(100, 'COP'));
      expect(balance(BalanceFilter.bank), const Money(230, 'COP'));
    });

    test('a missing balance counts as the opening one', () {
      expect(
        homeBalance(
          accounts: [cash.copyWith(openingBalance: 9)],
          balances: const {},
          currencyCode: 'COP',
          filter: BalanceFilter.both,
        ),
        const Money(9, 'COP'),
      );
    });
  });

  group('HomeFilter', () {
    final expense = movement(accountId: 2);
    final fromCash = movement(); // Of the cash account.
    final toCash = movement(
      type: MovementType.transfer,
      accountId: 2,
      toAccountId: 1,
    );

    test('Both keeps every movement', () {
      expect(BalanceFilter.both.keepsMovement(expense, accounts), isTrue);
      expect(
        BalanceFilter.both.keepsMovement(movement(accountId: 99), []),
        isTrue,
      );
    });

    test('keeps the movements of a kept account', () {
      expect(BalanceFilter.cash.keepsMovement(fromCash, accounts), isTrue);
      expect(BalanceFilter.cash.keepsMovement(expense, accounts), isFalse);
      expect(BalanceFilter.bank.keepsMovement(expense, accounts), isTrue);
      expect(BalanceFilter.bank.keepsMovement(fromCash, accounts), isFalse);
    });

    test('keeps a transfer when either side is kept', () {
      expect(BalanceFilter.cash.keepsMovement(toCash, accounts), isTrue);
      expect(BalanceFilter.bank.keepsMovement(toCash, accounts), isTrue);
    });

    test('drops a movement of an unknown account', () {
      expect(
        BalanceFilter.cash.keepsMovement(movement(accountId: 99), accounts),
        isFalse,
      );
    });
  });
}
