import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/delete_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/get_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/save_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

class _MockGetAccounts extends Mock implements GetAccounts;

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetCurrencies extends Mock implements GetCurrencies;

class _MockGetPayees extends Mock implements GetPayees;

class _MockGetMovement extends Mock implements GetMovement;

class _MockGetTemplate extends Mock implements GetRecurringTemplate;

class _MockSave extends Mock implements SaveRecurringTemplate;

class _MockDelete extends Mock implements DeleteRecurringTemplate;

class _MockDebts extends Mock implements GetDebtStatuses;

void main() {
  late _MockGetAccounts getAccounts;
  late _MockGetCategories getCategories;
  late _MockGetCurrencies getCurrencies;
  late _MockGetPayees getPayees;
  late _MockGetMovement getMovement;
  late _MockGetTemplate getTemplate;
  late _MockSave save;
  late _MockDelete delete;
  late _MockDebts getDebts;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  const netflix = Payee(id: 4, name: 'Netflix', key: 'netflix');
  final bank = account(id: 1, isMain: true);
  final cash = account(id: 2);
  final dollars = account(id: 3, currencyCode: 'USD');
  final food = category(id: 10, name: 'Food');
  final salary = category(id: 12, type: CategoryType.income);
  final savings = category(id: 13, type: CategoryType.transfer);
  final debtPayment = category(id: 14, role: CategoryRole.debtPayment);
  final loanGiven = category(id: 15, role: CategoryRole.loanGiven);
  final mortgage = debt(installment: 1500000);
  final settled = debt(id: 2, initialPending: 0);

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(SaveRecurringTemplateParams(template()));
  });

  setUp(() {
    getAccounts = _MockGetAccounts();
    getCategories = _MockGetCategories();
    getCurrencies = _MockGetCurrencies();
    getPayees = _MockGetPayees();
    getMovement = _MockGetMovement();
    getTemplate = _MockGetTemplate();
    save = _MockSave();
    delete = _MockDelete();
    getDebts = _MockDebts();
    when(() => getDebts(any())).thenAnswer(
      (_) async => Ok([
        (debt: mortgage, status: DebtStatus.of(mortgage, const [])),
        (debt: settled, status: DebtStatus.of(settled, const [])),
      ]),
    );
    when(() => getAccounts(any()))
        .thenAnswer((_) async => Ok([bank, cash, dollars]));
    when(() => getCategories(any())).thenAnswer(
      (_) async => Ok([food, salary, savings, debtPayment, loanGiven]),
    );
    when(() => getCurrencies(any()))
        .thenAnswer((_) async => const Ok([cop, usd]));
    when(() => getPayees(any())).thenAnswer((_) async => const Ok([netflix]));
    when(() => getTemplate(any())).thenAnswer(
      (_) async => Ok(template(payeeId: 4, amount: 44900, dueDay: 12)),
    );
    when(() => getMovement(any())).thenAnswer(
      (_) async =>
          Ok(movement(id: 9, categoryId: 10, amount: 2500, payeeId: 4)),
    );
    when(() => save(any())).thenAnswer((_) async => const Ok(1));
    when(() => delete(any())).thenAnswer((_) async => const Ok(null));
  });

  RecurringFormCubit buildCubit() => RecurringFormCubit(
    getAccounts: getAccounts,
    getCategories: getCategories,
    getCurrencies: getCurrencies,
    getPayees: getPayees,
    getMovement: getMovement,
    getTemplate: getTemplate,
    saveTemplate: save,
    deleteTemplate: delete,
    getDebts: getDebts,
  );

  SaveRecurringTemplateParams saved() =>
      verify(() => save(captureAny())).captured.single
          as SaveRecurringTemplateParams;

  group('RecurringFormCubit', () {
    blocTest<RecurringFormCubit, RecurringFormState>(
      'a new template starts as an expense in the main account',
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.status, RecurringFormStatus.editing);
        expect(state.isEditing, isFalse);
        expect(state.accountId, 1);
        expect(state.categoryOptions, [food, debtPayment]);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'loads a template with its amount, payee and due day',
      build: buildCubit,
      act: (cubit) => cubit.load(id: 1),
      verify: (cubit) {
        final state = cubit.state;
        expect(state.isEditing, isTrue);
        expect(state.amountText, '44.900');
        expect(state.payeeName, 'Netflix');
        expect(state.dueDay, 12);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'starts from a movement',
      build: buildCubit,
      act: (cubit) => cubit.load(fromMovementId: 9),
      verify: (cubit) {
        expect(cubit.state.isEditing, isFalse);
        expect(cubit.state.categoryId, 10);
        expect(cubit.state.amountText, '2.500');
        expect(cubit.state.payeeName, 'Netflix');
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'a missing template or failed read is not found',
      build: buildCubit,
      act: (cubit) async {
        when(() => getTemplate(any())).thenAnswer((_) async => const Ok(null));
        await cubit.load(id: 5);
        expect(cubit.state.status, RecurringFormStatus.notFound);
        when(() => getAccounts(any())).thenAnswer((_) async => dbError);
        await cubit.load();
      },
      verify: (cubit) {
        expect(cubit.state.status, RecurringFormStatus.notFound);
        expect(cubit.state.failure, isA<DatabaseFailure>());
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'saves a new monthly template created today',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit
          ..categoryChanged(10)
          ..amountChanged('44.900')
          ..payeeChanged('netflix')
          ..noteChanged('family plan')
          ..cadenceChanged(RecurringCadence.monthly)
          ..dueDayChanged(12);
        await cubit.submit();
      },
      verify: (cubit) {
        final params = saved();
        final t = params.template;
        expect(t.amount, 44900);
        expect(t.categoryId, 10);
        expect(t.cadence, RecurringCadence.monthly);
        expect(t.dueDay, 12);
        expect(t.remind, isTrue);
        expect(t.note, 'family plan');
        expect(t.createdOn, LocalDate.today());
        expect(params.payeeName, 'netflix');
        expect(cubit.state.status, RecurringFormStatus.saved);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'the reminder needs a due day',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit.remindChanged(value: true);
        expect(cubit.state.remind, isFalse);
        cubit
          ..dueDayChanged(5)
          ..remindChanged(value: false);
        expect(cubit.state.remind, isFalse);
        cubit.dueDayChanged(null);
      },
      verify: (cubit) {
        expect(cubit.state.dueDay, isNull);
        expect(cubit.state.remind, isFalse);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'a transfer between currencies takes both amounts',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit
          ..typeChanged(MovementType.transfer)
          ..categoryChanged(13)
          ..toAccountChanged(3)
          ..amountChanged('400.000')
          ..toAmountChanged('100,50');
        await cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.sameCurrency, isFalse);
        final t = saved().template;
        expect(t.toAccountId, 3);
        expect(t.amount, 400000);
        expect(t.toAmount, 10050);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'changing the type drops a category of another type',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit
          ..categoryChanged(10)
          ..typeChanged(MovementType.expense);
        expect(cubit.state.categoryId, 10);
        cubit.typeChanged(MovementType.income);
      },
      verify: (cubit) {
        expect(cubit.state.categoryId, isNull);
        expect(cubit.state.categoryOptions, [salary]);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'shows errors and keeps them current',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit.amountChanged('abc');
        await cubit.submit();
        cubit.accountChanged(null);
      },
      verify: (cubit) {
        verifyNever(() => save(any()));
        expect(
          cubit.state.errors,
          containsAll([
            MovementError.invalidAmount,
            MovementError.missingCategory,
            MovementError.missingAccount,
          ]),
        );
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'a failed save stays on the form',
      setUp: () => when(() => save(any())).thenAnswer((_) async => dbError),
      build: buildCubit,
      act: (cubit) async {
        await cubit.load(id: 1);
        await cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.status, RecurringFormStatus.editing);
        expect(cubit.state.failure, isA<DatabaseFailure>());
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'deletes a stored template only',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        await cubit.delete();
        verifyNever(() => delete(any()));
        await cubit.load(id: 1);
        await cubit.delete();
      },
      verify: (cubit) {
        verify(() => delete(1)).called(1);
        expect(cubit.state.status, RecurringFormStatus.deleted);
      },
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'a failed delete stays on the form',
      setUp: () => when(() => delete(any())).thenAnswer((_) async => dbError),
      build: buildCubit,
      act: (cubit) async {
        await cubit.load(id: 1);
        await cubit.delete();
      },
      verify: (cubit) =>
          expect(cubit.state.status, RecurringFormStatus.editing),
    );

    blocTest<RecurringFormCubit, RecurringFormState>(
      'a debt payment picks its open debt and its installment',
      build: buildCubit,
      act: (cubit) async {
        await cubit.load();
        cubit.categoryChanged(14);
        expect(cubit.state.debtOptions.map((d) => d.debt), [mortgage]);
        await cubit.submit();
        expect(cubit.state.errors, contains(MovementError.missingDebt));
        cubit.debtChanged(1);
        await cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.amountText, '1.500.000');
        final params = saved();
        expect(params.template.debtId, 1);
        expect(params.payeeName, isNull);
      },
    );
  });
}
