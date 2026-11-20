import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement_draft.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/prefill_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/movement_form_cubit.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockGetAccounts extends Mock implements GetAccounts;

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetCurrencies extends Mock implements GetCurrencies;

class _MockGetPayees extends Mock implements GetPayees;

class _MockGetMovement extends Mock implements GetMovement;

class _MockPrefill extends Mock implements PrefillMovement;

class _MockSuggest extends Mock implements SuggestPeriodStart;

class _MockSave extends Mock implements SaveMovement;

class _MockDelete extends Mock implements DeleteMovement;

void main() {
  late _MockGetAccounts getAccounts;
  late _MockGetCategories getCategories;
  late _MockGetCurrencies getCurrencies;
  late _MockGetPayees getPayees;
  late _MockGetMovement getMovement;
  late _MockPrefill prefill;
  late _MockSuggest suggest;
  late _MockSave save;
  late _MockDelete delete;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final bank = account(id: 1, isMain: true);
  final wallet = account(id: 2, currencyCode: 'USD');
  final old = account(id: 3, isArchived: true);
  final food = category(id: 10, name: 'Eating out');
  final salary = category(
    id: 11,
    name: 'Salary',
    type: CategoryType.income,
    role: CategoryRole.salary,
  );
  final debt = category(id: 12, role: CategoryRole.debtPayment);
  const uber = Payee(id: 5, name: 'Uber', key: 'uber');

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(
      const PrefillMovementParams(type: MovementType.expense),
    );
    registerFallbackValue(
      SuggestPeriodStartParams(date: movementDay, minDays: 0),
    );
    registerFallbackValue(SaveMovementParams(movement()));
  });

  setUp(() {
    getAccounts = _MockGetAccounts();
    getCategories = _MockGetCategories();
    getCurrencies = _MockGetCurrencies();
    getPayees = _MockGetPayees();
    getMovement = _MockGetMovement();
    prefill = _MockPrefill();
    suggest = _MockSuggest();
    save = _MockSave();
    delete = _MockDelete();
    when(() => getAccounts(any()))
        .thenAnswer((_) async => Ok([bank, wallet, old]));
    when(() => getCategories(any()))
        .thenAnswer((_) async => Ok([food, salary, debt]));
    when(() => getCurrencies(any()))
        .thenAnswer((_) async => const Ok([cop, usd]));
    when(() => getPayees(any())).thenAnswer((_) async => const Ok([uber]));
    when(() => prefill(any())).thenAnswer(
      (_) async => const Ok(MovementDraft(categoryId: 10, accountId: 1)),
    );
    when(() => suggest(any())).thenAnswer((_) async => const Ok(true));
    when(() => save(any())).thenAnswer((_) async => const Ok(1));
    when(() => delete(any())).thenAnswer((_) async => const Ok(null));
  });

  MovementFormCubit build() => MovementFormCubit(
    getAccounts: getAccounts,
    getCategories: getCategories,
    getCurrencies: getCurrencies,
    getPayees: getPayees,
    getMovement: getMovement,
    prefill: prefill,
    suggestPeriodStart: suggest,
    saveMovement: save,
    deleteMovement: delete,
  );

  Future<MovementFormCubit> loaded({
    MovementType type = MovementType.expense,
    int? categoryId = 10,
    int? id,
  }) async {
    final cubit = build();
    await cubit.load(type: type, categoryId: categoryId, id: id, minDays: 15);
    return cubit;
  }

  void typeAll(MovementFormCubit cubit, List<KeypadKey> keys) {
    keys.forEach(cubit.keyPressed);
  }

  SaveMovementParams saved() =>
      verify(() => save(captureAny())).captured.single as SaveMovementParams;

  group('MovementFormCubit.load', () {
    test('starts from the prefilled draft', () async {
      final state = (await loaded()).state;

      expect(state.status, MovementFormStatus.editing);
      expect(state.category, food);
      expect(state.account, bank);
      expect(state.currency, cop);
      expect(state.date, LocalDate.today());
      expect(state.amount.isEmpty, isTrue);
      expect(state.isSalary, isFalse);
      expect(state.accountOptions, [bank, wallet]);
      expect(state.categoryOptions, [food]);
      verifyNever(() => suggest(any()));
    });

    test('a payee brings a selected amount', () async {
      when(() => prefill(any())).thenAnswer(
        (_) async => const Ok(
          MovementDraft(
            categoryId: 10,
            accountId: 1,
            payeeName: 'Uber',
            amount: 12000,
          ),
        ),
      );

      final state = (await loaded()).state;

      expect(state.payeeName, 'Uber');
      expect(state.amount.raw, '12000');
      expect(state.amountSelected, isTrue);
    });

    test('a salary suggests starting a period', () async {
      when(() => prefill(any())).thenAnswer(
        (_) async => const Ok(MovementDraft(categoryId: 11, accountId: 1)),
      );

      final state = (await loaded(type: MovementType.income)).state;

      expect(state.isSalary, isTrue);
      expect(state.startsPeriod, isTrue);
      final params =
          verify(() => suggest(captureAny())).captured.single
              as SuggestPeriodStartParams;
      expect(params.minDays, 15);
    });

    test('loads a stored movement to edit it', () async {
      when(() => getMovement(7)).thenAnswer(
        (_) async => Ok(
          movement(
            id: 7,
            accountId: 3,
            amount: 1500,
            categoryId: 10,
            payeeId: 5,
            note: 'Lunch',
            isPending: true,
          ),
        ),
      );

      final state = (await loaded(id: 7)).state;

      expect(state.isEditing, isTrue);
      expect(state.amount.raw, '1500');
      expect(state.payeeName, 'Uber');
      expect(state.note, 'Lunch');
      expect(state.isPending, isTrue);
      expect(state.accountOptions, [bank, wallet, old]);
    });

    test('transfers, adjustments and missing ids are not found', () async {
      when(() => getMovement(any())).thenAnswer((_) async => const Ok(null));
      expect((await loaded(id: 1)).state.status, MovementFormStatus.notFound);

      when(() => getMovement(any()))
          .thenAnswer((_) async => Ok(movement(type: MovementType.adjustment)));
      expect((await loaded(id: 1)).state.status, MovementFormStatus.notFound);
    });

    test('reports a failed read', () async {
      when(() => getPayees(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));

      final state = (await loaded()).state;

      expect(state.status, MovementFormStatus.notFound);
      expect(state.failure, isA<DatabaseFailure>());
    });
  });

  group('MovementFormCubit fields', () {
    test('types on the keypad and shows the result', () async {
      final cubit = await loaded();
      typeAll(cubit, [
        KeypadKey.d1,
        KeypadKey.triple0,
        KeypadKey.add,
        KeypadKey.d5,
        KeypadKey.d0,
        KeypadKey.d0,
      ]);

      expect(cubit.state.amount.raw, '1000+500');
      expect(cubit.state.result, 1500);
    });

    test('a digit replaces a selected amount, an operator keeps it', () async {
      when(() => prefill(any())).thenAnswer(
        (_) async =>
            const Ok(MovementDraft(categoryId: 10, accountId: 1, amount: 9000)),
      );
      final first = await loaded();
      first.keyPressed(KeypadKey.d7);
      expect(first.state.amount.raw, '7');

      final second = await loaded();
      second.keyPressed(KeypadKey.add);
      expect(second.state.amount.raw, '9000+');

      final third = await loaded();
      third.keyPressed(KeypadKey.backspace);
      expect(third.state.amount.isEmpty, isTrue);
    });

    test('an account with other decimals clears the amount', () async {
      final cubit = await loaded();
      typeAll(cubit, [KeypadKey.d5]);

      cubit.accountChanged(1);
      expect(cubit.state.amount.raw, '5');

      cubit.accountChanged(2);
      expect(cubit.state.amount.isEmpty, isTrue);
      expect(cubit.state.currency, usd);
    });

    test('updates the other fields', () async {
      final cubit = await loaded();
      cubit
        ..categoryChanged(11)
        ..payeeChanged('Pragma')
        ..noteChanged('March');
      await cubit.dateChanged(movementDay);
      cubit.startsPeriodChanged(value: false);
      await cubit.dateChanged(movementDay.addDays(1));

      expect(cubit.state.isSalary, isTrue);
      expect(cubit.state.payeeName, 'Pragma');
      expect(cubit.state.note, 'March');
      expect(cubit.state.date, movementDay.addDays(1));
      expect(cubit.state.startsPeriod, isFalse);
      expect(cubit.state.payeeOptions('pra'), isEmpty);
      expect(cubit.state.payeeOptions('UB'), ['Uber']);
      expect(cubit.state.payeeOptions(' '), isEmpty);
    });
  });

  group('MovementFormCubit.submit', () {
    test('shows errors and updates them while typing', () async {
      when(() => prefill(any())).thenAnswer(
        (_) async => const Ok(MovementDraft(categoryId: null, accountId: 1)),
      );
      final cubit = await loaded(categoryId: null);

      await cubit.submit();
      expect(cubit.state.errors, {
        MovementError.invalidAmount,
        MovementError.missingCategory,
      });

      cubit.keyPressed(KeypadKey.d3);
      expect(cubit.state.errors, {MovementError.missingCategory});
      verifyNever(() => save(any()));
    });

    test('saves a new expense with its payee', () async {
      final cubit = await loaded()
        ..payeeChanged('Uber')
        ..noteChanged('Taxi');
      typeAll(cubit, [KeypadKey.d8, KeypadKey.triple0]);

      await cubit.submit();

      final params = saved();
      expect(params.payeeName, 'Uber');
      expect(params.movement.amount, 8000);
      expect(params.movement.accountId, 1);
      expect(params.movement.categoryId, 10);
      expect(params.movement.note, 'Taxi');
      expect(params.movement.type, MovementType.expense);
      expect(cubit.state.status, MovementFormStatus.saved);
    });

    test('confirms a pending movement', () async {
      when(() => getMovement(7)).thenAnswer(
        (_) async => Ok(movement(id: 7, categoryId: 10, isPending: true)),
      );
      final cubit = await loaded(id: 7);

      await cubit.submit();

      expect(saved().movement.isPending, isFalse);
    });

    test('keeps editing and exposes a failed save', () async {
      when(() => save(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final cubit = await loaded();
      cubit.keyPressed(KeypadKey.d1);

      await cubit.submit();

      expect(cubit.state.status, MovementFormStatus.editing);
      expect(cubit.state.failure, isA<DatabaseFailure>());
    });
  });

  group('MovementFormCubit.delete', () {
    test('deletes a stored movement only', () async {
      final fresh = await loaded();
      await fresh.delete();
      verifyNever(() => delete(any()));

      when(() => getMovement(7))
          .thenAnswer((_) async => Ok(movement(id: 7, categoryId: 10)));
      final cubit = await loaded(id: 7);
      await cubit.delete();

      verify(() => delete(7)).called(1);
      expect(cubit.state.status, MovementFormStatus.deleted);
    });

    test('exposes a failed delete', () async {
      when(() => delete(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      when(() => getMovement(7))
          .thenAnswer((_) async => Ok(movement(id: 7, categoryId: 10)));
      final cubit = await loaded(id: 7);

      await cubit.delete();

      expect(cubit.state.status, MovementFormStatus.editing);
      expect(cubit.state.failure, isA<DatabaseFailure>());
    });
  });
}
