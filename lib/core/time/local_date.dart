import 'package:meta/meta.dart';

/// A calendar date without time or time zone.
///
/// Movements and periods happen on a day, not at an instant, so they use this
/// type instead of [DateTime]. It is stored as `YYYY-MM-DD` text.
@immutable
final class LocalDate implements Comparable<LocalDate> {
  /// Creates a date, normalizing overflowing values (`LocalDate(2026, 13, 1)`
  /// is `2027-01-01`), like [DateTime] does.
  factory(int year, int month, int day) {
    final utc = DateTime.utc(year, month, day);
    return LocalDate._(utc.year, utc.month, utc.day);
  }

  const new _(this.year, this.month, this.day);

  /// The calendar date of [dateTime], in its own time zone.
  factory fromDateTime(DateTime dateTime) =>
      LocalDate._(dateTime.year, dateTime.month, dateTime.day);

  /// Today's date in the device time zone.
  factory today() => LocalDate.fromDateTime(DateTime.now());

  /// Parses an ISO-8601 date (`YYYY-MM-DD`).
  ///
  /// Throws a [FormatException] when [source] is not a valid date.
  factory parse(String source) {
    final match = _isoPattern.firstMatch(source);
    if (match == null) {
      throw FormatException('Invalid date, expected YYYY-MM-DD', source);
    }
    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final date = LocalDate(year, month, day);
    if (date.month != month || date.day != day) {
      throw FormatException('Invalid date', source);
    }
    return date;
  }

  static final RegExp _isoPattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');

  final int year;
  final int month;
  final int day;

  /// Number of days in this date's month.
  int get daysInMonth => DateTime.utc(year, month + 1, 0).day;

  LocalDate addDays(int days) => LocalDate(year, month, day + days);

  /// Adds [months], clamping the day to the target month's length
  /// (`2026-01-31` plus one month is `2026-02-28`).
  LocalDate addMonths(int months) {
    final firstOfTarget = LocalDate(year, month + months, 1);
    final clampedDay = day.clamp(1, firstOfTarget.daysInMonth);
    return LocalDate(firstOfTarget.year, firstOfTarget.month, clampedDay);
  }

  /// Whole days from this date to [other] (negative if [other] is earlier).
  int daysUntil(LocalDate other) => other._utc.difference(_utc).inDays;

  bool isBefore(LocalDate other) => compareTo(other) < 0;

  bool isAfter(LocalDate other) => compareTo(other) > 0;

  /// Midnight of this date in the device time zone.
  DateTime toDateTime() => DateTime(year, month, day);

  DateTime get _utc => DateTime.utc(year, month, day);

  @override
  int compareTo(LocalDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  @override
  bool operator ==(Object other) =>
      other is LocalDate &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  /// ISO-8601 representation (`YYYY-MM-DD`).
  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';
}
