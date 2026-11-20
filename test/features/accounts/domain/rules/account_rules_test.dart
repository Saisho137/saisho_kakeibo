import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';

import '../../../../helpers/account_fixtures.dart';

void main() {
  final bank = account(id: 1, currencyCode: 'USD', includeInBalance: true);

  group('AccountRules.normalize', () {
    test('cleans the name and clears fields of other types', () {
      final result = AccountRules.normalize(
        account(
          id: 2,
          type: AccountType.cash,
          name: '  my   wallet ',
          isMain: true,
          parentAccountId: 1,
          creditLimit: 100,
          paymentDay: 5,
        ),
      );

      expect(result.name, 'My wallet');
      expect(result.isMain, isFalse);
      expect(result.parentAccountId, isNull);
      expect(result.creditLimit, isNull);
      expect(result.paymentDay, isNull);
    });

    test('a pocket copies currency and Balance inclusion from its parent', () {
      final result = AccountRules.normalize(
        account(id: 2, type: AccountType.pocket, parentAccountId: 1),
        parent: bank,
      );

      expect(result.currencyCode, 'USD');
      expect(result.includeInBalance, isTrue);
      expect(result.parentAccountId, 1);
    });

    test('keeps the credit card fields and the main bank mark', () {
      final card = AccountRules.normalize(
        account(
          id: 2,
          type: AccountType.creditCard,
          creditLimit: 100,
          paymentDay: 5,
        ),
      );
      final main = AccountRules.normalize(account(id: 1, isMain: true));

      expect(card.creditLimit, 100);
      expect(card.paymentDay, 5);
      expect(main.isMain, isTrue);
    });
  });

  group('AccountRules.validate', () {
    test('accepts a valid account', () {
      expect(AccountRules.validate(bank), isEmpty);
    });

    test('requires a name of at most 40 characters', () {
      expect(AccountRules.validate(bank.copyWith(name: ' ')), {
        AccountError.emptyName,
      });
      expect(AccountRules.validate(bank.copyWith(name: 'x' * 41)), {
        AccountError.nameTooLong,
      });
    });

    test('a pocket needs an active bank parent other than itself', () {
      final pocket = account(id: 2, type: AccountType.pocket);

      expect(AccountRules.validate(pocket), {AccountError.missingParent});
      expect(
        AccountRules.validate(
          pocket.copyWith(parentAccountId: 3),
          parent: account(id: 3, type: AccountType.cash),
        ),
        {AccountError.invalidParent},
      );
      expect(
        AccountRules.validate(
          pocket.copyWith(parentAccountId: 1),
          parent: bank.copyWith(isArchived: true),
        ),
        {AccountError.invalidParent},
      );
      expect(
        AccountRules.validate(
          pocket.copyWith(parentAccountId: 1),
          parent: bank.copyWith(isArchived: true),
          parentMayBeArchived: true,
        ),
        isEmpty,
      );
      expect(
        AccountRules.validate(
          pocket.copyWith(parentAccountId: 1),
          parent: bank,
        ),
        isEmpty,
      );
    });

    test('a credit card needs a limit and a payment day', () {
      final card = account(id: 2, type: AccountType.creditCard);

      expect(AccountRules.validate(card), {
        AccountError.invalidCreditLimit,
        AccountError.invalidPaymentDay,
      });
      expect(
        AccountRules.validate(card.copyWith(creditLimit: 0, paymentDay: 32)),
        {AccountError.invalidCreditLimit, AccountError.invalidPaymentDay},
      );
      expect(
        AccountRules.validate(card.copyWith(creditLimit: 1, paymentDay: 31)),
        isEmpty,
      );
    });
  });

  group('AccountType', () {
    test('groups pockets with cash and bank accounts', () {
      expect(AccountType.pocket.group, AccountGroup.cashAndBank);
      expect(AccountType.creditCard.group, AccountGroup.creditCards);
      expect(AccountType.investment.group, AccountGroup.investments);
    });

    test('suggests an icon per type', () {
      expect(
        AccountType.values.map((t) => t.defaultIconKey).toSet(),
        hasLength(AccountType.values.length),
      );
    });
  });
}
