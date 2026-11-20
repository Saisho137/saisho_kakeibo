import 'package:go_router/go_router.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/account_detail_page.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/account_form_page.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/accounts_page.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/presentation/pages/categories_page.dart';
import 'package:saisho_kakeibo/features/categories/presentation/pages/category_form_page.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/category_grid_page.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/movement_form_page.dart';
import 'package:saisho_kakeibo/features/movements/presentation/pages/transfer_form_page.dart';
import 'package:saisho_kakeibo/features/settings/presentation/pages/currency_form_page.dart';
import 'package:saisho_kakeibo/features/settings/presentation/pages/settings_page.dart';

GoRouter createAppRouter() => GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.accounts,
      name: 'accounts',
      builder: (context, state) => const AccountsPage(),
      routes: [
        GoRoute(
          path: 'new',
          name: 'newAccount',
          builder: (context, state) => const AccountFormPage(),
        ),
        GoRoute(
          path: ':id',
          name: 'accountDetail',
          builder: (context, state) => AccountDetailPage(
            id: int.tryParse(state.pathParameters['id']!) ?? -1,
          ),
          routes: [
            GoRoute(
              path: 'edit',
              name: 'editAccount',
              builder: (context, state) => AccountFormPage(
                id: int.tryParse(state.pathParameters['id']!) ?? -1,
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.categories,
      name: 'categories',
      builder: (context, state) => const CategoriesPage(),
      routes: [
        GoRoute(
          path: 'new',
          name: 'newCategory',
          builder: (context, state) => CategoryFormPage(
            type:
                CategoryType.values
                    .asNameMap()[state.uri.queryParameters['type']] ??
                CategoryType.expense,
          ),
        ),
        GoRoute(
          path: ':id',
          name: 'editCategory',
          builder: (context, state) => CategoryFormPage(
            id: int.tryParse(state.pathParameters['id']!) ?? -1,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/entry/:type',
      name: 'entry',
      builder: (context, state) =>
          CategoryGridPage(type: _movementType(state.pathParameters['type'])),
    ),
    GoRoute(
      path: '/movements/new',
      name: 'newMovement',
      builder: (context, state) {
        final query = state.uri.queryParameters;
        return MovementFormPage(
          type: _movementType(query['type']),
          categoryId: int.tryParse(query['category'] ?? ''),
          payeeId: int.tryParse(query['payee'] ?? ''),
        );
      },
    ),
    GoRoute(
      path: '/movements/:id',
      name: 'editMovement',
      builder: (context, state) =>
          MovementFormPage(id: int.tryParse(state.pathParameters['id']!) ?? -1),
    ),
    GoRoute(
      path: '/transfers/new',
      name: 'newTransfer',
      builder: (context, state) => TransferFormPage(
        fromAccountId: int.tryParse(state.uri.queryParameters['from'] ?? ''),
      ),
    ),
    GoRoute(
      path: '/transfers/:id',
      name: 'editTransfer',
      builder: (context, state) =>
          TransferFormPage(id: int.tryParse(state.pathParameters['id']!) ?? -1),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'currencies/new',
          name: 'newCurrency',
          builder: (context, state) => const CurrencyFormPage(),
        ),
        GoRoute(
          path: 'currencies/:code',
          name: 'editCurrency',
          builder: (context, state) =>
              CurrencyFormPage(code: state.pathParameters['code']),
        ),
      ],
    ),
  ],
);

/// Income or expense from a route; anything else is an expense.
MovementType _movementType(String? name) => name == MovementType.income.name
    ? MovementType.income
    : MovementType.expense;
