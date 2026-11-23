import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/debt_choice.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/adjust_account_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_account_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockMovementRepository extends Mock implements MovementRepository;

class _MockAccountRepository extends Mock implements AccountRepository;

class _MockCategoryRepository extends Mock implements CategoryRepository;

class _MockRecurringRepository extends Mock implements RecurringRepository;

class _MockDebtRepository extends Mock implements DebtRepository;

void main() {
  late _MockMovementRepository movements;
  late _MockAccountRepository accounts;
  late _MockCategoryRepository categories;
  late _MockRecurringRepository recurring;
  late _MockDebtRepository debts;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final bank = account(id: 1);
  final pocket = account(id: 2, type: AccountType.pocket, parentAccountId: 1);
  final old = account(id: 3, isArchived: true);
  final food = category(id: 10);

  Matcher isValidationError() => isA<Err<dynamic>>().having(
    (e) => e.failure,
    'failure',
    isA<ValidationFailure>(),
  );

  setUpAll(() {
    registerFallbackValue(movement());
    registerFallbackValue(debt());
  });

  setUp(() {
    movements = _MockMovementRepository();
    accounts = _MockAccountRepository();
    categories = _MockCategoryRepository();
    recurring = _MockRecurringRepository();
    debts = _MockDebtRepository();
    when(() => recurring.updateAmount(any(), any(), any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => accounts.getAccounts())
        .thenAnswer((_) async => Ok([bank, pocket, old]));
    when(() => accounts.getBalances())
        .thenAnswer((_) async => const Ok({1: 5000, 2: 3000}));
    when(() => categories.getCategories()).thenAnswer((_) async => Ok([food]));
    when(() => movements.findById(any()))
        .thenAnswer((_) async => Ok(movement(id: 5, accountId: 3)));
    when(() => movements.save(any(), payee: any(named: 'payee')))
        .thenAnswer((_) async => const Ok(5));
    when(() => movements.delete(any())).thenAnswer((_) async => const Ok(null));
  });

  SaveMovement save() => SaveMovement(
    movements: movements,
    accounts: accounts,
    categories: categories,
    recurring: recurring,
    debts: debts,
  );

  group('reads and delete', () {
    test('delegate to the repository', () async {
      when(() => movements.watchByAccount(1))
          .thenAnswer((_) => Stream.value([movement()]));
      when(() => movements.watchPayees()).thenAnswer(
        (_) => Stream.value([const Payee(id: 1, name: 'A', key: 'a')]),
      );

      when(() => movements.watchAll())
          .thenAnswer((_) => Stream.value([movement()]));

      expect(await WatchAccountMovements(movements)(1).first, [movement()]);
      expect(await WatchMovements(movements)(const NoParams()).first, [
        movement(),
      ]);
      expect(
        await WatchPayees(movements)(const NoParams()).first,
        hasLength(1),
      );
      await DeleteMovement(movements, debts: debts, categories: categories)(4);
      verify(() => movements.delete(4)).called(1);
    });
  });

  group('SaveMovement', () {
    test('saves a normalized movement with its payee', () async {
      final result = await save()(
        SaveMovementParams(
          movement(categoryId: 10, payeeId: 99, note: ' lunch '),
          payeeName: ' crepes  & waffles',
        ),
      );

      expect((result as Ok<int>).value, 5);
      final captured = verify(
        () => movements.save(captureAny(), payee: captureAny(named: 'payee')),
      ).captured;
      final saved = captured.first as Movement;
      final payee = captured.last as PayeeName;
      expect(saved.note, 'lunch');
      expect(saved.payeeId, isNull);
      expect(payee.name, 'Crepes & waffles');
    });

    test(
      'rejects invalid movements and new ones in archived accounts',
      () async {
        expect(
          await save()(SaveMovementParams(movement(categoryId: 99))),
          isValidationError(),
        );
        expect(
          await save()(
            SaveMovementParams(movement(accountId: 3, categoryId: 10)),
          ),
          isValidationError(),
        );
      },
    );

    test('an archived account keeps its own movements editable', () async {
      final result = await save()(
        SaveMovementParams(movement(id: 5, accountId: 3, categoryId: 10)),
      );

      expect(result, isA<Ok<int>>());
    });

    test('confirming a pending movement updates its template', () async {
      final pending = movement(
        id: 5,
        categoryId: 10,
      ).copyWith(recurringTemplateId: 8, isPending: true);
      when(() => movements.findById(5)).thenAnswer((_) async => Ok(pending));

      await save()(SaveMovementParams(pending.copyWith(amount: 1500)));
      verifyNever(() => recurring.updateAmount(any(), any(), any()));

      await save()(
        SaveMovementParams(pending.copyWith(amount: 1500, isPending: false)),
      );
      verify(() => recurring.updateAmount(8, 1500, null)).called(1);

      when(() => recurring.updateAmount(any(), any(), any()))
          .thenAnswer((_) async => dbError);
      expect(
        await save()(SaveMovementParams(pending.copyWith(isPending: false))),
        isA<Err<int>>(),
      );
    });

    test('rejects unknown movements and failed reads', () async {
      when(() => movements.findById(7)).thenAnswer((_) async => const Ok(null));
      expect(
        await save()(SaveMovementParams(movement(id: 7, categoryId: 10))),
        isValidationError(),
      );
      when(() => movements.findById(7)).thenAnswer((_) async => dbError);
      expect(
        (await save()(
          SaveMovementParams(movement(id: 7, categoryId: 10)),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
      when(() => categories.getCategories()).thenAnswer((_) async => dbError);
      expect(
        (await save()(
          SaveMovementParams(movement(categoryId: 10)),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('SaveMovement with debts', () {
    final loanReceived = category(
      id: 20,
      type: CategoryType.income,
      role: CategoryRole.loanReceived,
      iconKey: 'request_quote',
    );
    final loanGiven = category(id: 21, role: CategoryRole.loanGiven);
    final payment = category(id: 22, role: CategoryRole.debtPayment);

    setUp(() {
      when(
        () => categories.getCategories(),
      ).thenAnswer((_) async => Ok([food, loanReceived, loanGiven, payment]));
      when(() => debts.saveDebt(any(), payee: any(named: 'payee')))
          .thenAnswer((_) async => const Ok(30));
      when(() => debts.deleteDebt(any()))
          .thenAnswer((_) async => const Ok(null));
      when(() => debts.findDebt(any())).thenAnswer((_) async => Ok(debt()));
    });

    Movement saved() =>
        verify(() => movements.save(captureAny(), payee: any(named: 'payee')))
                .captured
                .last
            as Movement;

    test('a loan received creates its debt with what is owed', () async {
      final result = await save()(
        SaveMovementParams(
          movement(type: MovementType.income, categoryId: 20, amount: 5000),
          payeeName: 'davivienda',
          debt: const NewDebt(pillarId: 1, initialPending: 6000),
        ),
      );

      expect(result, isA<Ok<int>>());
      final created =
          verify(() => debts.saveDebt(captureAny(), payee: any(named: 'payee')))
                  .captured
                  .single
              as Debt;
      expect(created.type, DebtType.iOwe);
      expect(created.name, 'Davivienda');
      expect(created.initialPending, 6000);
      expect(created.iconKey, 'request_quote');
      expect(created.pillarId, 1);
      expect(saved().debtId, 30);
    });

    test('a new loan given starts its debt at 0', () async {
      await save()(
        SaveMovementParams(
          movement(categoryId: 21),
          payeeName: 'ana',
          debt: const NewDebt(),
        ),
      );
      final created =
          verify(() => debts.saveDebt(captureAny(), payee: any(named: 'payee')))
                  .captured
                  .single
              as Debt;
      expect(created.type, DebtType.owedToMe);
      expect(created.initialPending, 0);
      expect(created.name, 'Ana');
    });

    test('a payment of an existing debt takes the debt payee', () async {
      await save()(
        SaveMovementParams(
          movement(categoryId: 22),
          payeeName: 'ignored',
          debt: const ExistingDebt(1),
        ),
      );
      final captured = verify(
        () => movements.save(captureAny(), payee: captureAny(named: 'payee')),
      ).captured;
      final m = captured.first as Movement;
      expect(m.debtId, 1);
      expect(m.payeeId, debt().payeeId);
      expect(captured.last, isNull);
    });

    test('a debt category needs a debt that fits', () async {
      for (final params in [
        SaveMovementParams(movement(categoryId: 22)),
        SaveMovementParams(movement(categoryId: 22), debt: const NewDebt()),
        SaveMovementParams(movement(categoryId: 21), debt: const NewDebt()),
        SaveMovementParams(
          movement(type: MovementType.income, categoryId: 20),
          payeeName: 'Bank',
          debt: const NewDebt(),
        ),
      ]) {
        expect(await save()(params), isValidationError());
      }
      when(() => debts.findDebt(any()))
          .thenAnswer((_) async => Ok(debt(type: DebtType.owedToMe)));
      expect(
        await save()(
          SaveMovementParams(
            movement(categoryId: 22),
            debt: const ExistingDebt(1),
          ),
        ),
        isValidationError(),
      );
      when(() => debts.findDebt(any())).thenAnswer((_) async => dbError);
      expect(
        await save()(
          SaveMovementParams(
            movement(categoryId: 22),
            debt: const ExistingDebt(1),
          ),
        ),
        isA<Err<int>>(),
      );
    });

    test('a failed movement deletes the debt it created', () async {
      when(() => movements.save(any(), payee: any(named: 'payee')))
          .thenAnswer((_) async => dbError);
      await save()(
        SaveMovementParams(
          movement(categoryId: 21),
          payeeName: 'Ana',
          debt: const NewDebt(),
        ),
      );
      verify(() => debts.deleteDebt(30)).called(1);

      when(() => debts.saveDebt(any(), payee: any(named: 'payee')))
          .thenAnswer((_) async => dbError);
      expect(
        await save()(
          SaveMovementParams(
            movement(categoryId: 21),
            payeeName: 'Ana',
            debt: const NewDebt(),
          ),
        ),
        isA<Err<int>>(),
      );
    });

    test('debt choices compare by value', () {
      expect(const ExistingDebt(1), const ExistingDebt(1));
      expect(const ExistingDebt(1).hashCode, const ExistingDebt(1).hashCode);
      expect(const NewDebt(pillarId: 1), const NewDebt(pillarId: 1));
      expect(
        const NewDebt(pillarId: 1).hashCode,
        const NewDebt(pillarId: 1).hashCode,
      );
    });
  });

  group('DeleteMovement', () {
    final loanGiven = category(id: 21, role: CategoryRole.loanGiven);

    DeleteMovement delete() =>
        DeleteMovement(movements, debts: debts, categories: categories);

    setUp(() {
      when(() => categories.getCategories())
          .thenAnswer((_) async => Ok([food, loanGiven]));
      when(() => debts.deleteDebt(any()))
          .thenAnswer((_) async => const Ok(null));
      when(() => debts.getMovements(any()))
          .thenAnswer((_) async => const Ok([]));
    });

    test('deleting the loan that created a debt deletes the debt', () async {
      when(() => movements.findById(4)).thenAnswer(
        (_) async => Ok(movement(id: 4, categoryId: 21).copyWith(debtId: 7)),
      );
      await delete()(4);
      verify(() => debts.deleteDebt(7)).called(1);
    });

    test('a debt with other movements or a payment stays', () async {
      when(() => movements.findById(4)).thenAnswer(
        (_) async => Ok(movement(id: 4, categoryId: 21).copyWith(debtId: 7)),
      );
      when(() => debts.getMovements(7))
          .thenAnswer((_) async => Ok([movement(id: 5)]));
      await delete()(4);
      when(() => movements.findById(6)).thenAnswer(
        (_) async => Ok(movement(id: 6, categoryId: 10).copyWith(debtId: 8)),
      );
      await delete()(6);
      verifyNever(() => debts.deleteDebt(any()));
    });

    test('propagates failures', () async {
      when(() => movements.findById(4)).thenAnswer((_) async => dbError);
      expect(await delete()(4), isA<Err<void>>());
      when(() => movements.findById(4)).thenAnswer(
        (_) async => Ok(movement(id: 4, categoryId: 21).copyWith(debtId: 7)),
      );
      when(() => debts.getMovements(7)).thenAnswer((_) async => dbError);
      expect(await delete()(4), isA<Err<void>>());
    });
  });

  group('AdjustAccountBalance', () {
    AdjustAccountBalance adjust() =>
        AdjustAccountBalance(accounts: accounts, movements: movements);

    AdjustAccountBalanceParams to(int balance, {int id = 1}) =>
        AdjustAccountBalanceParams(
          accountId: id,
          actualBalance: balance,
          date: movementDay,
        );

    test('saves the difference with pockets on the parent', () async {
      await adjust()(to(7500));

      final saved =
          verify(() => movements.save(captureAny())).captured.single
              as Movement;
      expect(saved.type, MovementType.adjustment);
      expect(saved.accountId, 1);
      expect(saved.amount, -500);
      expect(saved.date, movementDay);
    });

    test('saves nothing when the balance already matches', () async {
      expect(await adjust()(to(8000)), isA<Ok<void>>());
      verifyNever(() => movements.save(any()));
    });

    test('rejects unknown accounts and propagates failures', () async {
      expect(await adjust()(to(1, id: 99)), isValidationError());
      when(() => movements.save(any())).thenAnswer((_) async => dbError);
      expect((await adjust()(to(1)) as Err).failure, isA<DatabaseFailure>());
      when(() => accounts.getBalances()).thenAnswer((_) async => dbError);
      expect((await adjust()(to(1)) as Err).failure, isA<DatabaseFailure>());
    });
  });
}
