import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

void main() {
  group('LocalDate', () {
    test('normalizes overflowing values', () {
      expect(LocalDate(2026, 13, 1), LocalDate(2027, 1, 1));
      expect(LocalDate(2026, 3, 0), LocalDate(2026, 2, 28));
    });

    test('drops the time of a DateTime', () {
      final date = LocalDate.fromDateTime(DateTime(2026, 11, 19, 23, 59));

      expect(date, LocalDate(2026, 11, 19));
    });

    test('today matches the device date', () {
      final now = DateTime.now();

      expect(LocalDate.today(), LocalDate(now.year, now.month, now.day));
    });

    test('formats and parses ISO-8601', () {
      final date = LocalDate(2026, 2, 5);

      expect(date.toString(), '2026-02-05');
      expect(LocalDate.parse('2026-02-05'), date);
    });

    test('rejects malformed or impossible dates', () {
      expect(() => LocalDate.parse('2026-2-5'), throwsFormatException);
      expect(() => LocalDate.parse('2026-02-30'), throwsFormatException);
      expect(() => LocalDate.parse('2026-13-01'), throwsFormatException);
    });

    test('knows the length of its month, including leap years', () {
      expect(LocalDate(2028, 2, 1).daysInMonth, 29);
      expect(LocalDate(2026, 2, 1).daysInMonth, 28);
      expect(LocalDate(2026, 12, 1).daysInMonth, 31);
    });

    test('adds days across months and years', () {
      expect(LocalDate(2026, 12, 31).addDays(1), LocalDate(2027, 1, 1));
      expect(LocalDate(2026, 3, 1).addDays(-1), LocalDate(2026, 2, 28));
    });

    test('adds months clamping the day', () {
      expect(LocalDate(2026, 1, 31).addMonths(1), LocalDate(2026, 2, 28));
      expect(LocalDate(2028, 1, 31).addMonths(1), LocalDate(2028, 2, 29));
      expect(LocalDate(2026, 11, 27).addMonths(2), LocalDate(2027, 1, 27));
      expect(LocalDate(2026, 1, 15).addMonths(-1), LocalDate(2025, 12, 15));
    });

    test('counts days between dates, ignoring daylight saving', () {
      expect(LocalDate(2026, 10, 23).daysUntil(LocalDate(2026, 11, 13)), 21);
      expect(LocalDate(2026, 3, 1).daysUntil(LocalDate(2026, 2, 1)), -28);
    });

    test('compares chronologically', () {
      final a = LocalDate(2026, 5, 31);
      final b = LocalDate(2026, 6, 1);

      expect(a.isBefore(b), isTrue);
      expect(b.isAfter(a), isTrue);
      expect(a.compareTo(a), 0);
      expect([b, a]..sort(), [a, b]);
      expect(LocalDate(2025, 12, 31).isBefore(a), isTrue);
    });

    test('has value equality', () {
      expect(LocalDate(2026, 1, 1), LocalDate(2026, 1, 1));
      expect(LocalDate(2026, 1, 1).hashCode, LocalDate(2026, 1, 1).hashCode);
      expect(LocalDate(2026, 1, 1), isNot(LocalDate(2026, 1, 2)));
    });

    test('converts to local midnight', () {
      expect(LocalDate(2026, 4, 9).toDateTime(), DateTime(2026, 4, 9));
    });
  });
}
