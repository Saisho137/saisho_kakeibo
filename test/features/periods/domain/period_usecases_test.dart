import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/remove_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/start_period_now.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_manual_period_starts.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';

class _MockPeriodRepository extends Mock implements PeriodRepository;

void main() {
  late _MockPeriodRepository repository;

  const dbError = Err<Never>(DatabaseFailure('disk'));
  final day = LocalDate(2026, 11, 20);

  setUpAll(() => registerFallbackValue(day));

  setUp(() {
    repository = _MockPeriodRepository();
    when(() => repository.getStarts()).thenAnswer((_) async => const Ok([]));
    when(() => repository.addStart(any()))
        .thenAnswer((_) async => const Ok(null));
    when(() => repository.removeStart(any()))
        .thenAnswer((_) async => const Ok(null));
  });

  group('streams and removal', () {
    test('forward to the repository', () async {
      when(() => repository.watchStarts())
          .thenAnswer((_) => Stream.value([day]));
      when(() => repository.watchManualStarts())
          .thenAnswer((_) => Stream.value([day]));

      expect(await WatchPeriodStarts(repository)(const NoParams()).first, [
        day,
      ]);
      expect(
        await WatchManualPeriodStarts(repository)(const NoParams()).first,
        [day],
      );
      await RemovePeriodStart(repository)(day);
      verify(() => repository.removeStart(day)).called(1);
    });
  });

  group('StartPeriodNow', () {
    test('saves a manual start', () async {
      expect((await StartPeriodNow(repository)(day) as Ok<bool>).value, isTrue);
      verify(() => repository.addStart(day)).called(1);
    });

    test('does nothing when a period already starts that day', () async {
      when(() => repository.getStarts()).thenAnswer((_) async => Ok([day]));

      expect(
        (await StartPeriodNow(repository)(day) as Ok<bool>).value,
        isFalse,
      );
      verifyNever(() => repository.addStart(any()));
    });

    test('propagates failures', () async {
      when(() => repository.addStart(any())).thenAnswer((_) async => dbError);
      expect(await StartPeriodNow(repository)(day), isA<Err<bool>>());
      when(() => repository.getStarts()).thenAnswer((_) async => dbError);
      expect(await StartPeriodNow(repository)(day), isA<Err<bool>>());
    });
  });

  group('SuggestPeriodStart', () {
    Future<bool?> suggest(int days) async {
      final result = await SuggestPeriodStart(repository)(
        SuggestPeriodStartParams(date: day.addDays(days), minDays: 21),
      );
      return result is Ok<bool> ? result.value : null;
    }

    test('suggests a first period and one after N days', () async {
      expect(await suggest(0), isTrue);

      when(() => repository.getStarts()).thenAnswer((_) async => Ok([day]));
      expect(await suggest(20), isFalse);
      expect(await suggest(21), isTrue);
    });

    test('counts from the latest start up to the salary date', () async {
      when(
        () => repository.getStarts(),
      ).thenAnswer((_) async => Ok([day.addDays(-30), day, day.addDays(40)]));

      expect(await suggest(-1), isTrue);
      expect(await suggest(5), isFalse);
    });

    test('propagates failures', () async {
      when(() => repository.getStarts()).thenAnswer((_) async => dbError);
      expect(await suggest(0), isNull);
    });
  });
}
