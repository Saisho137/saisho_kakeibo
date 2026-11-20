import 'package:saisho_kakeibo/core/database/guard.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/periods/data/datasources/period_dao.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';

class PeriodRepositoryImpl implements PeriodRepository {
  const new(this._dao);

  final PeriodDao _dao;

  @override
  Stream<List<LocalDate>> watchStarts() => _dao.watchStarts();

  @override
  Future<Result<List<LocalDate>>> getStarts() => guardDatabase(_dao.getStarts);

  @override
  Future<Result<void>> addStart(LocalDate date) =>
      guardDatabase(() => _dao.addStart(date));

  @override
  Stream<List<LocalDate>> watchManualStarts() => _dao.watchManualStarts();

  @override
  Future<Result<void>> removeStart(LocalDate date) =>
      guardDatabase(() => _dao.removeStart(date));
}
