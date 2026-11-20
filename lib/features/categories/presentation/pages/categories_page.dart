import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/widgets/category_names.dart';
import 'package:saisho_kakeibo/features/categories/presentation/widgets/category_tile.dart';
import 'package:saisho_kakeibo/features/categories/presentation/widgets/pillars_dialog.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Categories screen: one tab per type, in the order of the quick entry
/// grid (RF-13).
class CategoriesPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoriesCubit>()..load(),
      child: const CategoriesView(),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: categoryTabs.length,
      child: BlocListener<CategoriesCubit, CategoriesState>(
        listenWhen: (previous, current) =>
            current.failure != null && previous.failure != current.failure,
        listener: (context, state) => ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(l10n.categoriesTitle),
              actions: [
                IconButton(
                  tooltip: l10n.pillarsTooltip,
                  icon: const Icon(Icons.donut_large_rounded),
                  onPressed: state.status == CategoriesStatus.success
                      ? () => showPillarsDialog(context)
                      : null,
                ),
                Builder(
                  builder: (context) => IconButton(
                    tooltip: l10n.categoryNewTooltip,
                    icon: const Icon(Icons.add_rounded),
                    onPressed: () => context.push(
                      AppRoutes.newCategory(
                        categoryTabs[DefaultTabController.of(context).index],
                      ),
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                tabs: [
                  for (final type in categoryTabs)
                    Tab(text: type.label(context)),
                ],
              ),
            ),
            body: switch (state.status) {
              CategoriesStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              CategoriesStatus.failure => Center(
                child: Text(l10n.genericError),
              ),
              CategoriesStatus.success => TabBarView(
                children: [
                  for (final type in categoryTabs)
                    _CategoryList(type: type, state: state),
                ],
              ),
            },
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const new({required this.type, required this.state});

  final CategoryType type;
  final CategoriesState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final active = state.active(type);
    final archived = state.archived(type);
    CategoryTile tile(Category category) => CategoryTile(
      key: ValueKey(category.id),
      category: category,
      pillar: state.pillarOf(category),
      onTap: () => context.push(AppRoutes.editCategory(category.id)),
    );
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        if (active.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(l10n.categoriesEmpty, textAlign: TextAlign.center),
          ),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorderItem: (from, to) =>
              context.read<CategoriesCubit>().reorder(type, from, to),
          children: [for (final category in active) tile(category)],
        ),
        if (archived.isNotEmpty)
          ExpansionTile(
            title: Text(l10n.categoriesArchived(archived.length)),
            children: [for (final category in archived) tile(category)],
          ),
      ],
    );
  }
}
