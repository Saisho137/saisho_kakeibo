import 'package:go_router/go_router.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/account_form_page.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/pages/accounts_page.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';
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
          name: 'editAccount',
          builder: (context, state) => AccountFormPage(
            id: int.tryParse(state.pathParameters['id']!) ?? -1,
          ),
        ),
      ],
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
