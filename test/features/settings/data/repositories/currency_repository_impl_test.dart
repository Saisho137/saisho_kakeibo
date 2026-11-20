import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currency_dao.dart';
import 'package:saisho_kakeibo/features/settings/data/repositories/currency_repository_impl.dart';

class _MockCurrencyDao extends Mock implements CurrencyDao;

void main() {
  late AppDatabase db;
  late CurrencyRepositoryImpl repository;

  const eur = Currency(
    code: 'EUR',
    symbol: '€',
    format: CurrencyFormat(decimals: 2, thousandsSeparator: ' '),
  );

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = CurrencyRepositoryImpl(db.currencyDao);
  });

  tearDown(() => db.close());

  group('CurrencyRepositoryImpl', () {
    test('lists built-in currencies first, then by code', () async {
      await repository.create(
        const Currency(code: 'AUD', symbol: r'A$', format: CurrencyFormat.usd),
      );

      final codes = (await repository.watchCurrencies().first).map(
        (c) => c.code,
      );

      expect(codes, ['COP', 'USD', 'AUD']);
    });

    test('creates and finds a currency', () async {
      await repository.create(eur);

      final found = await repository.findByCode('EUR');

      expect(found, isA<Ok<Currency?>>());
      expect((found as Ok<Currency?>).value, eur);
    });

    test('finds nothing for an unknown code', () async {
      final found = await repository.findByCode('XYZ') as Ok<Currency?>;

      expect(found.value, isNull);
    });

    test('updates symbol and separators but keeps the decimals', () async {
      await repository.create(eur);

      await repository.update(
        eur.copyWith(
          symbol: 'EUR',
          format: const CurrencyFormat(
            decimals: 4,
            thousandsSeparator: ',',
            decimalSeparator: '.',
          ),
        ),
      );

      final found =
          (await repository.findByCode('EUR') as Ok<Currency?>).value!;
      expect(found.symbol, 'EUR');
      expect(found.format.thousandsSeparator, ',');
      expect(found.format.decimalSeparator, '.');
      expect(found.format.decimals, 2);
    });

    test('deletes a currency', () async {
      await repository.create(eur);

      await repository.delete('EUR');

      final found = await repository.findByCode('EUR') as Ok<Currency?>;
      expect(found.value, isNull);
    });

    test('rejects a duplicated code', () async {
      final result = await repository.create(
        const Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop),
      );

      expect((result as Err).failure, isA<DatabaseFailure>());
    });

    test('the database refuses to delete the main currency', () async {
      final result = await repository.delete('COP');

      expect((result as Err).failure, isA<DatabaseFailure>());
    });

    test('translates data source exceptions into a DatabaseFailure', () async {
      final dao = _MockCurrencyDao();
      when(() => dao.findByCode(any())).thenThrow(Exception('disk full'));

      final result = await CurrencyRepositoryImpl(dao).findByCode('COP');

      expect((result as Err).failure, isA<DatabaseFailure>());
    });
  });
}
