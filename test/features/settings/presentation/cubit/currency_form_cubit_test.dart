import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/create_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/delete_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/is_currency_in_use.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_currency.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currency_form_cubit.dart';

class _MockGetCurrency extends Mock implements GetCurrency;

class _MockCreateCurrency extends Mock implements CreateCurrency;

class _MockUpdateCurrency extends Mock implements UpdateCurrency;

class _MockDeleteCurrency extends Mock implements DeleteCurrency;

class _MockIsCurrencyInUse extends Mock implements IsCurrencyInUse;

void main() {
  late _MockGetCurrency getCurrency;
  late _MockCreateCurrency createCurrency;
  late _MockUpdateCurrency updateCurrency;
  late _MockDeleteCurrency deleteCurrency;
  late _MockIsCurrencyInUse isCurrencyInUse;

  const eur = Currency(
    code: 'EUR',
    symbol: '€',
    format: CurrencyFormat(decimals: 2, thousandsSeparator: ' '),
  );
  const editing = CurrencyFormState(
    status: CurrencyFormStatus.editing,
    original: eur,
    code: 'EUR',
    symbol: '€',
    thousandsSeparator: ' ',
  );
  const creating = CurrencyFormState(
    status: CurrencyFormStatus.editing,
    code: 'EUR',
    symbol: '€',
  );

  setUpAll(() {
    registerFallbackValue(eur);
    registerFallbackValue(
      const UpdateCurrencyParams(
        code: 'EUR',
        symbol: '€',
        thousandsSeparator: '.',
        decimalSeparator: ',',
      ),
    );
  });

  setUp(() {
    getCurrency = _MockGetCurrency();
    createCurrency = _MockCreateCurrency();
    updateCurrency = _MockUpdateCurrency();
    deleteCurrency = _MockDeleteCurrency();
    isCurrencyInUse = _MockIsCurrencyInUse();
    when(() => isCurrencyInUse(any())).thenAnswer((_) async => const Ok(false));
    when(() => getCurrency(any())).thenAnswer((_) async => const Ok(null));
    when(() => createCurrency(any())).thenAnswer((_) async => const Ok(null));
    when(() => updateCurrency(any())).thenAnswer((_) async => const Ok(null));
    when(() => deleteCurrency(any())).thenAnswer((_) async => const Ok(null));
  });

  CurrencyFormCubit buildCubit() => CurrencyFormCubit(
    getCurrency: getCurrency,
    createCurrency: createCurrency,
    updateCurrency: updateCurrency,
    deleteCurrency: deleteCurrency,
    isCurrencyInUse: isCurrencyInUse,
  );

  group('CurrencyFormCubit.load', () {
    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'starts an empty form for a new currency',
      build: buildCubit,
      act: (cubit) => cubit.load(null),
      expect: () => [
        const CurrencyFormState(status: CurrencyFormStatus.editing),
      ],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'fills the form with the stored currency',
      setUp: () =>
          when(() => getCurrency('EUR')).thenAnswer((_) async => const Ok(eur)),
      build: buildCubit,
      act: (cubit) => cubit.load('EUR'),
      expect: () => [editing],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'marks a currency used by accounts',
      setUp: () {
        when(() => getCurrency('EUR')).thenAnswer((_) async => const Ok(eur));
        when(() => isCurrencyInUse('EUR'))
            .thenAnswer((_) async => const Ok(true));
      },
      build: buildCubit,
      act: (cubit) => cubit.load('EUR'),
      expect: () => [editing.copyWith(inUse: true)],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'reports a missing currency',
      build: buildCubit,
      act: (cubit) => cubit.load('XYZ'),
      expect: () => [
        const CurrencyFormState(status: CurrencyFormStatus.notFound),
      ],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'reports a failed read',
      setUp: () =>
          when(() => getCurrency('EUR'))
              .thenAnswer((_) async => const Err(DatabaseFailure('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load('EUR'),
      expect: () => [
        isA<CurrencyFormState>()
            .having((s) => s.status, 'status', CurrencyFormStatus.notFound)
            .having((s) => s.failure, 'failure', isA<DatabaseFailure>()),
      ],
    );
  });

  group('CurrencyFormCubit fields', () {
    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'uppercases the code and updates every field',
      build: buildCubit,
      seed: () => const CurrencyFormState(status: CurrencyFormStatus.editing),
      act: (cubit) => cubit
        ..codeChanged(' eur ')
        ..symbolChanged('€')
        ..decimalsChanged(0)
        ..thousandsSeparatorChanged(' ')
        ..decimalSeparatorChanged('.'),
      skip: 4,
      expect: () => [
        const CurrencyFormState(
          status: CurrencyFormStatus.editing,
          code: 'EUR',
          symbol: '€',
          decimals: 0,
          thousandsSeparator: ' ',
          decimalSeparator: '.',
        ),
      ],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'never changes the decimals of a stored currency',
      build: buildCubit,
      seed: () => editing,
      act: (cubit) => cubit.decimalsChanged(0),
      expect: () => <CurrencyFormState>[],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'updates errors while typing after the first submit',
      build: buildCubit,
      seed: () => creating.copyWith(
        code: 'EU',
        errors: {CurrencyError.invalidCode},
        showErrors: true,
      ),
      act: (cubit) => cubit.codeChanged('EUR'),
      expect: () => [creating.copyWith(showErrors: true)],
    );
  });

  group('CurrencyFormCubit.submit', () {
    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'shows field errors instead of saving',
      build: buildCubit,
      seed: () => creating.copyWith(code: 'EU', symbol: ''),
      act: (cubit) => cubit.submit(),
      expect: () => [
        creating.copyWith(
          code: 'EU',
          symbol: '',
          showErrors: true,
          errors: {CurrencyError.invalidCode, CurrencyError.invalidSymbol},
        ),
      ],
      verify: (_) => verifyNever(() => createCurrency(any())),
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'flags a code that already exists',
      setUp: () =>
          when(() => getCurrency('EUR')).thenAnswer((_) async => const Ok(eur)),
      build: buildCubit,
      seed: () => creating,
      act: (cubit) => cubit.submit(),
      expect: () => [
        creating.copyWith(
          showErrors: true,
          errors: {CurrencyError.duplicateCode},
        ),
      ],
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'creates a new currency',
      build: buildCubit,
      seed: () => creating,
      act: (cubit) => cubit.submit(),
      expect: () => [
        creating.copyWith(status: CurrencyFormStatus.saving),
        creating.copyWith(status: CurrencyFormStatus.saved),
      ],
      verify: (_) => verify(
        () => createCurrency(
          const Currency(code: 'EUR', symbol: '€', format: CurrencyFormat.usd),
        ),
      ).called(1),
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'updates a stored currency',
      build: buildCubit,
      seed: () => editing.copyWith(symbol: 'EU'),
      act: (cubit) => cubit.submit(),
      expect: () => [
        editing.copyWith(symbol: 'EU', status: CurrencyFormStatus.saving),
        editing.copyWith(symbol: 'EU', status: CurrencyFormStatus.saved),
      ],
      verify: (_) {
        final params =
            verify(() => updateCurrency(captureAny())).captured.single
                as UpdateCurrencyParams;
        expect(params.code, 'EUR');
        expect(params.symbol, 'EU');
        expect(params.thousandsSeparator, ' ');
      },
    );

    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'keeps editing and exposes a failed save',
      setUp: () =>
          when(() => createCurrency(any()))
              .thenAnswer((_) async => const Err(DatabaseFailure('disk'))),
      build: buildCubit,
      seed: () => creating,
      act: (cubit) => cubit.submit(),
      expect: () => [
        creating.copyWith(status: CurrencyFormStatus.saving),
        isA<CurrencyFormState>()
            .having((s) => s.status, 'status', CurrencyFormStatus.editing)
            .having((s) => s.failure, 'failure', isA<DatabaseFailure>()),
      ],
    );
  });

  group('CurrencyFormCubit.delete', () {
    blocTest<CurrencyFormCubit, CurrencyFormState>(
      'deletes the currency',
      build: buildCubit,
      seed: () => editing,
      act: (cubit) => cubit.delete(),
      expect: () => [
        editing.copyWith(status: CurrencyFormStatus.saving),
        editing.copyWith(status: CurrencyFormStatus.deleted),
      ],
      verify: (_) => verify(() => deleteCurrency('EUR')).called(1),
    );
  });

  group('CurrencyFormState.format', () {
    test('is null while the separators are equal', () {
      expect(creating.copyWith(decimalSeparator: '.').format, isNull);
      expect(creating.format, CurrencyFormat.usd);
    });
  });
}
