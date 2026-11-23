import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movement_dao.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

import '../../../helpers/movement_fixtures.dart';

class _MockMovementDao extends Mock implements MovementDao;

void main() {
  late AppDatabase db;
  late MovementRepositoryImpl repository;
  late AccountRepositoryImpl accounts;
  late CategoryRepositoryImpl categories;
  late int cash;
  late int bank;
  late int food;
  late int salary;
  late int savings;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = MovementRepositoryImpl(db.movementDao);
    accounts = AccountRepositoryImpl(db.accountDao);
    categories = CategoryRepositoryImpl(db.categoryDao);
    final stored = (await accounts.getAccounts() as Ok<List<Account>>).value;
    cash = stored.firstWhere((a) => a.type == AccountType.cash).id;
    bank = stored.firstWhere((a) => a.isMain).id;
    final all = (await categories.getCategories() as Ok<List<Category>>).value;
    food = all.firstWhere((c) => c.name == 'Eating out').id;
    salary = all.firstWhere((c) => c.role == CategoryRole.salary).id;
    savings = all.firstWhere((c) => c.role == CategoryRole.savings).id;
  });

  tearDown(() => db.close());

  Future<int> save(Movement m, {String? payee}) async => (await repository.save(
    m,
    payee: PayeeName.parse(payee),
  ) as Ok<int>).value;

  group('MovementRepositoryImpl', () {
    test('saves, finds, updates and deletes a movement', () async {
      final id = await save(movement(accountId: cash, categoryId: food));

      final found = (await repository.findById(id) as Ok<Movement?>).value;
      expect(found, movement(id: id, accountId: cash, categoryId: food));

      await save(found!.copyWith(amount: 2500, note: 'Lunch'));
      final updated = (await repository.findById(id) as Ok<Movement?>).value;
      expect(updated?.amount, 2500);
      expect(updated?.note, 'Lunch');

      await repository.delete(id);
      expect((await repository.findById(id) as Ok<Movement?>).value, isNull);
    });

    test('reuses a payee by key and creates new ones', () async {
      final first = await save(
        movement(accountId: cash, categoryId: food),
        payee: 'Peaje Palmas',
      );
      final second = await save(
        movement(accountId: cash, categoryId: food),
        payee: ' peaje  palmas',
      );
      await save(
        movement(accountId: cash, categoryId: food),
        payee: 'Uber',
      );

      final payees = await repository.watchPayees().first;
      expect(payees.map((p) => p.name), ['Peaje Palmas', 'Uber']);
      final a = (await repository.findById(first) as Ok<Movement?>).value!;
      final b = (await repository.findById(second) as Ok<Movement?>).value!;
      expect(a.payeeId, b.payeeId);
    });

    test('streams the movements of an account, newest first', () async {
      await save(movement(accountId: cash, categoryId: food));
      final later = await save(
        movement(
          accountId: bank,
          categoryId: savings,
          type: MovementType.transfer,
          toAccountId: cash,
          toAmount: 1000,
          date: movementDay.addDays(1),
        ),
      );
      await save(movement(accountId: bank, categoryId: food));

      final listed = await repository.watchByAccount(cash).first;
      expect(listed.map((m) => m.id).first, later);
      expect(listed, hasLength(2));
    });

    test('translates database errors into failures', () async {
      final dao = _MockMovementDao();
      when(() => dao.findById(any())).thenThrow(Exception('disk'));
      expect(
        (await MovementRepositoryImpl(dao).findById(1) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('balances and usage', () {
    test('add every kind of movement to the opening balance', () async {
      await save(
        movement(
          type: MovementType.income,
          accountId: cash,
          amount: 900,
        ).copyWith(categoryId: salary),
      );
      await save(
        movement(
          type: MovementType.income,
          accountId: cash,
          amount: 5000,
          isPending: true,
        ).copyWith(categoryId: salary),
      );
      await save(movement(accountId: cash, amount: 200, categoryId: food));
      await save(
        movement(type: MovementType.adjustment, accountId: cash, amount: -50),
      );
      await save(
        movement(
          type: MovementType.transfer,
          accountId: bank,
          amount: 300,
          toAccountId: cash,
          toAmount: 300,
          categoryId: savings,
        ),
      );

      final balances =
          (await accounts.getBalances() as Ok<Map<int, int>>).value;
      expect(balances[cash], 900 - 200 - 50 + 300);
      expect(balances[bank], -300);
      expect((await accounts.watchBalances().first)[cash], 950);
    });

    test('accounts with movements are known', () async {
      await save(
        movement(
          type: MovementType.transfer,
          accountId: bank,
          toAccountId: cash,
          toAmount: 1000,
          categoryId: savings,
        ),
      );

      expect((await accounts.hasMovements(cash) as Ok<bool>).value, isTrue);
      expect((await accounts.hasMovements(bank) as Ok<bool>).value, isTrue);
      expect((await accounts.hasMovements(999) as Ok<bool>).value, isFalse);
    });

    test('a deleted category hands its movements over', () async {
      final all =
          (await categories.getCategories() as Ok<List<Category>>).value;
      final car = all.firstWhere((c) => c.name == 'Car').id;
      final uncategorized = all
          .firstWhere((c) => c.role == CategoryRole.uncategorized)
          .id;
      final id = await save(movement(accountId: cash, categoryId: car));

      expect((await categories.countMovements(car) as Ok<int>).value, 1);
      await categories.delete(car, reassignTo: uncategorized);

      final moved = (await repository.findById(id) as Ok<Movement?>).value;
      expect(moved?.categoryId, uncategorized);
    });

    test('finds the last use of a category and of each payee', () async {
      expect(
        (await repository.lastOfCategory(food) as Ok<Movement?>).value,
        isNull,
      );
      await save(
        movement(accountId: cash, categoryId: food),
        payee: 'Uber',
      );
      final latest = await save(
        movement(accountId: bank, categoryId: food, amount: 7),
        payee: 'Uber',
      );
      await save(
        movement(
          type: MovementType.income,
          accountId: cash,
          categoryId: salary,
        ),
        payee: 'Pragma',
      );

      expect(
        (await repository.lastOfCategory(food) as Ok<Movement?>).value?.id,
        latest,
      );
      final last = (await repository.lastOfEachPayee(
        MovementType.expense,
      ) as Ok<List<Movement>>).value;
      expect(last.map((m) => m.id), [latest]);
      expect((await repository.getPayees() as Ok).value, hasLength(2));
    });

    test('watches every movement, newest first', () async {
      for (final days in [-1, 5, 0]) {
        await save(
          movement(
            accountId: cash,
            categoryId: food,
            date: movementDay.addDays(days),
          ),
        );
      }

      expect(
        (await repository.getAll() as Ok<List<Movement>>).value,
        hasLength(3),
      );
      expect(
        repository.watchAll(),
        emits(
          isA<List<Movement>>().having(
            (list) => list.map((m) => m.date),
            'dates',
            [movementDay.addDays(5), movementDay, movementDay.addDays(-1)],
          ),
        ),
      );
    });

    test('finds the last transfer between two accounts', () async {
      expect(
        (await repository.lastTransfer(bank, cash) as Ok<Movement?>).value,
        isNull,
      );
      Movement transfer(int from, int to) => movement(
        type: MovementType.transfer,
        accountId: from,
        toAccountId: to,
        toAmount: 1000,
        categoryId: savings,
      );
      final id = await save(transfer(bank, cash));
      await save(transfer(cash, bank));

      expect(
        (await repository.lastTransfer(bank, cash) as Ok<Movement?>).value?.id,
        id,
      );
    });
  });
}
