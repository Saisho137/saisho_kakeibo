import 'package:flutter_archetype/app/router/app_routes.dart';
import 'package:flutter_archetype/features/tasks/presentation/pages/tasks_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter() => GoRouter(
  initialLocation: AppRoutes.tasks,
  routes: [
    GoRoute(
      path: AppRoutes.tasks,
      name: 'tasks',
      builder: (context, state) => const TasksPage(),
    ),
  ],
);
