import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_account_balances.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/watch_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_pillars.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_categories.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/watch_pillars.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/delete_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/edit_debt_pending.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/save_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/watch_debts.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_detail_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_form_cubit.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_movements.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/watch_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _WatchDebts extends Mock implements WatchDebts;

class _WatchMovements extends Mock implements WatchMovements;

class _WatchAccounts extends Mock implements WatchAccounts;

class _WatchBalances extends Mock implements WatchAccountBalances;

class _WatchPayees extends Mock implements WatchPayees;

class _WatchPillars extends Mock implements WatchPillars;

class _WatchCurrencies extends Mock implements WatchCurrencies;

class _WatchSettings extends Mock implements WatchSettings;

class _WatchCategories extends Mock implements WatchCategories;

class _EditPending extends Mock implements EditDebtPending;

class _Delete extends Mock implements DeleteDebt;

class _GetDebt extends Mock implements GetDebt;

class _GetPillars extends Mock implements GetPillars;

class _GetCurrencies extends Mock implements GetCurrencies;

class _Repository extends Mock implements DebtRepository;

class _Save extends Mock implements SaveDebt;

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const bancolombia = Payee(id: 1, name: 'Bancolombia', key: 'bancolombia');
  const dbError = Err<Never>(DatabaseFailure('disk'));
  final mortgage = debt();
  final settled = debt(id: 2, name: 'Old', initialPending: 0);
  final lent = debt(id: 3, type: DebtType.owedToMe, initialPending: 500);
  final dollars = debt(id: 4, currencyCode: 'USD');
  final payment = movement(amount: 250000).copyWith(debtId: 1);
  final visa = account(
    id: 7,
    type: AccountType.creditCard,
    name: 'Visa',
    openingBalance: -300,
  );

  late _WatchDebts watchDebts;
  late _WatchMovements watchMovements;
  late _WatchAccounts watchAccounts;
  late _WatchBalances watchBalances;
  late _WatchPayees watchPayees;
  late _WatchPillars watchPillars;
  late _WatchCurrencies watchCurrencies;
  late _WatchSettings watchSettings;
  late _WatchCategories watchCategories;

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const EditDebtPendingParams(id: 0, pending: 0));
    registerFallbackValue(SaveDebtParams(debt()));
  });

  setUp(() {
    watchDebts = _WatchDebts();
    watchMovements = _WatchMovements();
    watchAccounts = _WatchAccounts();
    watchBalances = _WatchBalances();
    watchPayees = _WatchPayees();
    watchPillars = _WatchPillars();
    watchCurrencies = _WatchCurrencies();
    watchSettings = _WatchSettings();
    watchCategories = _WatchCategories();
    when(() => watchDebts(any()))
        .thenAnswer((_) => Stream.value([mortgage, settled, lent, dollars]));
    when(() => watchMovements(any()))
        .thenAnswer((_) => Stream.value([payment]));
    when(() => watchAccounts(any()))
        .thenAnswer((_) => Stream.value([account(id: 1), visa]));
    when(() => watchBalances(any())).thenAnswer((_) => Stream.value({7: -900}));
    when(() => watchPayees(any()))
        .thenAnswer((_) => Stream.value([bancolombia]));
    when(() => watchPillars(any())).thenAnswer((_) => Stream.value(pillars));
    when(() => watchCurrencies(any()))
        .thenAnswer((_) => Stream.value([cop, usd]));
    when(() => watchSettings(any()))
        .thenAnswer((_) => Stream.value(const AppSettings()));
    when(() => watchCategories(any())).thenAnswer((_) => Stream.value([]));
  });

  group('DebtsCubit', () {
    DebtsCubit build() => DebtsCubit(
      watchDebts: watchDebts,
      watchMovements: watchMovements,
      watchAccounts: watchAccounts,
      watchBalances: watchBalances,
      watchPillars: watchPillars,
      watchCurrencies: watchCurrencies,
      watchSettings: watchSettings,
    );

    blocTest<DebtsCubit, DebtsState>(
      'splits the debts of the currency into active and paid off',
      build: build,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.status, DebtsStatus.success);
        expect(state.currency, cop);
        expect(state.currencyOptions, [cop, usd]);
        expect(state.active(DebtType.iOwe).map((l) => l.debt), [mortgage]);
        expect(state.paidOff(DebtType.iOwe).map((l) => l.debt), [settled]);
        expect(state.totalPending(DebtType.iOwe), 750000);
        expect(state.totalPending(DebtType.owedToMe), 500);
        expect(state.cards, [(visa, -900)]);
        expect(state.pillarOf(mortgage), survival);
      },
    );

    blocTest<DebtsCubit, DebtsState>(
      'switches the currency',
      build: build,
      act: (cubit) async {
        cubit.load();
        await Future<void>.delayed(Duration.zero);
        cubit.currencySelected('USD');
      },
      verify: (cubit) {
        expect(cubit.state.active(DebtType.iOwe).map((l) => l.debt), [dollars]);
        expect(cubit.state.cards, isEmpty);
      },
    );

    blocTest<DebtsCubit, DebtsState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchDebts(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: build,
      act: (cubit) => cubit.load(),
      verify: (cubit) => expect(cubit.state.status, DebtsStatus.failure),
    );

    test('cancels its streams when closed', () async {
      final controller = StreamController<List<Debt>>();
      when(() => watchDebts(any())).thenAnswer((_) => controller.stream);
      final cubit = build()..load();
      await cubit.close();
      expect(controller.hasListener, isFalse);
    });
  });

  group('DebtDetailCubit', () {
    late _EditPending editPending;
    late _Delete delete;

    setUp(() {
      editPending = _EditPending();
      delete = _Delete();
      when(() => editPending(any())).thenAnswer((_) async => const Ok(null));
      when(() => delete(any())).thenAnswer((_) async => const Ok(null));
    });

    DebtDetailCubit build() => DebtDetailCubit(
      watchDebts: watchDebts,
      watchMovements: watchMovements,
      watchAccounts: watchAccounts,
      watchCategories: watchCategories,
      watchPayees: watchPayees,
      watchPillars: watchPillars,
      watchCurrencies: watchCurrencies,
      editPending: editPending,
      deleteDebt: delete,
    );

    blocTest<DebtDetailCubit, DebtDetailState>(
      'shows a debt with its status',
      build: build,
      act: (cubit) => cubit.load(1),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.status, DebtDetailStatus.success);
        expect(state.debt, mortgage);
        expect(state.debtStatus!.pending, 750000);
        expect(state.currency, cop);
        expect(state.pillar, survival);
        expect(state.payeeOf(1), bancolombia);
        expect(state.categoryOf(payment), isNull);
        expect(state.accountById(7), visa);
        expect(state.canDelete, isFalse);
      },
    );

    blocTest<DebtDetailCubit, DebtDetailState>(
      'edits the pending amount and deletes',
      build: build,
      act: (cubit) async {
        cubit.load(2);
        await Future<void>.delayed(Duration.zero);
        expect(cubit.state.canDelete, isTrue);
        await cubit.editPending(10);
        await cubit.delete();
      },
      verify: (_) {
        final params =
            verify(() => editPending(captureAny())).captured.single
                as EditDebtPendingParams;
        expect(params.id, 2);
        expect(params.pending, 10);
        verify(() => delete(2)).called(1);
      },
    );

    blocTest<DebtDetailCubit, DebtDetailState>(
      'reports failures and a missing debt',
      setUp: () {
        when(() => editPending(any())).thenAnswer((_) async => dbError);
        when(() => delete(any())).thenAnswer((_) async => dbError);
      },
      build: build,
      act: (cubit) async {
        await cubit.editPending(1);
        await cubit.delete();
        cubit.load(99);
        await Future<void>.delayed(Duration.zero);
        await cubit.editPending(1);
        expect(cubit.state.failure, isA<DatabaseFailure>());
      },
      verify: (cubit) {
        expect(cubit.state.status, DebtDetailStatus.notFound);
        expect(cubit.state.debtStatus, isNull);
        expect(cubit.state.canDelete, isFalse);
      },
    );

    blocTest<DebtDetailCubit, DebtDetailState>(
      'reports a stream error',
      setUp: () =>
          when(() => watchMovements(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: build,
      act: (cubit) => cubit.load(1),
      verify: (cubit) => expect(cubit.state.status, DebtDetailStatus.failure),
    );

    test('cancels its streams when closed', () async {
      final controller = StreamController<List<Debt>>();
      when(() => watchDebts(any())).thenAnswer((_) => controller.stream);
      final cubit = build()..load(1);
      await cubit.close();
      expect(controller.hasListener, isFalse);
    });
  });

  group('DebtFormCubit', () {
    late _GetDebt getDebt;
    late _GetPillars getPillars;
    late _GetCurrencies getCurrencies;
    late _Repository repository;
    late _Save save;

    setUp(() {
      getDebt = _GetDebt();
      getPillars = _GetPillars();
      getCurrencies = _GetCurrencies();
      repository = _Repository();
      save = _Save();
      when(() => getPillars(any())).thenAnswer((_) async => const Ok(pillars));
      when(() => getCurrencies(any()))
          .thenAnswer((_) async => const Ok([cop, usd]));
      when(() => getDebt(any())).thenAnswer(
        (_) async => Ok(mortgage.copyWith(installment: 1500000, dueDay: 5)),
      );
      when(() => repository.getMovements(any()))
          .thenAnswer((_) async => Ok([payment]));
      when(() => save(any())).thenAnswer((_) async => const Ok(1));
    });

    DebtFormCubit build() => DebtFormCubit(
      getDebt: getDebt,
      getPillars: getPillars,
      getCurrencies: getCurrencies,
      debts: repository,
      saveDebt: save,
    );

    SaveDebtParams saved() =>
        verify(() => save(captureAny())).captured.single as SaveDebtParams;

    blocTest<DebtFormCubit, DebtFormState>(
      'creates a debt I owe in the main currency',
      build: build,
      act: (cubit) async {
        await cubit.load();
        expect(cubit.state.iconKey, DebtFormCubit.newIconKey);
        expect(cubit.state.currencyCode, 'COP');
        cubit
          ..nameChanged(' car loan ')
          ..pendingChanged('5.300.000')
          ..pillarChanged(1)
          ..installmentChanged('450.000')
          ..dueDayChanged(12)
          ..iconChanged('directions_car', 0xFF1E88E5)
          ..colorChanged(0xFF000000)
          ..currencyChanged('USD')
          ..currencyChanged('COP');
        await cubit.submit();
      },
      verify: (cubit) {
        final params = saved();
        final d = params.debt;
        expect(d.name, 'Car loan');
        expect(d.initialPending, 5300000);
        expect(d.installment, 450000);
        expect(d.dueDay, 12);
        expect(d.pillarId, 1);
        expect(d.iconKey, 'directions_car');
        expect(d.color, 0xFF000000);
        expect(d.createdOn, LocalDate.today());
        expect(cubit.state.status, DebtFormStatus.saved);
      },
    );

    blocTest<DebtFormCubit, DebtFormState>(
      'a debt owed to me has a due date and no pillar',
      build: build,
      act: (cubit) async {
        await cubit.load(type: DebtType.owedToMe);
        cubit
          ..typeChanged(DebtType.owedToMe)
          ..nameChanged('Loan to Ana')
          ..pendingChanged('200.000')
          ..dueDateChanged(LocalDate(2026, 6, 1));
        await cubit.submit();
      },
      verify: (_) {
        final d = saved().debt;
        expect(d.type, DebtType.owedToMe);
        expect(d.pillarId, isNull);
        expect(d.dueDate, LocalDate(2026, 6, 1));
      },
    );

    blocTest<DebtFormCubit, DebtFormState>(
      'loads a debt, locking its type and, with movements, its currency',
      build: build,
      act: (cubit) async {
        await cubit.load(id: 1);
        cubit
          ..typeChanged(DebtType.owedToMe)
          ..currencyChanged('USD');
      },
      verify: (cubit) {
        final state = cubit.state;
        expect(state.isEditing, isTrue);
        expect(state.type, DebtType.iOwe);
        expect(state.currencyLocked, isTrue);
        expect(state.currencyCode, 'COP');
        expect(state.pendingText, '1.000.000');
        expect(state.installmentText, '1.500.000');
        expect(state.dueDay, 5);
      },
    );

    blocTest<DebtFormCubit, DebtFormState>(
      'shows errors and keeps them current',
      build: build,
      act: (cubit) async {
        await cubit.load();
        cubit.installmentChanged('abc');
        await cubit.submit();
        cubit.pendingChanged('1');
      },
      verify: (cubit) {
        verifyNever(() => save(any()));
        expect(
          cubit.state.errors,
          containsAll([
            DebtError.emptyName,
            DebtError.missingPillar,
            DebtError.invalidInstallment,
          ]),
        );
        expect(cubit.state.errors, isNot(contains(DebtError.invalidPending)));
      },
    );

    blocTest<DebtFormCubit, DebtFormState>(
      'a failed save stays; a missing debt or failed read is not found',
      setUp: () => when(() => save(any())).thenAnswer((_) async => dbError),
      build: build,
      act: (cubit) async {
        await cubit.load(id: 1);
        await cubit.submit();
        expect(cubit.state.status, DebtFormStatus.editing);
        expect(cubit.state.failure, isA<DatabaseFailure>());
        when(() => getDebt(any())).thenAnswer((_) async => const Ok(null));
        await cubit.load(id: 5);
        expect(cubit.state.status, DebtFormStatus.notFound);
        when(() => getPillars(any())).thenAnswer((_) async => dbError);
        await cubit.load();
      },
      verify: (cubit) => expect(cubit.state.status, DebtFormStatus.notFound),
    );

    blocTest<DebtFormCubit, DebtFormState>(
      'a failed movements read locks the currency',
      setUp: () =>
          when(() => repository.getMovements(any()))
              .thenAnswer((_) async => dbError),
      build: build,
      act: (cubit) => cubit.load(id: 1),
      verify: (cubit) => expect(cubit.state.currencyLocked, isTrue),
    );
  });

  test('a payment references its debt', () {
    expect(payment.type, MovementType.expense);
    expect(payment.debtId, 1);
  });
}
