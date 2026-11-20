import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/adjust_account_balance.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_account_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockMovementRepository extends Mock implements MovementRepository;

class _MockAccountRepository extends Mock implements AccountRepository;

class _MockCategoryRepository extends Mock implements CategoryRepository;

void main() {
  late _MockMovementRepository movements;
  late _MockAccountRepository accounts;
  late _MockCategoryRepository categories;

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

  setUpAll(() => registerFallbackValue(movement()));

  setUp(() {
    movements = _MockMovementRepository();
    accounts = _MockAccountRepository();
    categories = _MockCategoryRepository();
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
  );

  group('reads and delete', () {
    test('delegate to the repository', () async {
      when(() => movements.watchByAccount(1))
          .thenAnswer((_) => Stream.value([movement()]));
      when(() => movements.watchPayees()).thenAnswer(
        (_) => Stream.value([const Payee(id: 1, name: 'A', key: 'a')]),
      );

      expect(await WatchAccountMovements(movements)(1).first, [movement()]);
      expect(
        await WatchPayees(movements)(const NoParams()).first,
        hasLength(1),
      );
      await DeleteMovement(movements)(4);
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
