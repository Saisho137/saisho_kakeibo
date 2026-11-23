import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/repositories/payee_repository.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/delete_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/merge_payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/usecases/rename_payee.dart';

import '../../../helpers/debt_fixtures.dart';

class _MockPayees extends Mock implements PayeeRepository;

class _MockMovements extends Mock implements MovementRepository;

class _MockDebts extends Mock implements DebtRepository;

void main() {
  late _MockPayees payees;
  late _MockMovements movements;
  late _MockDebts debts;

  const peaje = Payee(id: 1, name: 'Peaje Palmas', key: 'peajepalmas');
  const other = Payee(id: 2, name: 'Peaje Las Palmas', key: 'peajelaspalmas');
  const dbError = Err<List<Payee>>(DatabaseFailure('disk'));

  setUpAll(() => registerFallbackValue(PayeeName.parse('x')));

  setUp(() {
    payees = _MockPayees();
    movements = _MockMovements();
    debts = _MockDebts();
    when(movements.getPayees).thenAnswer((_) async => const Ok([peaje, other]));
    when(() => payees.rename(any(), any()))
        .thenAnswer((_) async => const Ok(null));
    when(
      () => payees.merge(
        from: any(named: 'from'),
        into: any(named: 'into'),
      ),
    ).thenAnswer((_) async => const Ok(null));
    when(() => payees.delete(any())).thenAnswer((_) async => const Ok(null));
  });

  group('RenamePayee', () {
    RenamePayee rename() => RenamePayee(payees: payees, movements: movements);

    test('renames with the normalized name, even its own key', () async {
      expect(
        await rename()(const RenamePayeeParams(id: 1, name: ' peaje  PALMAS ')),
        isA<Ok<void>>(),
      );
      final name =
          verify(() => payees.rename(1, captureAny())).captured.single
              as PayeeName;
      expect(name.name, 'Peaje PALMAS');
    });

    test('refuses a blank name, a taken one or an unknown entity', () async {
      for (final params in const [
        RenamePayeeParams(id: 1, name: ' '),
        RenamePayeeParams(id: 1, name: 'Peaje las palmas'),
        RenamePayeeParams(id: 9, name: 'New'),
      ]) {
        expect(await rename()(params), isA<Err<void>>());
      }
      when(movements.getPayees).thenAnswer((_) async => dbError);
      expect(
        await rename()(const RenamePayeeParams(id: 1, name: 'New')),
        isA<Err<void>>(),
      );
      verifyNever(() => payees.rename(any(), any()));
    });
  });

  group('MergePayee', () {
    MergePayee merge() => MergePayee(payees: payees, movements: movements);

    test('merges one entity into another', () async {
      expect(
        await merge()(const MergePayeeParams(from: 2, into: 1)),
        isA<Ok<void>>(),
      );
      verify(() => payees.merge(from: 2, into: 1)).called(1);
    });

    test('refuses itself, unknown entities and failures', () async {
      for (final params in const [
        MergePayeeParams(from: 1, into: 1),
        MergePayeeParams(from: 9, into: 1),
        MergePayeeParams(from: 1, into: 9),
      ]) {
        expect(await merge()(params), isA<Err<void>>());
      }
      when(movements.getPayees).thenAnswer((_) async => dbError);
      expect(
        await merge()(const MergePayeeParams(from: 2, into: 1)),
        isA<Err<void>>(),
      );
      verifyNever(
        () => payees.merge(
          from: any(named: 'from'),
          into: any(named: 'into'),
        ),
      );
    });
  });

  group('DeletePayee', () {
    DeletePayee delete() => DeletePayee(payees: payees, debts: debts);

    test('deletes an entity no debt is', () async {
      when(debts.getDebts).thenAnswer((_) async => Ok([debt(payeeId: 5)]));
      expect(await delete()(1), isA<Ok<void>>());
      verify(() => payees.delete(1)).called(1);
    });

    test('keeps the entity of a debt and propagates failures', () async {
      when(debts.getDebts).thenAnswer((_) async => Ok([debt()]));
      expect(await delete()(1), isA<Err<void>>());
      when(debts.getDebts)
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      expect(await delete()(1), isA<Err<void>>());
      verifyNever(() => payees.delete(any()));
    });
  });
}
