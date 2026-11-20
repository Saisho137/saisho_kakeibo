import 'dart:math';

import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';

/// Splits time into periods of a [PeriodType] (RF-05, RF-14, RT-06).
///
/// - **Monthly:** from the cutoff day to the day before the next one. A
///   month without that day starts on its last day.
/// - **Yearly:** the calendar year.
/// - **Dynamic:** from one period start (a salary with "Starts period" or a
///   manual start) to the day before the next one. The latest is open.
///   Before the first start, monthly periods are the fallback, the last one
///   cut the day before that start.
final class PeriodCalculator {
  new({
    required this.type,
    required this.cutoffDay,
    Iterable<LocalDate> starts = const [],
  }) : _starts = starts.toSet().toList()..sort();

  final PeriodType type;
  final int cutoffDay;

  /// Period starts, sorted and without repeats.
  final List<LocalDate> _starts;

  /// The period that contains [date].
  Period periodOf(LocalDate date) => switch (type) {
    PeriodType.monthly => _monthly(date),
    PeriodType.yearly => Period(
      start: LocalDate(date.year, 1, 1),
      end: LocalDate(date.year, 12, 31),
    ),
    PeriodType.dynamic => _dynamic(date),
  };

  Period previous(Period period) => periodOf(period.start.addDays(-1));

  /// `null` after the open period.
  Period? next(Period period) {
    final end = period.end;
    return end == null ? null : periodOf(end.addDays(1));
  }

  /// Periods from the one of [newest] back to the one of [oldest], newest
  /// first.
  List<Period> range({required LocalDate oldest, required LocalDate newest}) {
    final periods = [periodOf(newest)];
    while (periods.last.start.isAfter(oldest)) {
      periods.add(previous(periods.last));
    }
    return periods;
  }

  /// Periods to page through: from the one of the latest of [today] and
  /// [dates] back to the one of the earliest, newest first.
  List<Period> covering(LocalDate today, Iterable<LocalDate> dates) {
    var oldest = today;
    var newest = today;
    for (final date in dates) {
      if (date.isBefore(oldest)) oldest = date;
      if (date.isAfter(newest)) newest = date;
    }
    return range(oldest: oldest, newest: newest);
  }

  Period _monthly(LocalDate date) {
    var start = _cutoffIn(date.year, date.month);
    if (date.isBefore(start)) start = _cutoffIn(date.year, date.month - 1);
    final next = _cutoffIn(start.year, start.month + 1);
    return Period(start: start, end: next.addDays(-1));
  }

  LocalDate _cutoffIn(int year, int month) {
    final first = LocalDate(year, month, 1);
    return LocalDate(
      first.year,
      first.month,
      min(cutoffDay, first.daysInMonth),
    );
  }

  Period _dynamic(LocalDate date) {
    final index = _starts.lastIndexWhere((s) => !s.isAfter(date));
    if (index == -1) {
      final monthly = _monthly(date);
      final first = _starts.firstOrNull;
      if (first == null || monthly.end!.isBefore(first)) return monthly;
      return Period(start: monthly.start, end: first.addDays(-1));
    }
    final next = index + 1 < _starts.length ? _starts[index + 1] : null;
    return Period(start: _starts[index], end: next?.addDays(-1));
  }
}
