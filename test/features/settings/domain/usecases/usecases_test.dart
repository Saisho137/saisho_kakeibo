import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/create_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/delete_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_currency.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/update_settings.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_settings.dart';

class _MockCurrencyRepository extends Mock implements CurrencyRepository;

class _MockSettingsRepository extends Mock implements SettingsRepository;

void main() {
  late _MockCurrencyRepository currencies;
  late _MockSettingsRepository settings;

  const eur = Currency(
    code: 'EUR',
    symbol: '€',
    format: CurrencyFormat(decimals: 2, thousandsSeparator: ' '),
  );
  const cop = Currency(
    code: 'COP',
    symbol: r'$',
    format: CurrencyFormat.cop,
    isBuiltIn: true,
  );
  const dbError = Err<Never>(DatabaseFailure('disk full'));

  setUpAll(() {
    registerFallbackValue(eur);
    registerFallbackValue(const AppSettings());
  });

  setUp(() {
    currencies = _MockCurrencyRepository();
    settings = _MockSettingsRepository();
    when(() => currencies.create(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => currencies.update(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => currencies.delete(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => settings.save(any())).thenAnswer((_) async => const Ok(null));
    when(() => settings.getSettings())
        .thenAnswer((_) async => const Ok(AppSettings()));
  });

  void givenCurrency(String code, Currency? currency) =>
      when(() => currencies.findByCode(code))
          .thenAnswer((_) async => Ok(currency));

  group('WatchCurrencies', () {
    test('streams the repository currencies', () {
      when(() => currencies.watchCurrencies())
          .thenAnswer((_) => Stream.value([cop]));

      expect(WatchCurrencies(currencies)(const NoParams()), emits([cop]));
    });
  });

  group('CreateCurrency', () {
    test('creates a valid user currency with a trimmed symbol', () async {
      givenCurrency('EUR', null);

      final result = await CreateCurrency(currencies)(
        eur.copyWith(symbol: ' € ', isBuiltIn: true),
      );

      expect(result.isOk, isTrue);
      verify(() => currencies.create(eur)).called(1);
    });

    test('rejects an existing code', () async {
      givenCurrency('EUR', eur);

      final result = await CreateCurrency(currencies)(eur);

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => currencies.create(any()));
    });

    test('rejects invalid fields', () async {
      givenCurrency('eu', null);

      final result = await CreateCurrency(currencies)(eur.copyWith(code: 'eu'));

      expect((result as Err).failure, isA<ValidationFailure>());
    });

    test('propagates a repository failure', () async {
      when(() => currencies.findByCode('EUR')).thenAnswer((_) async => dbError);

      final result = await CreateCurrency(currencies)(eur);

      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });

  group('UpdateCurrency', () {
    const params = UpdateCurrencyParams(
      code: 'EUR',
      symbol: ' EU ',
      thousandsSeparator: ',',
      decimalSeparator: '.',
    );

    test('changes symbol and separators, keeping the decimals', () async {
      givenCurrency('EUR', eur);

      final result = await UpdateCurrency(currencies)(params);

      expect(result.isOk, isTrue);
      verify(
        () => currencies.update(
          eur.copyWith(
            symbol: 'EU',
            format: const CurrencyFormat(
              decimals: 2,
              thousandsSeparator: ',',
              decimalSeparator: '.',
            ),
          ),
        ),
      ).called(1);
    });

    test('rejects an unknown currency', () async {
      givenCurrency('EUR', null);

      final result = await UpdateCurrency(currencies)(params);

      expect((result as Err).failure, isA<ValidationFailure>());
    });

    test('rejects equal separators', () async {
      givenCurrency('EUR', eur);

      final result = await UpdateCurrency(currencies)(
        const UpdateCurrencyParams(
          code: 'EUR',
          symbol: '€',
          thousandsSeparator: '.',
          decimalSeparator: '.',
        ),
      );

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => currencies.update(any()));
    });

    test('propagates a repository failure', () async {
      when(() => currencies.findByCode('EUR')).thenAnswer((_) async => dbError);

      final result = await UpdateCurrency(currencies)(params);

      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });

  group('DeleteCurrency', () {
    test('deletes a user currency that is not the main one', () async {
      givenCurrency('EUR', eur);

      final result = await DeleteCurrency(currencies, settings)('EUR');

      expect(result.isOk, isTrue);
      verify(() => currencies.delete('EUR')).called(1);
    });

    test('keeps built-in currencies', () async {
      givenCurrency('USD', cop.copyWith(code: 'USD'));

      final result = await DeleteCurrency(currencies, settings)('USD');

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => currencies.delete(any()));
    });

    test('keeps the main currency', () async {
      givenCurrency('EUR', eur);
      when(
        () => settings.getSettings(),
      ).thenAnswer((_) async => const Ok(AppSettings(mainCurrencyCode: 'EUR')));

      final result = await DeleteCurrency(currencies, settings)('EUR');

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => currencies.delete(any()));
    });

    test('propagates repository failures', () async {
      when(() => currencies.findByCode('EUR')).thenAnswer((_) async => dbError);
      expect(
        (await DeleteCurrency(currencies, settings)('EUR') as Err).failure,
        isA<DatabaseFailure>(),
      );

      givenCurrency('EUR', eur);
      when(() => settings.getSettings()).thenAnswer((_) async => dbError);
      expect(
        (await DeleteCurrency(currencies, settings)('EUR') as Err).failure,
        isA<DatabaseFailure>(),
      );
    });
  });

  group('WatchSettings', () {
    test('streams the repository settings', () {
      when(() => settings.watchSettings())
          .thenAnswer((_) => Stream.value(const AppSettings()));

      expect(
        WatchSettings(settings)(const NoParams()),
        emits(const AppSettings()),
      );
    });
  });

  group('UpdateSettings', () {
    test('saves valid settings', () async {
      final result = await UpdateSettings(settings)(
        const AppSettings(cutoffDay: 5),
      );

      expect(result.isOk, isTrue);
      verify(() => settings.save(const AppSettings(cutoffDay: 5))).called(1);
    });

    test('rejects settings out of range', () async {
      final result = await UpdateSettings(settings)(
        const AppSettings(cutoffDay: 40),
      );

      expect((result as Err).failure, isA<ValidationFailure>());
      verifyNever(() => settings.save(any()));
    });
  });
}
