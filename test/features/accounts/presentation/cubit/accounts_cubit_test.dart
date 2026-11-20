import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/reorder_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';

import '../../../../helpers/account_fixtures.dart';

class _MockWatchAccounts extends Mock implements WatchAccounts;

class _MockWatchBalances extends Mock implements WatchAccountBalances;

class _MockWatchCurrencies extends Mock implements WatchCurrencies;

class _MockUpdateAccount extends Mock implements UpdateAccount;

class _MockReorderAccounts extends Mock implements ReorderAccounts;

void main() {
  late _MockWatchAccounts watchAccounts;
  late _MockWatchBalances watchBalances;
  late _MockWatchCurrencies watchCurrencies;
  late _MockUpdateAccount updateAccount;
  late _MockReorderAccounts reorderAccounts;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  final cash = account(id: 1, type: AccountType.cash);
  final bank = account(id: 2, includeInBalance: true, sortOrder: 1);
  final accounts = [cash, bank];
  const balances = {1: 100, 2: 200};

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(cash);
  });

  setUp(() {
    watchAccounts = _MockWatchAccounts();
    watchBalances = _MockWatchBalances();
    watchCurrencies = _MockWatchCurrencies();
    updateAccount = _MockUpdateAccount();
    reorderAccounts = _MockReorderAccounts();
    when(() => watchAccounts(any())).thenAnswer((_) => Stream.value(accounts));
    when(() => watchBalances(any())).thenAnswer((_) => Stream.value(balances));
    when(() => watchCurrencies(any())).thenAnswer((_) => Stream.value([cop]));
    when(() => updateAccount(any())).thenAnswer((_) async => const Ok(null));
    when(() => reorderAccounts(any())).thenAnswer((_) async => const Ok(null));
  });

  AccountsCubit buildCubit() => AccountsCubit(
    watchAccounts: watchAccounts,
    watchBalances: watchBalances,
    watchCurrencies: watchCurrencies,
    updateAccount: updateAccount,
    reorderAccounts: reorderAccounts,
  );

  final loaded = AccountsState(
    status: AccountsStatus.success,
    accounts: accounts,
    balances: balances,
    currencies: const [cop],
    currencyCode: 'COP',
  );

  group('AccountsCubit', () {
    blocTest<AccountsCubit, AccountsState>(
      'is ready once accounts, balances and currencies arrive',
      build: buildCubit,
      act: (cubit) => cubit.load('COP'),
      skip: 3,
      expect: () => [loaded],
      verify: (cubit) {
        expect(cubit.state.currency, cop);
        expect(cubit.state.overview!.totalBalance, const Money(300, 'COP'));
        expect(cubit.state.overview!.balance, const Money(200, 'COP'));
      },
    );

    test('has no overview before loading', () {
      expect(const AccountsState().overview, isNull);
    });

    blocTest<AccountsCubit, AccountsState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchBalances(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load('COP'),
      verify: (cubit) {
        expect(cubit.state.status, AccountsStatus.failure);
        expect(cubit.state.failure, isA<UnexpectedFailure>());
      },
    );

    blocTest<AccountsCubit, AccountsState>(
      'switches currency and archived visibility',
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit
        ..currencySelected('USD')
        ..showArchivedToggled(),
      expect: () => [
        loaded.copyWith(currencyCode: 'USD'),
        loaded.copyWith(currencyCode: 'USD', showArchived: true),
      ],
    );

    blocTest<AccountsCubit, AccountsState>(
      'saves the Balance switch of an account',
      build: buildCubit,
      act: (cubit) => cubit.setIncludeInBalance(cash, value: true),
      verify: (_) =>
          verify(() => updateAccount(cash.copyWith(includeInBalance: true)))
              .called(1),
    );

    blocTest<AccountsCubit, AccountsState>(
      'saves the new order of a group',
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.reorder(AccountGroup.cashAndBank, 1, 0),
      verify: (_) => verify(() => reorderAccounts([2, 1])).called(1),
    );

    blocTest<AccountsCubit, AccountsState>(
      'ignores a reorder of an empty group',
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.reorder(AccountGroup.investments, 0, 1),
      verify: (_) => verifyNever(() => reorderAccounts(any())),
    );

    blocTest<AccountsCubit, AccountsState>(
      'reports a failed action',
      setUp: () =>
          when(() => reorderAccounts(any()))
              .thenAnswer((_) async => const Err(DatabaseFailure('disk'))),
      build: buildCubit,
      seed: () => loaded,
      act: (cubit) => cubit.reorder(AccountGroup.cashAndBank, 0, 1),
      expect: () => [loaded.copyWith(failure: const DatabaseFailure('disk'))],
    );

    test('cancels its streams when closed', () async {
      final controller = StreamController<List<Account>>();
      when(() => watchAccounts(any())).thenAnswer((_) => controller.stream);
      final cubit = buildCubit()..load('COP');

      await cubit.close();

      expect(controller.hasListener, isFalse);
    });
  });
}
