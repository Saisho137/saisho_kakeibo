import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'recurring_occurrence.freezed.dart';

/// The movement a template created for the period starting on
/// [periodStart] (RT-07).
@freezed
abstract class RecurringOccurrence with _$RecurringOccurrence {
  const factory({
    required int id,
    required int templateId,
    required LocalDate periodStart,

    /// `null` once the movement was deleted (a cancelled pending one).
    int? movementId,

    /// Whether that movement still waits for its confirmation.
    @Default(false) bool isPending,
  }) = _RecurringOccurrence;
}

/// A change to an occurrence whose period start no longer exists: a
/// salary moved to another date, a manual start undone or a new cutoff
/// day (RF-06).
sealed class OccurrenceRepair {
  const new(this.occurrenceId);

  final int occurrenceId;
}

/// Moves the occurrence to the period its old start now falls in; a still
/// pending movement takes that period's date.
final class MoveOccurrence extends OccurrenceRepair {
  const new(
    super.occurrenceId, {
    required this.periodStart,
    this.movementId,
    this.date,
  });

  final LocalDate periodStart;

  /// The pending movement to move to [date]; `null` keeps the movement.
  final int? movementId;
  final LocalDate? date;
}

/// Drops the occurrence when its period already has one, deleting a still
/// pending movement so it does not count twice.
final class DropOccurrence extends OccurrenceRepair {
  const new(super.occurrenceId, {this.pendingMovementId});

  final int? pendingMovementId;
}
