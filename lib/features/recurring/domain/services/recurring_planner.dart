import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_calculator.dart';
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
/// already had its occurrence (even if that movement was later cancelled)
/// or while one of its accounts is archived. The amount is the last
/// confirmed one.
abstract final class RecurringPlanner {
  static List<PlannedOccurrence> plan({
    required List<RecurringTemplate> templates,
    required List<Account> accounts,
    required LocalDate today,
    required List<LocalDate> dynamicStarts,
    required int cutoffDay,
    required Set<(int, LocalDate)> occurrences,
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
            usable(template.toAccountId))
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
}
