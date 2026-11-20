import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_categories.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/delete_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/save_movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/suggest_transfer_category.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/transfer_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/category_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';

class _MockGetAccounts extends Mock implements GetAccounts;

class _MockGetCategories extends Mock implements GetCategories;

class _MockGetCurrencies extends Mock implements GetCurrencies;

class _MockGetMovement extends Mock implements GetMovement;

class _MockSuggest extends Mock implements SuggestTransferCategory;

class _MockSave extends Mock implements SaveMovement;

class _MockDelete extends Mock implements DeleteMovement;

void main() {
  late _MockGetAccounts getAccounts;
  late _MockGetCategories getCategories;
  late _MockGetCurrencies getCurrencies;
  late _MockGetMovement getMovement;
  late _MockSuggest suggest;
  late _MockSave save;
  late _MockDelete delete;

  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);
  const usd = Currency(code: 'USD', symbol: r'US$', format: CurrencyFormat.usd);
  final cash = account(id: 1, type: AccountType.cash);
  final bank = account(id: 2, isMain: true);
  final wallet = account(id: 3, currencyCode: 'USD');
  final fund = account(id: 4, type: AccountType.pocket, parentAccountId: 2);
  final old = account(id: 5, isArchived: true);
  final savings = category(id: 20, type: CategoryType.transfer);
  final between = category(id: 21, type: CategoryType.transfer);
  final food = category(id: 22);

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(SuggestTransferCategoryParams(from: cash, to: bank));
    registerFallbackValue(SaveMovementParams(movement()));
  });

  setUp(() {
    getAccounts = _MockGetAccounts();
    getCategories = _MockGetCategories();
    getCurrencies = _MockGetCurrencies();
    getMovement = _MockGetMovement();
    suggest = _MockSuggest();
    save = _MockSave();
    delete = _MockDelete();
    when(() => getAccounts(any()))
        .thenAnswer((_) async => Ok([cash, bank, wallet, fund, old]));
    when(() => getCategories(any()))
        .thenAnswer((_) async => Ok([savings, between, food]));
    when(() => getCurrencies(any()))
        .thenAnswer((_) async => const Ok([cop, usd]));
    when(() => suggest(any())).thenAnswer((_) async => const Ok(20));
    when(() => save(any())).thenAnswer((_) async => const Ok(1));
    when(() => delete(any())).thenAnswer((_) async => const Ok(null));
  });

  TransferFormCubit build() => TransferFormCubit(
    getAccounts: getAccounts,
    getCategories: getCategories,
    getCurrencies: getCurrencies,
    getMovement: getMovement,
    suggestCategory: suggest,
    saveMovement: save,
    deleteMovement: delete,
  );

  Future<TransferFormCubit> loaded({int? from, int? id}) async {
    final cubit = build();
    await cubit.load(fromAccountId: from, id: id);
    return cubit;
  }

  Movement saved() =>
      (verify(() => save(captureAny())).captured.single as SaveMovementParams)
          .movement;

  group('TransferFormCubit.load', () {
    test('starts from the main account, or the given one', () async {
      final main = (await loaded()).state;
      expect(main.status, TransferFormStatus.editing);
      expect(main.from, bank);
      expect(main.to, isNull);
      expect(main.sameCurrency, isTrue);
      expect(main.date, LocalDate.today());
      expect(main.accountOptions, [cash, bank, wallet, fund]);
      expect(main.categoryOptions, [savings, between]);

      expect((await loaded(from: 1)).state.from, cash);
      expect((await loaded(from: 5)).state.from, bank);
    });

    test('loads a transfer between currencies to edit it', () async {
      when(() => getMovement(9)).thenAnswer(
        (_) async => Ok(
          movement(
            id: 9,
            type: MovementType.transfer,
            accountId: 3,
            amount: 1050,
            toAccountId: 2,
            toAmount: 42000,
            categoryId: 21,
            note: 'Exchange',
          ),
        ),
      );

      final state = (await loaded(id: 9)).state;

      expect(state.isEditing, isTrue);
      expect(state.amount.raw, '10.5');
      expect(state.toAmount.raw, '42000');
      expect(state.sameCurrency, isFalse);
      expect(state.category, between);
      expect(state.categoryTouched, isTrue);
      expect(state.note, 'Exchange');
    });

    test('loads a same currency transfer with one amount', () async {
      when(() => getMovement(9)).thenAnswer(
        (_) async => Ok(
          movement(
            id: 9,
            type: MovementType.transfer,
            toAccountId: 2,
            toAmount: 1000,
            categoryId: 21,
          ),
        ),
      );

      expect((await loaded(id: 9)).state.toAmount.isEmpty, isTrue);
    });

    test('other movements and failed reads are not found', () async {
      when(() => getMovement(any()))
          .thenAnswer((_) async => Ok(movement(categoryId: 22)));
      expect((await loaded(id: 1)).state.status, TransferFormStatus.notFound);

      when(() => getCategories(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final state = (await loaded()).state;
      expect(state.status, TransferFormStatus.notFound);
      expect(state.failure, isA<DatabaseFailure>());
    });
  });

  group('TransferFormCubit fields', () {
    test('picking the accounts suggests the category', () async {
      final cubit = await loaded();
      await cubit.toChanged(4);

      expect(cubit.state.categoryId, 20);
      expect(cubit.state.isInternal, isTrue);
      final params =
          verify(() => suggest(captureAny())).captured.single
              as SuggestTransferCategoryParams;
      expect((params.from, params.to), (bank, fund));
    });

    test('a picked category is kept when accounts change', () async {
      final cubit = await loaded();
      cubit.categoryChanged(21);
      await cubit.toChanged(1);

      expect(cubit.state.categoryId, 21);
      verifyNever(() => suggest(any()));
    });

    test('the keypad types the amount that is selected', () async {
      final cubit = await loaded();
      await cubit.toChanged(3);
      expect(cubit.state.sameCurrency, isFalse);

      cubit
        ..keyPressed(KeypadKey.d5)
        ..editingToChanged(value: true)
        ..keyPressed(KeypadKey.d2)
        ..keyPressed(KeypadKey.decimal)
        ..keyPressed(KeypadKey.d5);

      expect(cubit.state.amount.raw, '5');
      expect(cubit.state.toAmount.raw, '2.5');
    });

    test('one currency has a single amount', () async {
      final cubit = await loaded();
      await cubit.toChanged(1);
      cubit
        ..editingToChanged(value: true)
        ..keyPressed(KeypadKey.d7);

      expect(cubit.state.editingTo, isFalse);
      expect(cubit.state.amount.raw, '7');
    });

    test('a currency with other decimals clears its amount', () async {
      final cubit = await loaded();
      cubit.keyPressed(KeypadKey.d5);
      await cubit.fromChanged(1);
      expect(cubit.state.amount.raw, '5');
      await cubit.fromChanged(3);
      expect(cubit.state.amount.isEmpty, isTrue);

      await cubit.toChanged(2);
      cubit
        ..editingToChanged(value: true)
        ..keyPressed(KeypadKey.d9);
      await cubit.toChanged(3);
      expect(cubit.state.toAmount.isEmpty, isTrue);
      expect(cubit.state.editingTo, isFalse);
    });

    test('updates note and date', () async {
      final cubit = await loaded()
        ..noteChanged('Rent')
        ..dateChanged(movementDay);

      expect(cubit.state.note, 'Rent');
      expect(cubit.state.date, movementDay);
    });
  });

  group('TransferFormCubit.submit', () {
    test('shows errors and updates them', () async {
      final cubit = await loaded();

      await cubit.submit();
      expect(cubit.state.errors, {
        MovementError.invalidAmount,
        MovementError.missingAccount,
        MovementError.missingCategory,
      });

      await cubit.toChanged(2);
      expect(cubit.state.errors, contains(MovementError.sameAccounts));
      verifyNever(() => save(any()));
    });

    test('saves a transfer in one currency', () async {
      final cubit = await loaded();
      await cubit.toChanged(1);
      cubit
        ..keyPressed(KeypadKey.d5)
        ..keyPressed(KeypadKey.triple0)
        ..noteChanged('ATM');

      await cubit.submit();

      final transfer = saved();
      expect(transfer.type, MovementType.transfer);
      expect(transfer.accountId, 2);
      expect(transfer.toAccountId, 1);
      expect(transfer.amount, 5000);
      expect(transfer.toAmount, 5000);
      expect(transfer.categoryId, 20);
      expect(transfer.note, 'ATM');
      expect(cubit.state.status, TransferFormStatus.saved);
    });

    test('saves both amounts between currencies', () async {
      final cubit = await loaded(from: 3);
      await cubit.toChanged(2);
      cubit
        ..keyPressed(KeypadKey.d1)
        ..editingToChanged(value: true)
        ..keyPressed(KeypadKey.d4)
        ..keyPressed(KeypadKey.triple0);

      await cubit.submit();

      final transfer = saved();
      expect((transfer.amount, transfer.toAmount), (100, 4000));
    });

    test('keeps editing and exposes a failed save', () async {
      when(() => save(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final cubit = await loaded();
      await cubit.toChanged(1);
      cubit.keyPressed(KeypadKey.d5);

      await cubit.submit();

      expect(cubit.state.status, TransferFormStatus.editing);
      expect(cubit.state.failure, isA<DatabaseFailure>());
    });
  });

  group('TransferFormCubit.delete', () {
    test('deletes a stored transfer only', () async {
      await (await loaded()).delete();
      verifyNever(() => delete(any()));

      when(() => getMovement(9)).thenAnswer(
        (_) async => Ok(
          movement(
            id: 9,
            type: MovementType.transfer,
            toAccountId: 2,
            toAmount: 1000,
            categoryId: 21,
          ),
        ),
      );
      final cubit = await loaded(id: 9);
      await cubit.delete();
      verify(() => delete(9)).called(1);
      expect(cubit.state.status, TransferFormStatus.deleted);

      when(() => delete(any()))
          .thenAnswer((_) async => const Err(DatabaseFailure('disk')));
      final failing = await loaded(id: 9);
      await failing.delete();
      expect(failing.state.failure, isA<DatabaseFailure>());
    });
  });
}
