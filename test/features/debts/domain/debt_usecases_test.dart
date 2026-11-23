import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/delete_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/edit_debt_pending.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/save_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';

import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockDebts extends Mock implements DebtRepository;

void main() {
  late _MockDebts debts;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final payment = movement(amount: 200000).copyWith(debtId: 1);

  Matcher isValidationError() => isA<Err<dynamic>>().having(
    (e) => e.failure,
    'failure',
    isA<ValidationFailure>(),
  );

  setUpAll(() => registerFallbackValue(debt()));

  setUp(() {
    debts = _MockDebts();
    when(() => debts.findDebt(any())).thenAnswer((_) async => Ok(debt()));
    when(() => debts.getMovements(any())).thenAnswer((_) async => const Ok([]));
    when(() => debts.saveDebt(any(), payee: any(named: 'payee')))
        .thenAnswer((_) async => const Ok(1));
    when(() => debts.deleteDebt(any())).thenAnswer((_) async => const Ok(null));
  });

  group('simple calls', () {
    test('forward to the repository', () async {
      when(() => debts.watchDebts()).thenAnswer((_) => Stream.value([debt()]));

      expect(await WatchDebts(debts)(const NoParams()).first, [debt()]);
      expect((await GetDebt(debts)(1) as Ok).value, debt());
    });
  });

  group('SaveDebt', () {
    test('creates a debt with its payee', () async {
      final result = await SaveDebt(debts)(
        SaveDebtParams(debt(id: 0, payeeId: 0), payeeName: ' bancolombia '),
      );

      expect((result as Ok<int>).value, 1);
      final captured = verify(
        () => debts.saveDebt(captureAny(), payee: captureAny(named: 'payee')),
      ).captured;
      expect((captured.last as PayeeName).name, 'Bancolombia');
    });

    test('rejects invalid debts', () async {
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(id: 0, payeeId: 0))),
        isValidationError(),
      );
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(name: ''))),
        isValidationError(),
      );
    });

    test('keeps the type and, with movements, the currency', () async {
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(type: DebtType.owedToMe))),
        isValidationError(),
      );
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(currencyCode: 'USD'))),
        isA<Ok<int>>(),
      );
      when(() => debts.getMovements(1)).thenAnswer((_) async => Ok([payment]));
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(currencyCode: 'USD'))),
        isValidationError(),
      );
      expect(await SaveDebt(debts)(SaveDebtParams(debt())), isA<Ok<int>>());
    });

    test('rejects unknown debts and propagates failures', () async {
      when(() => debts.findDebt(2)).thenAnswer((_) async => const Ok(null));
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(id: 2))),
        isValidationError(),
      );
      when(() => debts.findDebt(3)).thenAnswer((_) async => dbError);
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(id: 3))),
        isA<Err<int>>(),
      );
      when(() => debts.getMovements(1)).thenAnswer((_) async => dbError);
      expect(
        await SaveDebt(debts)(SaveDebtParams(debt(currencyCode: 'USD'))),
        isA<Err<int>>(),
      );
    });
  });

  group('DeleteDebt', () {
    test('deletes a debt without movements only', () async {
      await DeleteDebt(debts)(1);
      verify(() => debts.deleteDebt(1)).called(1);

      when(() => debts.getMovements(1)).thenAnswer((_) async => Ok([payment]));
      expect(await DeleteDebt(debts)(1), isValidationError());
      when(() => debts.getMovements(1)).thenAnswer((_) async => dbError);
      expect(await DeleteDebt(debts)(1), isA<Err<void>>());
      verifyNever(() => debts.deleteDebt(2));
    });
  });

  group('EditDebtPending', () {
    test('saves the correction that reaches the pending amount', () async {
      when(() => debts.getMovements(1)).thenAnswer((_) async => Ok([payment]));

      await EditDebtPending(debts)(
        const EditDebtPendingParams(id: 1, pending: 750000),
      );

      final saved =
          verify(() => debts.saveDebt(captureAny())).captured.single as Debt;
      expect(saved.adjustment, -50000);
    });

    test('rejects unknown debts and propagates failures', () async {
      when(() => debts.findDebt(2)).thenAnswer((_) async => const Ok(null));
      expect(
        await EditDebtPending(debts)(
          const EditDebtPendingParams(id: 2, pending: 0),
        ),
        isValidationError(),
      );
      when(() => debts.saveDebt(any())).thenAnswer((_) async => dbError);
      expect(
        await EditDebtPending(debts)(
          const EditDebtPendingParams(id: 1, pending: 0),
        ),
        isA<Err<void>>(),
      );
      when(() => debts.getMovements(1)).thenAnswer((_) async => dbError);
      expect(
        await EditDebtPending(debts)(
          const EditDebtPendingParams(id: 1, pending: 0),
        ),
        isA<Err<void>>(),
      );
    });
  });

  test('a movement can reference a debt', () {
    expect(payment.type, MovementType.expense);
  });
}
