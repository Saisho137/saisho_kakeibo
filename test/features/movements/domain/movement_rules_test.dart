import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

void main() {
  final cop = account(id: 1);
  final cop2 = account(id: 2);
  final usd = account(id: 3, currencyCode: 'USD');
  final food = category(id: 10);
  final salary = category(id: 11, type: CategoryType.income);
  final savings = category(id: 12, type: CategoryType.transfer);

  group('Movement.effectOn', () {
    test('follows the type and the side of the account', () {
      expect(movement(type: MovementType.income).effectOn(1), 1000);
      expect(
        movement(type: MovementType.income, isPending: true).effectOn(1),
        0,
      );
      expect(movement().effectOn(1), -1000);
      expect(
        movement(type: MovementType.adjustment, amount: -5).effectOn(1),
        -5,
      );
      expect(movement().effectOn(2), 0);

      final transfer = movement(
        type: MovementType.transfer,
        toAccountId: 2,
        toAmount: 4,
      );
      expect(transfer.effectOn(1), -1000);
      expect(transfer.effectOn(2), 4);
      expect(transfer.involves(2), isTrue);
      expect(transfer.involves(3), isFalse);
    });
  });

  group('MovementRules.normalize', () {
    test('trims the note and clears fields of other types', () {
      final normalized = MovementRules.normalize(
        movement(
          note: '  ',
          toAccountId: 2,
          toAmount: 5,
          payeeId: 7,
          categoryId: 10,
        ).copyWith(startsPeriod: true),
      );

      expect(normalized.note, isNull);
      expect(normalized.toAccountId, isNull);
      expect(normalized.toAmount, isNull);
      expect(normalized.payeeId, 7);
      expect(normalized.startsPeriod, isFalse);
    });

    test('a transfer has no payee and receives what it sends in one '
        'currency', () {
      Movement transfer(Account to) => MovementRules.normalize(
        movement(
          type: MovementType.transfer,
          toAccountId: to.id,
          toAmount: 7,
          payeeId: 3,
          note: ' rent ',
        ),
        account: cop,
        toAccount: to,
      );

      expect(transfer(cop2).toAmount, 1000);
      expect(transfer(cop2).payeeId, isNull);
      expect(transfer(cop2).note, 'rent');
      expect(transfer(usd).toAmount, 7);
    });

    test('an adjustment has no category', () {
      expect(
        MovementRules.normalize(
          movement(type: MovementType.adjustment, categoryId: 10),
        ).categoryId,
        isNull,
      );
    });
  });

  group('MovementRules.validate', () {
    test('accepts valid movements of every type', () {
      expect(
        MovementRules.validate(
          movement(categoryId: 10),
          account: cop,
          category: food,
          hasPayee: true,
        ),
        isEmpty,
      );
      expect(
        MovementRules.validate(
          movement(type: MovementType.income),
          account: cop,
          category: salary,
        ),
        isEmpty,
      );
      expect(
        MovementRules.validate(
          movement(type: MovementType.transfer, toAccountId: 3, toAmount: 4),
          account: cop,
          toAccount: usd,
          category: savings,
        ),
        isEmpty,
      );
      expect(
        MovementRules.validate(
          movement(type: MovementType.adjustment, amount: -3),
          account: cop,
        ),
        isEmpty,
      );
    });

    test('rejects amounts, accounts and categories that do not fit', () {
      expect(
        MovementRules.validate(
          movement(amount: 0, note: 'x' * 201),
          account: null,
          category: salary,
          hasPayee: true,
        ),
        {
          MovementError.invalidAmount,
          MovementError.missingAccount,
          MovementError.missingCategory,
          MovementError.noteTooLong,
        },
      );
      expect(
        MovementRules.validate(
          movement(type: MovementType.adjustment, amount: 0),
          account: cop,
        ),
        {MovementError.invalidAmount},
      );
    });

    test('rejects transfers to the same or no account, and payees', () {
      expect(
        MovementRules.validate(
          movement(type: MovementType.transfer, toAccountId: 1, toAmount: 0),
          account: cop,
          toAccount: cop,
          category: savings,
          hasPayee: true,
        ),
        {
          MovementError.sameAccounts,
          MovementError.invalidAmount,
          MovementError.unexpectedPayee,
        },
      );
      expect(
        MovementRules.validate(
          movement(type: MovementType.transfer, toAmount: 1),
          account: cop,
          category: savings,
        ),
        {MovementError.missingAccount},
      );
    });
  });

  group('PayeeName', () {
    test('normalizes, keys and shortens names', () {
      final name = PayeeName.parse('  peaje   Las Palmas ')!;
      expect(name.name, 'Peaje Las Palmas');
      expect(name.key, 'peajelaspalmas');
      expect(PayeeName.parse('   '), isNull);
      expect(PayeeName.parse(null), isNull);
      expect(PayeeName.parse('a' * 50)!.name, hasLength(40));
    });
  });
}
