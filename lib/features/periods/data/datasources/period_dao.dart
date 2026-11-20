import 'package:drift/drift.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/periods/data/datasources/period_starts_table.dart';

part 'period_dao.g.dart';

@DriftAccessor(tables: [PeriodStarts, Movements])
class PeriodDao extends DatabaseAccessor<AppDatabase> with _$PeriodDaoMixin {
  new(super.attachedDatabase);

  /// Dates of salaries that start a period and of manual starts, oldest
  /// first; `UNION` drops repeats.
  Selectable<LocalDate> _starts() => customSelect(
    '''
    SELECT date FROM movements WHERE starts_period = 1
    UNION SELECT date FROM period_starts
    ORDER BY date
    ''',
    readsFrom: {movements, periodStarts},
  ).map((row) => LocalDate.parse(row.read<String>('date')));

  Stream<List<LocalDate>> watchStarts() => _starts().watch();

  Future<List<LocalDate>> getStarts() => _starts().get();

  Stream<List<LocalDate>> watchManualStarts() =>
      (select(periodStarts)..orderBy([(p) => OrderingTerm.desc(p.date)]))
          .map((row) => row.date)
          .watch();

  Future<int> addStart(LocalDate date) =>
      into(periodStarts).insert(PeriodStartsCompanion.insert(date: date));

  Future<int> removeStart(LocalDate date) =>
      (delete(periodStarts)..where((p) => p.date.equalsValue(date))).go();
}
