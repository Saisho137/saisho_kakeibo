import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/delete_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/get_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/materialize_recurring.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/save_recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/set_recurring_template_active.dart';
import 'package:saisho_kakeibo/features/recurring/domain/usecases/watch_recurring_templates.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_cubit.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_form_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerRecurringDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<RecurringRepository>(
      () => RecurringRepositoryImpl(getIt<AppDatabase>().recurringDao),
    )
    ..registerFactory(() => WatchRecurringTemplates(getIt()))
    ..registerFactory(() => GetRecurringTemplate(getIt()))
    ..registerFactory(() => DeleteRecurringTemplate(getIt()))
    ..registerFactory(() => SetRecurringTemplateActive(getIt()))
    ..registerFactory(
      () => SaveRecurringTemplate(
        recurring: getIt(),
        accounts: getIt(),
        categories: getIt(),
        debts: getIt(),
      ),
    )
    ..registerFactory(
      () => MaterializeRecurring(
        recurring: getIt(),
        periods: getIt(),
        settings: getIt(),
        accounts: getIt(),
        debts: getIt(),
      ),
    )
    ..registerFactory(
      () => RecurringCubit(
        watchTemplates: getIt(),
        watchAccounts: getIt(),
        watchCategories: getIt(),
        watchPayees: getIt(),
        watchCurrencies: getIt(),
        setActive: getIt(),
      ),
    )
    ..registerFactory(
      () => RecurringFormCubit(
        getAccounts: getIt(),
        getCategories: getIt(),
        getCurrencies: getIt(),
        getPayees: getIt(),
        getMovement: getIt(),
        getTemplate: getIt(),
        saveTemplate: getIt(),
        deleteTemplate: getIt(),
        getDebts: getIt(),
      ),
    );
}
