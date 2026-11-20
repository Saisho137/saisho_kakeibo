import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/account_dao.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

import '../../../../helpers/account_fixtures.dart';

class _MockAccountDao extends Mock implements AccountDao;

void main() {
  late AppDatabase db;
  late AccountRepositoryImpl repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = AccountRepositoryImpl(db.accountDao);
  });

  tearDown(() => db.close());

  Future<List<Account>> all() async =>
      (await repository.getAccounts() as Ok<List<Account>>).value;

  group('AccountRepositoryImpl', () {
    test('creates an account with every field and finds it', () async {
      final card = account(
        id: 0,
        type: AccountType.creditCard,
        name: 'Visa',
        openingBalance: -1200000,
        creditLimit: 3000000,
        paymentDay: 15,
      );

      final id = (await repository.create(card) as Ok<int>).value;
      final found = (await repository.findById(id) as Ok<Account?>).value;

      expect(found, card.copyWith(id: id));
    });

    test('creates and saves other accounts in one transaction', () async {
      final bank = (await all()).firstWhere((a) => a.isMain);

      await repository.create(
        account(id: 0, name: 'Lulo', isMain: true, sortOrder: 2),
        alsoSave: [bank.copyWith(isMain: false)],
      );

      expect((await all()).where((a) => a.isMain).map((a) => a.name), ['Lulo']);
    });

    test('lists accounts by order and streams changes', () async {
      final cash = (await all()).first;
      await repository.saveAll([cash.copyWith(sortOrder: 5)]);

      final names = (await repository.watchAccounts().first).map((a) => a.name);

      expect(names, ['Bank', 'Cash']);
    });

    test('reorders accounts', () async {
      final ids = (await all()).map((a) => a.id).toList();

      await repository.reorder(ids.reversed.toList());

      expect((await all()).map((a) => a.id), ids.reversed);
    });

    test('streams the opening balance as own balance', () async {
      final id = (await repository.create(
        account(id: 0, openingBalance: 700),
      ) as Ok<int>).value;

      final balances = await repository.watchBalances().first;

      expect(balances[id], 700);
      expect(balances, hasLength(3));
    });

    test('an account without movements has none', () async {
      expect((await repository.hasMovements(1) as Ok<bool>).value, isFalse);
    });

    test('deletes a parent and its pockets together', () async {
      final bank = (await all()).firstWhere((a) => a.isMain);
      final pocketId = (await repository.create(
        account(id: 0, type: AccountType.pocket, parentAccountId: bank.id),
      ) as Ok<int>).value;

      expect(await repository.delete([pocketId, bank.id]), isA<Ok<void>>());

      expect((await all()).map((a) => a.name), ['Cash']);
    });

    test('the database rejects an unknown currency', () async {
      final result = await repository.create(
        account(id: 0, currencyCode: 'XYZ'),
      );

      expect((result as Err).failure, isA<DatabaseFailure>());
    });

    test('translates data source exceptions into a DatabaseFailure', () async {
      final dao = _MockAccountDao();
      when(dao.getAll).thenThrow(Exception('disk full'));

      final result = await AccountRepositoryImpl(dao).getAccounts();

      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });
}
