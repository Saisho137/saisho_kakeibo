import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/features/periods/data/repositories/period_repository_impl.dart';
import 'package:saisho_kakeibo/features/periods/domain/repositories/period_repository.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/remove_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/start_period_now.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/suggest_period_start.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_manual_period_starts.dart';
import 'package:saisho_kakeibo/features/periods/domain/usecases/watch_period_starts.dart';
import 'package:saisho_kakeibo/features/periods/presentation/cubit/period_starts_cubit.dart';

/// Registers the feature's dependencies, from data source to cubit.
void registerPeriodsDependencies(GetIt getIt) {
  getIt
    ..registerLazySingleton<PeriodRepository>(
      () => PeriodRepositoryImpl(getIt<AppDatabase>().periodDao),
    )
    ..registerFactory(() => WatchPeriodStarts(getIt()))
    ..registerFactory(() => StartPeriodNow(getIt()))
    ..registerFactory(() => SuggestPeriodStart(getIt()))
    ..registerFactory(() => WatchManualPeriodStarts(getIt()))
    ..registerFactory(() => RemovePeriodStart(getIt()))
    ..registerFactory(
      () => PeriodStartsCubit(
        watchManualStarts: getIt(),
        startPeriodNow: getIt(),
        removeStart: getIt(),
      ),
    );
}
