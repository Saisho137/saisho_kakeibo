import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_occurrence.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';

/// A pending movement a template owes to the period starting on
/// [periodStart].
@immutable
final class PlannedOccurrence {
  const new({
    required this.templateId,
    required this.periodStart,
    required this.movement,
  });

  final int templateId;
  final LocalDate periodStart;
  final Movement movement;

  @override
  bool operator ==(Object other) =>
      other is PlannedOccurrence &&
      other.templateId == templateId &&
      other.periodStart == periodStart &&
      other.movement == movement;

  @override
  int get hashCode => Object.hash(templateId, periodStart, movement);
}

/// Decides which pending movements the templates owe (RF-06, RT-07).
///
/// Each active template owes one movement to the current period of its
/// cadence: the latest dynamic start, or the monthly period of today.
/// It owes nothing to the period it was created in, to a period that
/// already had its occurrence (even if that movement was later cancelled),
/// while one of its accounts is archived, or once the debt it pays is
/// settled. The amount is the last
/// confirmed one.
abstract final class RecurringPlanner {
  static List<PlannedOccurrence> plan({
    required List<RecurringTemplate> templates,
    required List<Account> accounts,
    required LocalDate today,
    required List<LocalDate> dynamicStarts,
    required int cutoffDay,
    required Set<(int, LocalDate)> occurrences,
    Set<int> settledDebts = const {},
  }) {
    final latestStart = dynamicStarts
        .where((s) => !s.isAfter(today))
        .fold<LocalDate?>(
          null,
          (latest, s) => latest == null || s.isAfter(latest) ? s : latest,
        );
    final dynamicPeriod = latestStart == null
        ? null
        : PeriodCalculator(
            type: PeriodType.dynamic,
            cutoffDay: cutoffDay,
            starts: dynamicStarts,
          ).periodOf(latestStart);
    final monthlyPeriod = PeriodCalculator(
      type: PeriodType.monthly,
      cutoffDay: cutoffDay,
    ).periodOf(today);

    bool usable(int? id) {
      if (id == null) return true;
      final account = accounts.byId(id);
      return account != null && !account.isArchived;
    }

    return [
      for (final template in templates)
        if (template.isActive &&
            usable(template.accountId) &&
            usable(template.toAccountId) &&
            !settledDebts.contains(template.debtId))
          if (switch (template.cadence) {
                RecurringCadence.period => dynamicPeriod,
                RecurringCadence.monthly => monthlyPeriod,
              }
              case final Period period
              when period.start.isAfter(template.createdOn) &&
                  !occurrences.contains((template.id, period.start)))
            PlannedOccurrence(
              templateId: template.id,
              periodStart: period.start,
              movement: template.toMovement(
                RecurringRules.dateIn(template, period),
              ),
            ),
    ];
  }

  /// Repairs the occurrences whose period start no longer exists. Each one
  /// goes to the period its old start now falls in: there it moves, with
  /// its pending movement, unless that period already has an occurrence or
  /// is not a valid period of the template; then it is dropped, deleting
  /// its pending movement so it is not counted twice. Confirmed movements
  /// are never changed.
  static List<OccurrenceRepair> reconcile({
    required List<RecurringTemplate> templates,
    required List<RecurringOccurrence> occurrences,
    required List<LocalDate> dynamicStarts,
    required int cutoffDay,
  }) {
    final calculators = {
      RecurringCadence.period: PeriodCalculator(
        type: PeriodType.dynamic,
        cutoffDay: cutoffDay,
        starts: dynamicStarts,
      ),
      RecurringCadence.monthly: PeriodCalculator(
        type: PeriodType.monthly,
        cutoffDay: cutoffDay,
      ),
    };
    final starts = dynamicStarts.toSet();
    final taken = {for (final o in occurrences) (o.templateId, o.periodStart)};
    final repairs = <OccurrenceRepair>[];
    for (final occurrence in occurrences) {
      final template = templates
          .where((t) => t.id == occurrence.templateId)
          .firstOrNull;
      if (template == null) continue;
      final period = calculators[template.cadence]!.periodOf(
        occurrence.periodStart,
      );
      if (period.start == occurrence.periodStart) continue;
      final pendingId = occurrence.isPending ? occurrence.movementId : null;
      final valid =
          (template.cadence == RecurringCadence.monthly ||
              starts.contains(period.start)) &&
          period.start.isAfter(template.createdOn) &&
          !taken.contains((template.id, period.start));
      if (valid) {
        taken.add((template.id, period.start));
        repairs.add(
          MoveOccurrence(
            occurrence.id,
            periodStart: period.start,
            movementId: pendingId,
            date: pendingId == null
                ? null
                : RecurringRules.dateIn(template, period),
          ),
        );
      } else {
        repairs.add(
          DropOccurrence(occurrence.id, pendingMovementId: pendingId),
        );
      }
    }
    return repairs;
  }
}
