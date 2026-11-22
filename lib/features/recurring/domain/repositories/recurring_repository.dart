import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_occurrence.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';

/// Contract implemented by the data layer.
abstract interface class RecurringRepository {
  Stream<List<RecurringTemplate>> watchTemplates();

  Future<Result<List<RecurringTemplate>>> getTemplates();

  Future<Result<RecurringTemplate?>> findTemplate(int id);

  /// Inserts or replaces [template]. With a [payee], it is found by key or
  /// created and set on the template. Returns its id.
  Future<Result<int>> saveTemplate(
    RecurringTemplate template, {
    PayeeName? payee,
  });

  /// Copies a confirmed movement's amounts to its template, so the next
  /// period starts from them (RF-06).
  Future<Result<void>> updateAmount(int id, int amount, int? toAmount);

  /// Deletes the template; its movements stay, without it.
  Future<Result<void>> deleteTemplate(int id);

  /// Every occurrence already created, with the state of its movement.
  Future<Result<List<RecurringOccurrence>>> getOccurrences();

  /// Applies [repairs] in one transaction.
  Future<Result<void>> repair(List<OccurrenceRepair> repairs);

  /// Creates each movement with its occurrence, in one transaction. An
  /// occurrence that already exists is skipped, so running twice creates
  /// nothing twice (RT-07). Returns how many movements were created.
  Future<Result<int>> materialize(List<PlannedOccurrence> planned);
}
