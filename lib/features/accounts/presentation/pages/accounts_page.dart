import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/currency_menu_button.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/domain/services/accounts_overview.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/account_line_card.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/account_names.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Accounts screen. It starts in the main currency.
class AccountsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountsCubit>()
        ..load(context.read<SettingsCubit>().state.settings.mainCurrencyCode),
      child: const AccountsView(),
    );
  }
}

class AccountsView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AccountsCubit, AccountsState>(
      listenWhen: (previous, current) =>
          current.failure != null && previous.failure != current.failure,
      listener: (context, state) => ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
      child: BlocBuilder<AccountsCubit, AccountsState>(
        builder: (context, state) {
          final overview = state.overview;
          final currency = state.currency;
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.accountsTitle),
              actions: [
                if (currency != null)
                  _CurrencyMenu(
                    selected: currency,
                    currencies: state.currencies,
                  ),
                IconButton(
                  tooltip: l10n.accountNewTooltip,
                  icon: const Icon(Icons.add_rounded),
                  onPressed: () => context.push(AppRoutes.newAccount),
                ),
                PopupMenuButton<void>(
                  itemBuilder: (context) => [
                    CheckedPopupMenuItem(
                      checked: state.showArchived,
                      onTap: context.read<AccountsCubit>().showArchivedToggled,
                      child: Text(l10n.accountsShowArchived),
                    ),
                  ],
                ),
              ],
            ),
            body: switch (state.status) {
              AccountsStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              AccountsStatus.failure => Center(child: Text(l10n.genericError)),
              AccountsStatus.success
                  when overview != null && currency != null =>
                _AccountsList(overview: overview, currency: currency),
              AccountsStatus.success => Center(child: Text(l10n.genericError)),
            },
          );
        },
      ),
    );
  }
}

class _CurrencyMenu extends StatelessWidget {
  const new({required this.selected, required this.currencies});

  final Currency selected;
  final List<Currency> currencies;

  @override
  Widget build(BuildContext context) => CurrencyMenuButton(
    selected: selected.code,
    currencies: currencies,
    onSelected: context.read<AccountsCubit>().currencySelected,
  );
}

class _AccountsList extends StatelessWidget {
  const new({required this.overview, required this.currency});

  final AccountsOverview overview;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<AccountsCubit>();
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        _TotalRow(l10n.accountsTotalBalance, overview.totalBalance, currency),
        _TotalRow(l10n.accountsBalance, overview.balance, currency),
        const Divider(),
        if (overview.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              l10n.accountsEmpty(currency.code),
              textAlign: TextAlign.center,
            ),
          ),
        for (final MapEntry(key: group, value: lines)
            in overview.groups.entries) ...[
          SectionHeader(group.label(context)),
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorderItem: (from, to) => cubit.reorder(group, from, to),
            children: [
              for (final line in lines)
                AccountLineCard(
                  key: ValueKey(line.account.id),
                  line: line,
                  format: currency.format,
                  onTap: (account) =>
                      context.push(AppRoutes.accountDetail(account.id)),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const new(this.label, this.amount, this.currency);

  final String label;
  final Money amount;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: Text(
        MoneyFormatter.format(amount, currency.format),
        style: context.textTheme.titleMedium,
      ),
    );
  }
}
