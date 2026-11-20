import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/account_has_movements.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/create_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/delete_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/reorder_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/set_account_archived.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';

import '../../../../helpers/account_fixtures.dart';

class _MockAccountRepository extends Mock implements AccountRepository;

void main() {
  late _MockAccountRepository repository;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final cash = account(id: 1, type: AccountType.cash, includeInBalance: true);
  final main = account(id: 2, isMain: true, includeInBalance: true);
  final lulo = account(id: 3, sortOrder: 1);
  final pocket = account(id: 4, type: AccountType.pocket, parentAccountId: 3);
  final stored = [cash, main, lulo, pocket];

  setUpAll(() => registerFallbackValue(cash));

  setUp(() {
    repository = _MockAccountRepository();
    when(() => repository.getAccounts()).thenAnswer((_) async => Ok(stored));
    when(() => repository.create(any(), alsoSave: any(named: 'alsoSave')))
        .thenAnswer((_) async => const Ok(9));
    when(() => repository.saveAll(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.delete(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.reorder(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.hasMovements(any()))
        .thenAnswer((_) async => const Ok(false));
  });

  List<Account> saved() =>
      verify(() => repository.saveAll(captureAny())).captured.single
          as List<Account>;

  Matcher isValidationError() => isA<Err<dynamic>>().having(
    (e) => e.failure,
    'failure',
    isA<ValidationFailure>(),
  );

  group('streams and simple calls', () {
    test('forward to the repository', () async {
      when(() => repository.watchAccounts())
          .thenAnswer((_) => Stream.value(stored));
      when(() => repository.watchBalances())
          .thenAnswer((_) => Stream.value({1: 5}));
      when(() => repository.hasMovements(1))
          .thenAnswer((_) async => const Ok(true));

      expect(WatchAccounts(repository)(const NoParams()), emits(stored));
      expect(WatchAccountBalances(repository)(const NoParams()), emits({1: 5}));
      expect(
        (await AccountHasMovements(repository)(1) as Ok<bool>).value,
        isTrue,
      );
      await ReorderAccounts(repository)([2, 1]);
      verify(() => repository.reorder([2, 1])).called(1);
    });
  });

  group('CreateAccount', () {
    test('puts the account last in its group', () async {
      final result = await CreateAccount(repository)(
        account(id: 0, name: ' nu '),
      );

      expect((result as Ok<int>).value, 9);
      final created =
          verify(
                () => repository.create(
                  captureAny(),
                  alsoSave: any(named: 'alsoSave'),
                ),
              ).captured.single
              as Account;
      expect(created.name, 'Nu');
      expect(created.sortOrder, 2);
    });

    test('a new main account takes the mark from the previous one', () async {
      await CreateAccount(repository)(account(id: 0, isMain: true));

      final alsoSave =
          verify(
                () => repository.create(
                  any(),
                  alsoSave: captureAny(named: 'alsoSave'),
                ),
              ).captured.single
              as List<Account>;
      expect(alsoSave.single.id, main.id);
      expect(alsoSave.single.isMain, isFalse);
    });

    test('a pocket inherits from its parent and goes last', () async {
      await CreateAccount(repository)(
        account(
          id: 0,
          type: AccountType.pocket,
          parentAccountId: 2,
          currencyCode: 'USD',
        ),
      );

      final created =
          verify(
                () => repository.create(
                  captureAny(),
                  alsoSave: any(named: 'alsoSave'),
                ),
              ).captured.single
              as Account;
      expect(created.currencyCode, 'COP');
      expect(created.includeInBalance, isTrue);
      expect(created.sortOrder, 0);
    });

    test('rejects invalid accounts and propagates failures', () async {
      expect(
        await CreateAccount(repository)(account(id: 0, name: '')),
        isValidationError(),
      );
      when(() => repository.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        (await CreateAccount(repository)(cash) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('UpdateAccount', () {
    test('saves the account and keeps archive state and order', () async {
      await UpdateAccount(repository)(
        lulo.copyWith(name: 'Lulo bank', isArchived: true, sortOrder: 7),
      );

      final account = saved().first;
      expect(account.name, 'Lulo bank');
      expect(account.isArchived, isFalse);
      expect(account.sortOrder, 1);
    });

    test('pockets follow the currency and Balance of their parent', () async {
      await UpdateAccount(repository)(
        lulo.copyWith(currencyCode: 'USD', includeInBalance: true),
      );

      final pocketSaved = saved().singleWhere((a) => a.id == pocket.id);
      expect(pocketSaved.currencyCode, 'USD');
      expect(pocketSaved.includeInBalance, isTrue);
    });

    test('marking a new main account unmarks the previous one', () async {
      await UpdateAccount(repository)(lulo.copyWith(isMain: true));

      final accounts = saved();
      expect(accounts.firstWhere((a) => a.id == lulo.id).isMain, isTrue);
      expect(accounts.firstWhere((a) => a.id == main.id).isMain, isFalse);
    });

    test('a pocket moved to another parent goes last there', () async {
      await UpdateAccount(repository)(pocket.copyWith(parentAccountId: 2));

      expect(saved().single.sortOrder, 0);
    });

    test('keeps type, main mark and currency with movements', () async {
      expect(
        await UpdateAccount(repository)(lulo.copyWith(type: AccountType.cash)),
        isValidationError(),
      );
      expect(
        await UpdateAccount(repository)(main.copyWith(isMain: false)),
        isValidationError(),
      );
      when(() => repository.hasMovements(4))
          .thenAnswer((_) async => const Ok(true));
      expect(
        await UpdateAccount(repository)(lulo.copyWith(currencyCode: 'USD')),
        isValidationError(),
      );
      expect(
        await UpdateAccount(repository)(account(id: 99)),
        isValidationError(),
      );
      expect(
        await UpdateAccount(repository)(lulo.copyWith(name: '')),
        isValidationError(),
      );
      verifyNever(() => repository.saveAll(any()));
    });

    test('propagates failures', () async {
      when(() => repository.hasMovements(any()))
          .thenAnswer((_) async => dbError);
      expect(
        (await UpdateAccount(repository)(
          lulo.copyWith(currencyCode: 'USD'),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
      when(() => repository.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        (await UpdateAccount(repository)(lulo) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('SetAccountArchived', () {
    test('archives and restores an account with its pockets', () async {
      await SetAccountArchived(repository)(
        const SetAccountArchivedParams(id: 3, archived: true),
      );

      expect(saved().map((a) => (a.id, a.isArchived)), [(3, true), (4, true)]);
    });

    test('keeps the main account and orphan pockets as they are', () async {
      expect(
        await SetAccountArchived(repository)(
          const SetAccountArchivedParams(id: 2, archived: true),
        ),
        isValidationError(),
      );
      when(
        () => repository.getAccounts(),
      ).thenAnswer((_) async => Ok([lulo.copyWith(isArchived: true), pocket]));
      expect(
        await SetAccountArchived(repository)(
          const SetAccountArchivedParams(id: 4, archived: false),
        ),
        isValidationError(),
      );
      expect(
        await SetAccountArchived(repository)(
          const SetAccountArchivedParams(id: 99, archived: false),
        ),
        isValidationError(),
      );
      when(() => repository.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        (await SetAccountArchived(repository)(
          const SetAccountArchivedParams(id: 3, archived: true),
        ) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('DeleteAccount', () {
    test('deletes an account without movements', () async {
      await DeleteAccount(repository)(1);

      verify(() => repository.delete([1])).called(1);
    });

    test('deletes a parent together with its pockets', () async {
      await DeleteAccount(repository)(3);

      verify(() => repository.delete([4, 3])).called(1);
    });

    test('keeps the main account and accounts with movements', () async {
      when(() => repository.hasMovements(1))
          .thenAnswer((_) async => const Ok(true));

      for (final id in [2, 1, 99]) {
        expect(
          await DeleteAccount(repository)(id),
          isValidationError(),
          reason: '$id',
        );
      }
      verifyNever(() => repository.delete(any()));
    });

    test('keeps a parent whose pocket has movements', () async {
      when(() => repository.hasMovements(4))
          .thenAnswer((_) async => const Ok(true));

      expect(await DeleteAccount(repository)(3), isValidationError());
      verifyNever(() => repository.delete(any()));
    });

    test('propagates failures', () async {
      when(() => repository.hasMovements(1)).thenAnswer((_) async => dbError);
      expect(
        (await DeleteAccount(repository)(1) as Err).failure,
        isA<DatabaseFailure>(),
      );
      when(() => repository.getAccounts()).thenAnswer((_) async => dbError);
      expect(
        (await DeleteAccount(repository)(1) as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });
}
