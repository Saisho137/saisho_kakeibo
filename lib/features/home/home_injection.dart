import 'package:get_it/get_it.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';

/// Registers the Home. It reads the other features, so it goes last.
void registerHomeDependencies(GetIt getIt) {
  getIt.registerFactory(
    () => HomeCubit(
      watchSettings: getIt(),
      watchAccounts: getIt(),
      watchBalances: getIt(),
      watchCurrencies: getIt(),
      watchMovements: getIt(),
      watchPeriodStarts: getIt(),
      watchCategories: getIt(),
      watchPillars: getIt(),
      watchPayees: getIt(),
    ),
  );
}
