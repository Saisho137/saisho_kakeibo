import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/home_balance_bar.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/navigation_menu.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/period_totals_view.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/quick_menu.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_label.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_page_view.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Home: one period per page with its totals, then the Balance and
/// the entry buttons. ☰ opens the quick menu and ⋮ the navigation.
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
                    // A new period type or cutoff day starts over on today.
                    child: PeriodPageView(
                      key: ValueKey((
                        state.settings?.periodType,
                        state.settings?.cutoffDay,
                      )),
                      periods: state.periods,
                      initialIndex: state.currentIndex,
                      itemBuilder: (context, period) => _PeriodPage(
                        period: period,
                        state: state,
                        currency: currency,
                      ),
                    ),
                  ),
                  HomeBalanceBar(balance: balance, currency: currency),
                ],
              ),
            _ => Center(child: Text(l10n.genericError)),
          },
        );
      },
    );
  }
}

class _PeriodPage extends StatelessWidget {
  const new({
    required this.period,
    required this.state,
    required this.currency,
  });

  final Period period;
  final HomeState state;
  final Currency currency;

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
          child: Center(
            child: PeriodTotalsView(
              totals: state.totalsOf(period),
              currency: currency,
            ),
          ),
        ),
      ],
    );
  }
}
