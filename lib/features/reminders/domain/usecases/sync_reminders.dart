import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt_statuses.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/reminders/domain/repositories/reminder_scheduler.dart';
import 'package:saisho_kakeibo/features/reminders/domain/services/reminder_planner.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/currency_repository.dart';
import 'package:saisho_kakeibo/features/settings/domain/repositories/settings_repository.dart';

/// Reschedules every reminder from [LocalDate] (today) on, or cancels them
/// all when notifications are off in Settings (RT-11). Returns how many it
/// scheduled.
class SyncReminders implements UseCase<Future<Result<int>>, LocalDate> {
  const new({
    required this._settings,
    required this._recurring,
    required this._accounts,
    required this._categories,
    required this._movements,
    required this._currencies,
    required this._scheduler,
    required this._debts,
  });

  final SettingsRepository _settings;
  final RecurringRepository _recurring;
  final AccountRepository _accounts;
  final CategoryRepository _categories;
  final MovementRepository _movements;
  final CurrencyRepository _currencies;
  final ReminderScheduler _scheduler;
  final GetDebtStatuses _debts;

  @override
  Future<Result<int>> call(LocalDate today) async {
    switch ((
      await _settings.getSettings(),
      await _recurring.getTemplates(),
      await _accounts.getAccounts(),
      await _categories.getCategories(),
      await _movements.getPayees(),
      await _currencies.getCurrencies(),
      await _debts(const NoParams()),
    )) {
      case (
        Ok(value: final settings),
        Ok(value: final templates),
        Ok(value: final accounts),
        Ok(value: final categories),
        Ok(value: final payees),
        Ok(value: final currencies),
        Ok(value: final debts),
      ):
        try {
          if (!settings.notificationsEnabled) {
            await _scheduler.cancelAll();
            return const Ok(0);
          }
          final reminders = ReminderPlanner.plan(
            templates: templates,
            accounts: accounts,
            categories: categories,
            payees: payees,
            currencies: currencies,
            today: today,
            debts: debts,
          );
          await _scheduler.replaceAll(
            reminders,
            minutes: settings.reminderMinutes,
          );
          return Ok(reminders.length);
        } on Exception catch (e) {
          return Err(UnexpectedFailure(e.toString()));
        }
      case (Err(:final failure), _, _, _, _, _, _) ||
          (_, Err(:final failure), _, _, _, _, _) ||
          (_, _, Err(:final failure), _, _, _, _) ||
          (_, _, _, Err(:final failure), _, _, _) ||
          (_, _, _, _, Err(:final failure), _, _) ||
          (_, _, _, _, _, Err(:final failure), _) ||
          (_, _, _, _, _, _, Err(:final failure)):
        return Err(failure);
    }
  }
}
