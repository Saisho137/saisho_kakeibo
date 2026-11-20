import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/services/accounts_overview.dart';

import '../../../../helpers/account_fixtures.dart';

void main() {
  Money cop(int minor) => Money(minor, 'COP');

  // The example of Pantallas → Accounts.
  final accounts = [
    account(
      id: 1,
      name: 'Bancolombia',
      includeInBalance: true,
      isMain: true,
      sortOrder: 1,
    ),
    account(
      id: 2,
      type: AccountType.cash,
      name: 'Cash',
      includeInBalance: true,
    ),
    account(id: 3, name: 'Lulo', sortOrder: 2),
    account(
      id: 4,
      type: AccountType.pocket,
      name: 'Emergency fund',
      parentAccountId: 3,
    ),
    account(
      id: 5,
      type: AccountType.creditCard,
      name: 'Visa',
      creditLimit: 3000000,
      paymentDay: 15,
    ),
    account(id: 6, type: AccountType.investment, name: 'Fiducuenta'),
    account(id: 7, name: 'Dollars', currencyCode: 'USD'),
    account(
      id: 8,
      name: 'Old card',
      type: AccountType.creditCard,
      creditLimit: 1,
      paymentDay: 1,
      isArchived: true,
    ),
  ];
  final balances = {
    1: 3900000,
    2: 350000,
    3: 2000000,
    4: 3000000,
    5: -1200000,
    6: 20000000,
    7: 500,
    8: 0,
  };

  AccountsOverview build({bool showArchived = false}) => AccountsOverview.build(
    accounts: accounts,
    balances: balances,
    currencyCode: 'COP',
    showArchived: showArchived,
  );

  group('AccountsOverview', () {
    test('adds every account of the currency to the total balance', () {
      expect(build().totalBalance, cop(28050000));
    });

    test('adds only the accounts in the Balance to the balance', () {
      expect(build().balance, cop(4250000));
    });

    test('groups visible accounts in order', () {
      final groups = build().groups;

      expect(groups.keys, AccountGroup.values);
      expect(groups[AccountGroup.cashAndBank]!.map((l) => l.account.name), [
        'Cash',
        'Bancolombia',
        'Lulo',
      ]);
      expect(groups[AccountGroup.creditCards], hasLength(1));
    });

    test('a parent shows its pockets and the free money', () {
      final lulo = build().groups[AccountGroup.cashAndBank]!.last;

      expect(lulo.balance, cop(5000000));
      expect(lulo.free, cop(2000000));
      expect(lulo.pockets.single.account.name, 'Emergency fund');
      expect(lulo.pockets.single.balance, cop(3000000));
    });

    test('a credit card shows the limit left', () {
      final visa = build().groups[AccountGroup.creditCards]!.single;

      expect(visa.available, cop(1800000));
      expect(visa.free, isNull);
    });

    test('lists archived accounts only when asked', () {
      expect(
        build(showArchived: true).groups[AccountGroup.creditCards],
        hasLength(2),
      );
    });

    test('falls back to the opening balance and leaves out empty groups', () {
      final overview = AccountsOverview.build(
        accounts: [account(id: 1, openingBalance: 700)],
        balances: const {},
        currencyCode: 'COP',
      );

      expect(overview.totalBalance, cop(700));
      expect(overview.groups.keys, [AccountGroup.cashAndBank]);
      expect(
        AccountsOverview.build(
          accounts: const [],
          balances: const {},
          currencyCode: 'COP',
        ).isEmpty,
        isTrue,
      );
    });
  });
}
