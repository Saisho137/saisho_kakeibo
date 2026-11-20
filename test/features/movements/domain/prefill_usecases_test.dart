import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement_draft.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payee_suggestions.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/prefill_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockMovementRepository extends Mock implements MovementRepository;

class _MockAccountRepository extends Mock implements AccountRepository;

void main() {
  late _MockMovementRepository movements;
  late _MockAccountRepository accounts;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  const peaje = Payee(id: 7, name: 'Peaje', key: 'peaje');
  const uber = Payee(id: 8, name: 'Uber', key: 'uber');
  final cash = account(id: 1);
  final main = account(id: 2, isMain: true);
  final old = account(id: 3, isArchived: true);

  setUpAll(() => registerFallbackValue(MovementType.expense));

  setUp(() {
    movements = _MockMovementRepository();
    accounts = _MockAccountRepository();
    when(() => accounts.getAccounts())
        .thenAnswer((_) async => Ok([cash, main, old]));
    when(() => movements.getPayees())
        .thenAnswer((_) async => const Ok([peaje, uber]));
    when(() => movements.lastOfCategory(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => movements.lastOfEachPayee(any())).thenAnswer(
      (_) async => Ok([movement(id: 4, categoryId: 10, payeeId: 7, amount: 9)]),
    );
  });

  Future<MovementDraft> prefill({int? categoryId, int? payeeId}) async =>
      (await PrefillMovement(movements: movements, accounts: accounts)(
        PrefillMovementParams(
          type: MovementType.expense,
          categoryId: categoryId,
          payeeId: payeeId,
        ),
      ) as Ok<MovementDraft>).value;

  group('PrefillMovement', () {
    test('a category without history uses the main account', () async {
      final draft = await prefill(categoryId: 10);

      expect(draft.categoryId, 10);
      expect(draft.accountId, 2);
      expect(draft.payeeName, isNull);
      expect(draft.amount, isNull);
    });

    test('a category brings the account and payee of its last use', () async {
      when(() => movements.lastOfCategory(10))
          .thenAnswer((_) async => Ok(movement(categoryId: 10, payeeId: 8)));

      final draft = await prefill(categoryId: 10);

      expect(draft.accountId, 1);
      expect(draft.payeeName, 'Uber');
    });

    test('an archived last account falls back to the main one', () async {
      when(() => movements.lastOfCategory(10))
          .thenAnswer((_) async => Ok(movement(accountId: 3, categoryId: 10)));

      expect((await prefill(categoryId: 10)).accountId, 2);
    });

    test('a payee brings its category, account and amount', () async {
      final draft = await prefill(payeeId: 7);

      expect(draft.categoryId, 10);
      expect(draft.accountId, 1);
      expect(draft.payeeName, 'Peaje');
      expect(draft.amount, 9);
    });

    test('propagates failures', () async {
      PrefillMovement use() =>
          PrefillMovement(movements: movements, accounts: accounts);
      when(() => movements.lastOfEachPayee(any()))
          .thenAnswer((_) async => dbError);
      expect(
        await use()(
          const PrefillMovementParams(type: MovementType.expense, payeeId: 7),
        ),
        isA<Err<MovementDraft>>(),
      );
      when(() => movements.lastOfCategory(any()))
          .thenAnswer((_) async => dbError);
      expect(
        await use()(
          const PrefillMovementParams(
            type: MovementType.expense,
            categoryId: 1,
          ),
        ),
        isA<Err<MovementDraft>>(),
      );
      when(() => accounts.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        await use()(const PrefillMovementParams(type: MovementType.expense)),
        isA<Err<MovementDraft>>(),
      );
    });
  });

  group('GetPayeeSuggestions', () {
    test('lists the payees used with the type', () async {
      final result = await GetPayeeSuggestions(movements)(MovementType.expense);

      expect((result as Ok<List<Payee>>).value, [peaje]);
    });

    test('propagates failures', () async {
      when(() => movements.getPayees()).thenAnswer((_) async => dbError);
      expect(
        await GetPayeeSuggestions(movements)(MovementType.income),
        isA<Err<List<Payee>>>(),
      );
    });
  });

  group('SuggestPeriodStart', () {
    Future<bool?> suggest(int days) async {
      final result = await SuggestPeriodStart(movements)(
        SuggestPeriodStartParams(date: movementDay.addDays(days), minDays: 21),
      );
      return result is Ok<bool> ? result.value : null;
    }

    test('suggests a first period and one after N days', () async {
      when(() => movements.lastPeriodStart())
          .thenAnswer((_) async => const Ok(null));
      expect(await suggest(0), isTrue);

      when(() => movements.lastPeriodStart())
          .thenAnswer((_) async => Ok(movementDay));
      expect(await suggest(20), isFalse);
      expect(await suggest(21), isTrue);
    });

    test('propagates failures', () async {
      when(() => movements.lastPeriodStart()).thenAnswer((_) async => dbError);
      expect(await suggest(0), isNull);
    });
  });

  group('simple reads', () {
    test('delegate to the repository', () async {
      when(() => movements.findById(4))
          .thenAnswer((_) async => Ok(movement(id: 4)));

      expect((await GetMovement(movements)(4) as Ok<Movement?>).value?.id, 4);
      expect(
        (await GetPayees(movements)(const NoParams()) as Ok<List<Payee>>).value,
        [peaje, uber],
      );
    });
  });
}
