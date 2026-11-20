import 'package:bloc_test/bloc_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_detail_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';
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
