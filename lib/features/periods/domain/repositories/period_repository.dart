import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

/// Contract implemented by the data layer.
abstract interface class PeriodRepository {
  /// Dates that start a dynamic period, oldest first and without repeats:
  /// salaries with "Starts period" and manual starts (RT-06).
  Stream<List<LocalDate>> watchStarts();

  Future<Result<List<LocalDate>>> getStarts();

  /// Manual period starts, newest first.
  Stream<List<LocalDate>> watchManualStarts();

  /// Saves a manual period start on [date].
  Future<Result<void>> addStart(LocalDate date);

  /// Deletes the manual period start on [date], to undo it.
  Future<Result<void>> removeStart(LocalDate date);
}
