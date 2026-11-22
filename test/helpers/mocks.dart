import 'package:bloc_test/bloc_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/movement_form_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/transfer_form_cubit.dart';
import 'package:saisho_kakeibo/features/periods/presentation/cubit/period_starts_cubit.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_cubit.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currencies_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currency_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';

class MockGoRouter extends Mock implements GoRouter;

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit;

class MockCurrenciesCubit extends MockCubit<CurrenciesState>
    implements CurrenciesCubit;

class MockCurrencyFormCubit extends MockCubit<CurrencyFormState>
    implements CurrencyFormCubit;

class MockAccountsCubit extends MockCubit<AccountsState>
    implements AccountsCubit;

class MockAccountFormCubit extends MockCubit<AccountFormState>
    implements AccountFormCubit;

class MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit;

class MockCategoryFormCubit extends MockCubit<CategoryFormState>
    implements CategoryFormCubit;

class MockAccountDetailCubit extends MockCubit<AccountDetailState>
    implements AccountDetailCubit;

class MockCategoryGridCubit extends MockCubit<CategoryGridState>
    implements CategoryGridCubit;

class MockMovementFormCubit extends MockCubit<MovementFormState>
    implements MovementFormCubit;

class MockTransferFormCubit extends MockCubit<TransferFormState>
    implements TransferFormCubit;

class MockPeriodStartsCubit extends MockCubit<PeriodStartsState>
    implements PeriodStartsCubit;

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit;

class MockRecurringCubit extends MockCubit<RecurringState>
    implements RecurringCubit;

class MockRecurringFormCubit extends MockCubit<RecurringFormState>
    implements RecurringFormCubit;
