import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/account_has_movements.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/create_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/delete_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/set_account_archived.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

import '../../../../helpers/account_fixtures.dart';

class _MockGetAccounts extends Mock implements GetAccounts;

class _MockGetCurrencies extends Mock implements GetCurrencies;

class _MockHasMovements extends Mock implements AccountHasMovements;

class _MockCreateAccount extends Mock implements CreateAccount;

class _MockUpdateAccount extends Mock implements UpdateAccount;

class _MockSetArchived extends Mock implements SetAccountArchived;

class _MockDeleteAccount extends Mock implements DeleteAccount;

void main() {
  late _MockGetAccounts getAccounts;
  late _MockGetCurrencies getCurrencies;
  late _MockHasMovements hasMovements;
  late _MockCreateAccount createAccount;
  late _MockUpdateAccount updateAccount;
  late _MockSetArchived setArchived;
  late _MockDeleteAccount deleteAccount;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final cash = account(id: 1, type: AccountType.cash, includeInBalance: true);
  final main = account(id: 2, name: 'Bank', isMain: true);
  final visa = account(
    id: 3,
    type: AccountType.creditCard,
    name: 'Visa',
    currencyCode: 'USD',
    openingBalance: -125050,
    creditLimit: 300000,
    paymentDay: 15,
  );
  final pocket = account(id: 4, type: AccountType.pocket, parentAccountId: 2);
  final accounts = [cash, main, visa, pocket];

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(cash);
    registerFallbackValue(
      const SetAccountArchivedParams(id: 0, archived: true),
    );
  });

  setUp(() {
    getAccounts = _MockGetAccounts();
    getCurrencies = _MockGetCurrencies();
    hasMovements = _MockHasMovements();
    createAccount = _MockCreateAccount();
    updateAccount = _MockUpdateAccount();
    setArchived = _MockSetArchived();
    deleteAccount = _MockDeleteAccount();
    when(() => getAccounts(any())).thenAnswer((_) async => Ok(accounts));
    when(() => getCurrencies(any()))
        .thenAnswer((_) async => const Ok([cop, usd]));
    when(() => hasMovements(any())).thenAnswer((_) async => const Ok(false));
    when(() => createAccount(any())).thenAnswer((_) async => const Ok(9));
    when(() => updateAccount(any())).thenAnswer((_) async => const Ok(null));
    when(() => setArchived(any())).thenAnswer((_) async => const Ok(null));
    when(() => deleteAccount(any())).thenAnswer((_) async => const Ok(null));
  });

  AccountFormCubit buildCubit() => AccountFormCubit(
    getAccounts: getAccounts,
    getCurrencies: getCurrencies,
    hasMovements: hasMovements,
    createAccount: createAccount,
    updateAccount: updateAccount,
    setArchived: setArchived,
    deleteAccount: deleteAccount,
  );

  Future<AccountFormCubit> loaded({int? id}) async {
    final cubit = buildCubit();
    await cubit.load(mainCurrencyCode: 'COP', id: id);
    return cubit;
  }

  Account created() =>
      verify(() => createAccount(captureAny())).captured.single as Account;

  Account updated() =>
      verify(() => updateAccount(captureAny())).captured.single as Account;

  group('AccountFormCubit.load', () {
    test('starts a bank account in the main currency', () async {
      final state = (await loaded()).state;

      expect(state.status, AccountFormStatus.editing);
      expect(state.isEditing, isFalse);
      expect(state.type, AccountType.bank);
      expect(state.currencyCode, 'COP');
      expect(state.iconKey, 'account_balance');
      expect(state.includeInBalance, isFalse);
      expect(state.openingDate, LocalDate.today());
      expect(state.parentAccountId, main.id);
      expect(state.currency, cop);
    });

    test('fills the form of a credit card with its debt', () async {
      final state = (await loaded(id: 3)).state;

      expect(state.original, visa);
      expect(state.name, 'Visa');
      expect(state.openingText, '1.250,50');
      expect(state.creditLimitText, '3.000,00');
      expect(state.paymentDay, 15);
      expect(state.canArchive, isTrue);
      expect(state.canDelete, isTrue);
    });

    test('locks the currency of an account with movements', () async {
      when(() => hasMovements(1)).thenAnswer((_) async => const Ok(true));

      final cubit = await loaded(id: 1);
      cubit.currencyChanged('USD');

      expect(cubit.state.currencyLocked, isTrue);
      expect(cubit.state.canDelete, isFalse);
      expect(cubit.state.currencyCode, 'COP');
    });

    test('the main account and parents cannot be removed', () async {
      final state = (await loaded(id: 2)).state;

      expect(state.hasPockets, isTrue);
      expect(state.canArchive, isFalse);
      expect(state.canDelete, isFalse);
    });

    test('reports a missing account and a failed read', () async {
      expect((await loaded(id: 99)).state.status, AccountFormStatus.notFound);

      when(() => getCurrencies(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final state = (await loaded()).state;
      expect(state.status, AccountFormStatus.notFound);
      expect(state.failure, isA<DatabaseFailure>());
    });
  });

  group('AccountFormCubit fields', () {
    test('the type sets its icon until the user picks one', () async {
      final cubit = await loaded();

      cubit.typeChanged(AccountType.cash);
      expect(cubit.state.iconKey, 'payments');
      expect(cubit.state.includeInBalance, isTrue);

      cubit
        ..iconChanged('star', 0xFF000000)
        ..typeChanged(AccountType.investment);
      expect(cubit.state.iconKey, 'star');
      expect(cubit.state.color, 0xFF000000);
      expect(cubit.state.includeInBalance, isFalse);
    });

    test('the type and the main mark of a main account are fixed', () async {
      final cubit = await loaded(id: 2);

      cubit
        ..typeChanged(AccountType.cash)
        ..isMainChanged(value: false);

      expect(cubit.state.type, AccountType.bank);
      expect(cubit.state.isMain, isTrue);
    });

    test('a pocket uses the currency of its parent', () async {
      final cubit = await loaded();

      cubit
        ..typeChanged(AccountType.pocket)
        ..currencyChanged('USD')
        ..parentChanged(main.id);

      expect(cubit.state.isPocket, isTrue);
      expect(cubit.state.parent, main);
      expect(cubit.state.currency, cop);
      expect(cubit.state.parentOptions, [main]);
    });
  });

  group('AccountFormCubit.submit', () {
    test('creates an account with every field', () async {
      final cubit = await loaded();
      final date = LocalDate(2026, 3, 1);

      cubit
        ..nameChanged(' lulo ')
        ..colorChanged(0xFF111111)
        ..currencyChanged('USD')
        ..openingChanged('1.250,5')
        ..openingDateChanged(date)
        ..includeInBalanceChanged(value: true)
        ..isMainChanged(value: true);
      await cubit.submit();

      final account = created();
      expect(account.name, 'Lulo');
      expect(account.color, 0xFF111111);
      expect(account.currencyCode, 'USD');
      expect(account.openingBalance, 125050);
      expect(account.openingDate, date);
      expect(account.includeInBalance, isTrue);
      expect(account.isMain, isTrue);
      expect(account.parentAccountId, isNull);
      expect(cubit.state.status, AccountFormStatus.saved);
    });

    test('stores a credit card debt as a negative balance', () async {
      final cubit = await loaded();

      cubit
        ..typeChanged(AccountType.creditCard)
        ..nameChanged('Visa')
        ..openingChanged('1.200.000')
        ..creditLimitChanged('3.000.000')
        ..paymentDayChanged(15);
      await cubit.submit();

      final account = created();
      expect(account.openingBalance, -1200000);
      expect(account.creditLimit, 3000000);
      expect(account.paymentDay, 15);
    });

    test('updates an edited account', () async {
      final cubit = await loaded(id: 3);

      cubit.nameChanged('Visa gold');
      await cubit.submit();

      expect(updated(), visa.copyWith(name: 'Visa gold'));
    });

    test('shows errors instead of saving, then revalidates', () async {
      final cubit = await loaded();

      cubit
        ..typeChanged(AccountType.creditCard)
        ..openingChanged('abc');
      await cubit.submit();

      expect(cubit.state.showErrors, isTrue);
      expect(cubit.state.errors, {
        AccountError.emptyName,
        AccountError.invalidOpeningBalance,
        AccountError.invalidCreditLimit,
        AccountError.invalidPaymentDay,
      });
      cubit.nameChanged('Visa');
      expect(cubit.state.errors, isNot(contains(AccountError.emptyName)));
      verifyNever(() => createAccount(any()));
    });

    test('keeps editing when saving fails', () async {
      when(() => createAccount(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final cubit = await loaded();

      cubit.nameChanged('Lulo');
      await cubit.submit();

      expect(cubit.state.status, AccountFormStatus.editing);
      expect(cubit.state.failure, isA<DatabaseFailure>());
    });
  });

  group('AccountFormCubit archive and delete', () {
    test('archives and deletes the edited account', () async {
      final cubit = await loaded(id: 1);

      await cubit.setArchived(archived: true);
      expect(cubit.state.status, AccountFormStatus.saved);
      final params =
          verify(() => setArchived(captureAny())).captured.single
              as SetAccountArchivedParams;
      expect((params.id, params.archived), (1, true));

      await cubit.delete();
      verify(() => deleteAccount(1)).called(1);
      expect(cubit.state.status, AccountFormStatus.deleted);
    });

    test('does nothing for a new account', () async {
      final cubit = await loaded();

      await cubit.setArchived(archived: true);
      await cubit.delete();

      verifyNever(() => setArchived(any()));
      verifyNever(() => deleteAccount(any()));
    });
  });
}
