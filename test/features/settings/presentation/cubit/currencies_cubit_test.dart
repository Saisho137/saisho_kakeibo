import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/watch_currencies.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currencies_cubit.dart';

class _MockWatchCurrencies extends Mock implements WatchCurrencies;

void main() {
  late _MockWatchCurrencies watchCurrencies;

  setUpAll(() => registerFallbackValue(const NoParams()));

  setUp(() => watchCurrencies = _MockWatchCurrencies());

  CurrenciesCubit buildCubit() =>
      CurrenciesCubit(watchCurrencies: watchCurrencies);

  const currencies = [
    Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop),
  ];

  group('CurrenciesCubit', () {
    test('starts loading', () {
      expect(buildCubit().state, const CurrenciesState());
    });

    blocTest<CurrenciesCubit, CurrenciesState>(
      'emits the currencies pushed by the stream',
      setUp: () =>
          when(() => watchCurrencies(any()))
              .thenAnswer((_) => Stream.value(currencies)),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        const CurrenciesState(
          status: CurrenciesStatus.success,
          currencies: currencies,
        ),
      ],
    );

    blocTest<CurrenciesCubit, CurrenciesState>(
      'emits failure when the stream errors',
      setUp: () =>
          when(() => watchCurrencies(any()))
              .thenAnswer((_) => Stream.error(Exception('boom'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<CurrenciesState>()
            .having((s) => s.status, 'status', CurrenciesStatus.failure)
            .having((s) => s.failure, 'failure', isA<UnexpectedFailure>()),
      ],
    );
  });
}
