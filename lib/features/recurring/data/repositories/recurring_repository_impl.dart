import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/data/models/movement_row_mapper.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_dao.dart';
import 'package:saisho_kakeibo/features/recurring/data/models/recurring_template_row_mapper.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';

class RecurringRepositoryImpl implements RecurringRepository {
  const new(this._dao);

  final RecurringDao _dao;

  @override
  Stream<List<RecurringTemplate>> watchTemplates() => _dao.watchTemplates().map(
    (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
  );

  @override
  Future<Result<List<RecurringTemplate>>> getTemplates() => guardDatabase(
    () async =>
        (await _dao.getTemplates()).map((row) => row.toEntity()).toList(),
  );

  @override
  Future<Result<RecurringTemplate?>> findTemplate(int id) =>
      guardDatabase(() async => (await _dao.findTemplate(id))?.toEntity());

  @override
  Future<Result<int>> saveTemplate(
    RecurringTemplate template, {
    PayeeName? payee,
  }) => guardDatabase(
    () => _dao.saveTemplate(
      template.toCompanion(),
      payeeName: payee?.name,
      payeeKey: payee?.key,
    ),
  );

  @override
  Future<Result<void>> updateAmount(int id, int amount, int? toAmount) =>
      guardDatabase(() => _dao.updateAmount(id, amount, toAmount));

  @override
  Future<Result<void>> deleteTemplate(int id) =>
      guardDatabase(() => _dao.deleteTemplate(id));

  @override
  Future<Result<Set<(int, LocalDate)>>> getOccurrences() => guardDatabase(
    () async => {
      for (final row in await _dao.getOccurrences())
        (row.templateId, row.periodStart),
    },
  );

  @override
  Future<Result<int>> materialize(List<PlannedOccurrence> planned) =>
      guardDatabase(
        () => _dao.materialize([
          for (final p in planned)
            (p.templateId, p.periodStart, p.movement.toCompanion()),
        ]),
      );
}
