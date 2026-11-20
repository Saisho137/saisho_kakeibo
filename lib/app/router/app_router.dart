import 'package:go_router/go_router.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';

GoRouter createAppRouter() => GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
