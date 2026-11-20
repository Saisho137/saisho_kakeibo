import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/category_grid_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// First step of the quick entry: pick a category, or search a payee
/// (RF-01, RF-08). Leaves once the movement is saved.
class CategoryGridPage extends StatelessWidget {
  const new({required this.type, super.key});

  final MovementType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CategoryGridCubit>();
        unawaited(cubit.load(type));
        return cubit;
      },
      child: const CategoryGridView(),
    );
  }
}

class CategoryGridView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<CategoryGridCubit, CategoryGridState>(
      builder: (context, state) {
        Future<void> open(String route) async {
          final saved = await context.push<bool>(route);
          if ((saved ?? false) && context.mounted) context.pop();
        }

        final categories = state.visibleCategories;
        final payees = state.visiblePayees;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.type == MovementType.income
                  ? l10n.entryIncomeTitle
                  : l10n.entryExpenseTitle,
            ),
          ),
          body: switch (state.status) {
            CategoryGridStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            CategoryGridStatus.failure => Center(
              child: Text(l10n.genericError),
            ),
            CategoryGridStatus.success => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  sliver: SliverToBoxAdapter(
                    child: TextField(
                      onChanged: context.read<CategoryGridCubit>().queryChanged,
                      decoration: InputDecoration(
                        hintText: l10n.entrySearchHint,
                        prefixIcon: const Icon(Icons.search_rounded),
                      ),
                    ),
                  ),
                ),
                if (payees.isNotEmpty) ...[
                  SliverToBoxAdapter(child: SectionHeader(l10n.entryEntities)),
                  SliverList.list(
                    children: [
                      for (final payee in payees)
                        ListTile(
                          leading: const Icon(Icons.storefront_outlined),
                          title: Text(payee.name),
                          onTap: () => open(
                            AppRoutes.newMovement(
                              state.type,
                              payeeId: payee.id,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                if (categories.isEmpty && payees.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        l10n.entryNoMatches,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  sliver: SliverGrid.count(
                    crossAxisCount: 4,
                    childAspectRatio: 0.8,
                    children: [
                      for (final category in categories)
                        _CategoryCell(
                          category: category,
                          onTap: () => open(
                            AppRoutes.newMovement(
                              state.type,
                              categoryId: category.id,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          },
        );
      },
    );
  }
}

class _CategoryCell extends StatelessWidget {
  const new({required this.category, required this.onTap});

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CatalogIconAvatar(
              iconKey: category.iconKey,
              color: Color(category.color),
              radius: 24,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              category.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
