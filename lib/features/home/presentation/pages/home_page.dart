import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/theme/app_typography.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_chart.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_panel.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/home_actions.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/navigation_menu.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/period_totals_view.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/quick_menu.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_label.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_page_view.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Home: one period per page with its donut and totals, then the
/// Balance, which pulls the history up, and the entry buttons. ☰ opens
/// the quick menu and ⋮ the navigation.
class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..load(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final currency = state.currency;
        final balance = state.balance;
        return Scaffold(
          drawer: const QuickMenu(),
          endDrawer: const NavigationMenu(),
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                tooltip: l10n.homeQuickMenuTooltip,
                icon: const Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            titleSpacing: 0,
            title: _Title(filter: state.settings?.balanceFilter),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  tooltip: l10n.homeNavigationTooltip,
                  icon: const Icon(Icons.more_vert_rounded),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
          body: switch (state.status) {
            HomeStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            HomeStatus.success when currency != null && balance != null =>
              Column(
                children: [
                  Expanded(
                    child: HistoryPanel(
                      balance: balance,
                      currency: currency,
                      // A new period type or cutoff day starts over on today.
                      pageBuilder: (context, openHistory) => PeriodPageView(
                        key: ValueKey((
                          state.settings?.periodType,
                          state.settings?.cutoffDay,
                        )),
                        periods: state.periods,
                        initialIndex: state.currentIndex,
                        onPageChanged: context.read<HomeCubit>().periodSelected,
                        itemBuilder: (context, period) => _PeriodPage(
                          period: period,
                          state: state,
                          currency: currency,
                          openHistory: openHistory,
                        ),
                      ),
                    ),
                  ),
                  const HomeActions(),
                ],
              ),
            _ => Center(child: Text(l10n.genericError)),
          },
        );
      },
    );
  }
}

/// The app's name in its script and, under it, what the quick menu's
/// filter keeps (RF-17).
class _Title extends StatelessWidget {
  const new({required this.filter});

  /// `null` while the settings load.
  final BalanceFilter? filter;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ink = context.tokens.onBrand;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.appTitle,
          style: TextStyle(
            fontFamily: AppTypography.wordmarkFamily,
            fontSize: 24,
            height: 1.2,
            color: ink,
          ),
        ),
        if (filter case final kept?)
          Text(switch (kept) {
            BalanceFilter.both => l10n.homeFilterAll,
            BalanceFilter.cash => l10n.homeFilterCash,
            BalanceFilter.bank => l10n.homeFilterBank,
          }, style: context.textTheme.bodySmall?.copyWith(color: ink)),
      ],
    );
  }
}

class _PeriodPage extends StatelessWidget {
  const new({
    required this.period,
    required this.state,
    required this.currency,
    required this.openHistory,
  });

  final Period period;
  final HomeState state;
  final Currency currency;
  final OpenHistory openHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Text(
            periodLabel(context, period),
            style: context.textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: DonutChart(
              data: state.donutOf(period),
              center: PeriodTotalsView(
                totals: state.totalsOf(period),
                currency: currency,
                onTap: (type) => openHistory(categoryType: type),
              ),
              // A debt's section starts its payment ("Pay", RF-09).
              onCategoryTap: (section) => context.push(
                AppRoutes.newMovement(
                  MovementType.expense,
                  categoryId: section.category.id,
                  debtId: section.debt?.id,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
