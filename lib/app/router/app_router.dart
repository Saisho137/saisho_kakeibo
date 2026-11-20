import 'package:go_router/go_router.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
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
