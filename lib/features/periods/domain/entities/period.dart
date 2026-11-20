import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'period.freezed.dart';

/// A range of days the Home and the account detail show at once (RF-14).
@freezed
abstract class Period with _$Period {
  const factory({
    required LocalDate start,

    /// Last day, inclusive. `null` for the latest dynamic period, which
    /// lasts until the next period start.
    LocalDate? end,
  }) = _Period;

  const new _();

  bool get isOpen => end == null;

  bool contains(LocalDate date) {
    final end = this.end;
    return !date.isBefore(start) && (end == null || !date.isAfter(end));
  }
}
