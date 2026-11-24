import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/currency_menu_button.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payees_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/widgets/payee_net_text.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Entities screen (RF-08): what each entity adds up to, in the current
/// period or ever. Entities are created in the movement form, so there is
/// nothing to add here.
class PayeesPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PayeesCubit>()..load(),
      child: const PayeesView(),
    );
  }
}

class PayeesView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<PayeesCubit, PayeesState>(
      builder: (context, state) {
        final cubit = context.read<PayeesCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.payeesTitle),
            actions: [
              PopupMenuButton<PayeeSort>(
                tooltip: l10n.payeesSortTooltip,
                icon: const Icon(Icons.sort_rounded),
                initialValue: state.sort,
                onSelected: cubit.sortChanged,
                itemBuilder: (context) => [
                  for (final (sort, label) in [
                    (PayeeSort.spent, l10n.payeesSortSpent),
                    (PayeeSort.used, l10n.payeesSortUsed),
                    (PayeeSort.name, l10n.payeesSortName),
                  ])
                    PopupMenuItem(value: sort, child: Text(label)),
                ],
              ),
              if (state.currencyOptions.length > 1 &&
                  state.currencyCode != null)
                CurrencyMenuButton(
                  selected: state.currencyCode!,
                  currencies: state.currencyOptions,
                  onSelected: cubit.currencySelected,
                ),
            ],
          ),
          body: switch (state.status) {
            PayeesStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            PayeesStatus.success when state.currency != null => _List(
              state: state,
            ),
            _ => Center(child: Text(l10n.genericError)),
          },
        );
      },
    );
  }
}

class _List extends StatelessWidget {
  const new({required this.state});

  final PayeesState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<PayeesCubit>();
    final lines = state.lines;
    final currency = state.currency!;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            0,
          ),
          child: TextField(
            onChanged: cubit.queryChanged,
            decoration: InputDecoration(
              hintText: l10n.payeesSearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SegmentedButton<PayeeScope>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: PayeeScope.period,
                label: Text(l10n.payeesThisPeriod),
              ),
              ButtonSegment(
                value: PayeeScope.allTime,
                label: Text(l10n.payeesAllTime),
              ),
            ],
            selected: {state.scope},
            onSelectionChanged: (values) => cubit.scopeChanged(values.single),
          ),
        ),
        if (lines.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              state.query.trim().isNotEmpty
                  ? l10n.entryNoMatches
                  : state.scope == PayeeScope.period
                  ? l10n.payeesEmptyPeriod
                  : l10n.payeesEmpty,
              textAlign: TextAlign.center,
            ),
          ),
        for (final (:payee, :stats) in lines)
          ListTile(
            key: ValueKey(payee.id),
            leading: switch (state.categoryOf(stats.lastCategoryId)) {
              final category? => CatalogIconAvatar(
                iconKey: category.iconKey,
                color: Color(category.color),
              ),
              null => SizedBox.square(
                dimension: 40,
                child: Icon(
                  Icons.storefront_outlined,
                  size: 30,
                  color: context.tokens.transfer,
                ),
              ),
            },
            title: Text(payee.name, overflow: TextOverflow.ellipsis),
            subtitle: Text(l10n.payeesCount(stats.count)),
            trailing: PayeeNetText(stats: stats, currency: currency),
            onTap: () => context.push(AppRoutes.payeeDetail(payee.id)),
          ),
      ],
    );
  }
}
