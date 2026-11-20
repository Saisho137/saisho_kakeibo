import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/remove_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/start_period_now.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_manual_period_starts.dart';
import 'package:saisho_kakeibo/features/periods/presentation/cubit/period_starts_cubit.dart';

class _MockWatch extends Mock implements WatchManualPeriodStarts;

class _MockStart extends Mock implements StartPeriodNow;

class _MockRemove extends Mock implements RemovePeriodStart;

void main() {
  late _MockWatch watch;
  late _MockStart start;
  late _MockRemove remove;

  final day = LocalDate(2026, 11, 3);
  const dbError = Err<Never>(DatabaseFailure('disk'));

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(day);
  });

  setUp(() {
    watch = _MockWatch();
    start = _MockStart();
    remove = _MockRemove();
    when(() => watch(any())).thenAnswer((_) => Stream.value([day]));
    when(() => start(any())).thenAnswer((_) async => const Ok(true));
    when(() => remove(any())).thenAnswer((_) async => const Ok(null));
  });

  PeriodStartsCubit buildCubit() => PeriodStartsCubit(
    watchManualStarts: watch,
    startPeriodNow: start,
    removeStart: remove,
  );

  group('PeriodStartsCubit', () {
    blocTest<PeriodStartsCubit, PeriodStartsState>(
      'lists the manual starts',
      build: buildCubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        PeriodStartsState(manualStarts: [day]),
      ],
    );

    blocTest<PeriodStartsCubit, PeriodStartsState>(
      'reports a stream error',
      setUp: () =>
          when(() => watch(any()))
              .thenAnswer((_) => Stream.error(Exception('disk'))),
      build: buildCubit,
      act: (cubit) => cubit.load(),
      verify: (cubit) => expect(cubit.state.failure, isA<UnexpectedFailure>()),
    );

    blocTest<PeriodStartsCubit, PeriodStartsState>(
      'starts a period today and tells whether it did',
      build: buildCubit,
      act: (cubit) async {
        await cubit.startNow();
        when(() => start(any())).thenAnswer((_) async => const Ok(false));
        await cubit.startNow();
      },
      expect: () => const [
        PeriodStartsState(notice: PeriodStartNotice.started, notices: 1),
        PeriodStartsState(notice: PeriodStartNotice.alreadyStarted, notices: 2),
      ],
      verify: (_) => verify(() => start(LocalDate.today())).called(2),
    );

    blocTest<PeriodStartsCubit, PeriodStartsState>(
      'removes a start and exposes failures',
      setUp: () {
        when(() => start(any())).thenAnswer((_) async => dbError);
        when(() => remove(any())).thenAnswer((_) async => dbError);
      },
      build: buildCubit,
      act: (cubit) async {
        await cubit.remove(day);
        await cubit.startNow();
      },
      expect: () => const [PeriodStartsState(failure: DatabaseFailure('disk'))],
      verify: (_) => verify(() => remove(day)).called(1),
    );

    test('cancels its stream when closed', () async {
      final controller = StreamController<List<LocalDate>>();
      when(() => watch(any())).thenAnswer((_) => controller.stream);
      final cubit = buildCubit()..load();

      await cubit.close();

      expect(controller.hasListener, isFalse);
    });
  });
}
