import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/transfer_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_transfer_category.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockMovementRepository extends Mock implements MovementRepository;

class _MockCategoryRepository extends Mock implements CategoryRepository;

void main() {
  final cash = account(id: 1, type: AccountType.cash);
  final bank = account(id: 2);
  final lulo = account(id: 3);
  final fund = account(id: 4, type: AccountType.pocket, parentAccountId: 3);
  final trip = account(id: 5, type: AccountType.pocket, parentAccountId: 3);
  final visa = account(id: 6, type: AccountType.creditCard);
  final cdt = account(id: 7, type: AccountType.investment);
  final usd = account(id: 8, currencyCode: 'USD');

  group('TransferRules.suggestedRole', () {
    test('follows the vault table in order', () {
      CategoryRole role(Account from, Account to) =>
          TransferRules.suggestedRole(from, to);

      expect(role(bank, fund), CategoryRole.savings);
      expect(role(usd, fund), CategoryRole.savings);
      expect(role(fund, bank), CategoryRole.savingsWithdrawal);
      expect(role(bank, cdt), CategoryRole.investing);
      expect(role(cdt, bank), CategoryRole.investmentWithdrawal);
      expect(role(bank, visa), CategoryRole.cardPayment);
      expect(role(visa, cash), CategoryRole.cashAdvance);
      expect(role(visa, bank), CategoryRole.cashAdvance);
      expect(role(bank, cash), CategoryRole.cashWithdrawal);
      expect(role(usd, bank), CategoryRole.currencyExchange);
      expect(role(bank, lulo), CategoryRole.betweenAccounts);
      expect(role(cash, visa), CategoryRole.betweenAccounts);
    });
  });

  group('TransferRules.isInternal', () {
    test('only inside one account and its pockets', () {
      expect(TransferRules.isInternal(lulo, fund), isTrue);
      expect(TransferRules.isInternal(fund, lulo), isTrue);
      expect(TransferRules.isInternal(fund, trip), isTrue);
      expect(TransferRules.isInternal(bank, fund), isFalse);
      expect(TransferRules.isInternal(bank, lulo), isFalse);
      expect(TransferRules.isInternal(lulo, lulo), isFalse);
    });
  });

  group('SuggestTransferCategory', () {
    late _MockMovementRepository movements;
    late _MockCategoryRepository categories;
    final savings = category(
      id: 20,
      type: CategoryType.transfer,
      role: CategoryRole.savings,
    );
    final between = category(
      id: 21,
      type: CategoryType.transfer,
      role: CategoryRole.betweenAccounts,
    );
    final rent = category(id: 22, type: CategoryType.transfer);
    final old = category(id: 23, type: CategoryType.transfer, isArchived: true);

    setUp(() {
      movements = _MockMovementRepository();
      categories = _MockCategoryRepository();
      when(() => categories.getCategories())
          .thenAnswer((_) async => Ok([savings, between, rent, old]));
      when(() => movements.lastTransfer(any(), any()))
          .thenAnswer((_) async => const Ok(null));
    });

    Future<int?> suggest(Account from, Account to) async {
      final result = await SuggestTransferCategory(
        movements: movements,
        categories: categories,
      )(SuggestTransferCategoryParams(from: from, to: to));
      return (result as Ok<int?>).value;
    }

    test('uses the last category of the same pair first', () async {
      when(() => movements.lastTransfer(2, 4))
          .thenAnswer((_) async => Ok(movement(categoryId: 22)));

      expect(await suggest(bank, fund), 22);
    });

    test('skips an archived last category and applies the rule', () async {
      when(() => movements.lastTransfer(2, 4))
          .thenAnswer((_) async => Ok(movement(categoryId: 23)));

      expect(await suggest(bank, fund), 20);
    });

    test('falls back to Between accounts', () async {
      expect(await suggest(bank, cash), 21);
    });

    test('propagates failures', () async {
      final use = SuggestTransferCategory(
        movements: movements,
        categories: categories,
      );
      when(() => movements.lastTransfer(any(), any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      expect(
        await use(SuggestTransferCategoryParams(from: bank, to: cash)),
        isA<Err<int?>>(),
      );
      when(() => categories.getCategories())
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      expect(
        await use(SuggestTransferCategoryParams(from: bank, to: cash)),
        isA<Err<int?>>(),
      );
    });
  });
}
