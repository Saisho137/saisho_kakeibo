import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

/// Creates the pending movements the templates owe on [LocalDate] (today):
/// run when the app opens and whenever a period starts. It is idempotent
/// (RT-07). Returns how many movements it created.
class MaterializeRecurring implements UseCase<Future<Result<int>>, LocalDate> {
  const new({
    required this._recurring,
    required this._periods,
    required this._settings,
    required this._accounts,
  });

  final RecurringRepository _recurring;
  final PeriodRepository _periods;
  final SettingsRepository _settings;
  final AccountRepository _accounts;

  @override
  Future<Result<int>> call(LocalDate today) async {
    switch ((
      await _recurring.getTemplates(),
      await _recurring.getOccurrences(),
      await _periods.getStarts(),
      await _settings.getSettings(),
      await _accounts.getAccounts(),
    )) {
      case (
        Ok(value: final templates),
        Ok(value: final occurrences),
        Ok(value: final starts),
        Ok(value: final settings),
        Ok(value: final accounts),
      ):
        final planned = RecurringPlanner.plan(
          templates: templates,
          accounts: accounts,
          today: today,
          dynamicStarts: starts,
          cutoffDay: settings.cutoffDay,
          occurrences: occurrences,
        );
        if (planned.isEmpty) return const Ok(0);
        return await _recurring.materialize(planned);
      case (Err(:final failure), _, _, _, _) ||
          (_, Err(:final failure), _, _, _) ||
          (_, _, Err(:final failure), _, _) ||
          (_, _, _, Err(:final failure), _) ||
          (_, _, _, _, Err(:final failure)):
        return Err(failure);
    }
  }
}
