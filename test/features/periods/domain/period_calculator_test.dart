import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';

LocalDate d(int year, int month, int day) => LocalDate(year, month, day);

Period p(LocalDate start, [LocalDate? end]) => Period(start: start, end: end);

void main() {
  group('Period', () {
    test('contains its days, an open one every later day', () {
      final closed = p(d(2026, 3, 1), d(2026, 3, 31));
      expect(closed.contains(d(2026, 3, 1)), isTrue);
      expect(closed.contains(d(2026, 3, 31)), isTrue);
      expect(closed.contains(d(2026, 4, 1)), isFalse);
      expect(closed.contains(d(2026, 2, 28)), isFalse);
      expect(closed.isOpen, isFalse);
      final open = p(d(2026, 3, 1));
      expect(open.contains(d(2030, 1, 1)), isTrue);
      expect(open.isOpen, isTrue);
    });
  });

  group('monthly', () {
    PeriodCalculator monthly(int cutoffDay) =>
        PeriodCalculator(type: PeriodType.monthly, cutoffDay: cutoffDay);

    test('goes from the cutoff day to the day before the next one', () {
      final calculator = monthly(27);
      final period = p(d(2026, 10, 27), d(2026, 11, 26));
      expect(calculator.periodOf(d(2026, 10, 27)), period);
      expect(calculator.periodOf(d(2026, 11, 20)), period);
      expect(calculator.periodOf(d(2026, 11, 26)), period);
      expect(
        calculator.periodOf(d(2026, 11, 27)),
        p(d(2026, 11, 27), d(2026, 12, 26)),
      );
    });

    test('crosses the year', () {
      expect(
        monthly(27).periodOf(d(2027, 1, 3)),
        p(d(2026, 12, 27), d(2027, 1, 26)),
      );
    });

    test('a month without the cutoff day starts on its last day', () {
      final calculator = monthly(31);
      expect(
        calculator.periodOf(d(2026, 3, 15)),
        p(d(2026, 2, 28), d(2026, 3, 30)),
      );
      expect(
        calculator.periodOf(d(2026, 4, 30)),
        p(d(2026, 4, 30), d(2026, 5, 30)),
      );
    });

    test('February of a leap year has its 29th', () {
      final calculator = monthly(30);
      expect(
        calculator.periodOf(d(2028, 2, 29)),
        p(d(2028, 2, 29), d(2028, 3, 29)),
      );
      expect(
        calculator.periodOf(d(2028, 2, 28)),
        p(d(2028, 1, 30), d(2028, 2, 28)),
      );
      expect(
        calculator.periodOf(d(2027, 3, 1)),
        p(d(2027, 2, 28), d(2027, 3, 29)),
      );
    });

    test('day 1 matches the calendar month', () {
      expect(
        monthly(1).periodOf(d(2026, 2, 14)),
        p(d(2026, 2, 1), d(2026, 2, 28)),
      );
    });
  });

  group('yearly', () {
    test('is the calendar year, whatever the cutoff day', () {
      final calculator = PeriodCalculator(
        type: PeriodType.yearly,
        cutoffDay: 27,
        starts: [d(2026, 5, 23)],
      );
      final year = p(d(2026, 1, 1), d(2026, 12, 31));
      expect(calculator.periodOf(d(2026, 1, 1)), year);
      expect(calculator.periodOf(d(2026, 12, 31)), year);
      expect(calculator.previous(year), p(d(2025, 1, 1), d(2025, 12, 31)));
      expect(calculator.next(year), p(d(2027, 1, 1), d(2027, 12, 31)));
    });
  });

  group('dynamic', () {
    PeriodCalculator dynamic(List<LocalDate> starts) => PeriodCalculator(
      type: PeriodType.dynamic,
      cutoffDay: 27,
      starts: starts,
    );

    test('without salaries falls back to the cutoff day', () {
      expect(
        dynamic([]).periodOf(d(2026, 11, 20)),
        p(d(2026, 10, 27), d(2026, 11, 26)),
      );
    });

    test('goes from salary to salary, the last one open', () {
      final calculator = dynamic([d(2026, 9, 23), d(2026, 10, 29)]);
      expect(
        calculator.periodOf(d(2026, 10, 1)),
        p(d(2026, 9, 23), d(2026, 10, 28)),
      );
      expect(calculator.periodOf(d(2026, 10, 29)), p(d(2026, 10, 29)));
      expect(calculator.periodOf(d(2027, 3, 1)), p(d(2026, 10, 29)));
    });

    test('a salary on the 23rd or the 29th moves the boundary', () {
      for (final payday in [23, 29]) {
        final calculator = dynamic([d(2026, 9, payday), d(2026, 10, payday)]);
        expect(
          calculator.periodOf(d(2026, 10, payday - 1)),
          p(d(2026, 9, payday), d(2026, 10, payday - 1)),
          reason: '$payday',
        );
        expect(
          calculator.periodOf(d(2026, 10, payday)).start,
          d(2026, 10, payday),
        );
      }
    });

    test('cuts the fallback period the day before the first salary', () {
      final calculator = dynamic([d(2026, 10, 23)]);
      expect(
        calculator.periodOf(d(2026, 10, 10)),
        p(d(2026, 9, 27), d(2026, 10, 22)),
      );
      expect(
        calculator.periodOf(d(2026, 9, 10)),
        p(d(2026, 8, 27), d(2026, 9, 26)),
      );
    });

    test('a first salary on the cutoff day leaves the fallback whole', () {
      expect(
        dynamic([d(2026, 10, 27)]).periodOf(d(2026, 10, 26)),
        p(d(2026, 9, 27), d(2026, 10, 26)),
      );
    });

    test('ignores repeated and unsorted starts', () {
      final calculator = dynamic([
        d(2026, 10, 23),
        d(2026, 9, 23),
        d(2026, 10, 23),
      ]);
      expect(
        calculator.periodOf(d(2026, 10, 1)),
        p(d(2026, 9, 23), d(2026, 10, 22)),
      );
    });

    test('moves to the previous and next periods', () {
      final calculator = dynamic([d(2026, 9, 23), d(2026, 10, 29)]);
      final open = p(d(2026, 10, 29));
      expect(calculator.next(open), isNull);
      final middle = calculator.previous(open);
      expect(middle, p(d(2026, 9, 23), d(2026, 10, 28)));
      expect(calculator.next(middle), open);
      expect(calculator.previous(middle), p(d(2026, 8, 27), d(2026, 9, 22)));
    });
  });

  group('range', () {
    test('lists the periods newest first', () {
      final calculator = PeriodCalculator(
        type: PeriodType.dynamic,
        cutoffDay: 27,
        starts: [d(2026, 10, 23)],
      );
      expect(calculator.range(oldest: d(2026, 9, 1), newest: d(2026, 11, 20)), [
        p(d(2026, 10, 23)),
        p(d(2026, 9, 27), d(2026, 10, 22)),
        p(d(2026, 8, 27), d(2026, 9, 26)),
      ]);
    });

    test('is one period when both days share it', () {
      final calculator = PeriodCalculator(
        type: PeriodType.monthly,
        cutoffDay: 27,
      );
      expect(
        calculator.range(oldest: d(2026, 11, 20), newest: d(2026, 11, 1)),
        [p(d(2026, 10, 27), d(2026, 11, 26))],
      );
    });

    test('changing the period type changes the split', () {
      final starts = [d(2026, 10, 23)];
      List<Period> range(PeriodType type) => PeriodCalculator(
        type: type,
        cutoffDay: 27,
        starts: starts,
      ).range(oldest: d(2026, 10, 1), newest: d(2026, 11, 20));
      expect(range(PeriodType.dynamic), hasLength(2));
      expect(range(PeriodType.monthly), [
        p(d(2026, 10, 27), d(2026, 11, 26)),
        p(d(2026, 9, 27), d(2026, 10, 26)),
      ]);
      expect(range(PeriodType.yearly), [p(d(2026, 1, 1), d(2026, 12, 31))]);
    });

    test('covers today and every date, newest first', () {
      final calculator = PeriodCalculator(
        type: PeriodType.monthly,
        cutoffDay: 1,
      );
      expect(
        calculator.covering(d(2026, 3, 10), [d(2026, 4, 2), d(2026, 1, 31)]),
        [
          p(d(2026, 4, 1), d(2026, 4, 30)),
          p(d(2026, 3, 1), d(2026, 3, 31)),
          p(d(2026, 2, 1), d(2026, 2, 28)),
          p(d(2026, 1, 1), d(2026, 1, 31)),
        ],
      );
      expect(calculator.covering(d(2026, 3, 10), []), hasLength(1));
    });
  });
}
