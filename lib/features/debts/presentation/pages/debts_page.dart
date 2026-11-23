import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debts_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Debts screen (RF-09): what I owe and what I am owed, apart from the
/// balances, with the credit cards read only.
class DebtsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DebtsCubit>()..load(),
      child: const DebtsView(),
    );
  }
}

class DebtsView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTabController(
      length: DebtType.values.length,
      child: BlocBuilder<DebtsCubit, DebtsState>(
        builder: (context, state) {
          final currency = state.currency;
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.debtsTitle),
              actions: [
                if (state.currencyOptions.length > 1 &&
                    state.currencyCode != null)
                  PopupMenuButton<String>(
                    initialValue: state.currencyCode,
                    onSelected: context.read<DebtsCubit>().currencySelected,
                    itemBuilder: (context) => [
                      for (final c in state.currencyOptions)
                        PopupMenuItem(value: c.code, child: Text(c.code)),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                      ),
                      child: Row(
                        children: [
                          Text(state.currencyCode!),
                          const Icon(Icons.arrow_drop_down_rounded),
                        ],
                      ),
                    ),
                  ),
                Builder(
                  builder: (context) => IconButton(
                    tooltip: l10n.debtsNewTooltip,
                    icon: const Icon(Icons.add_rounded),
                    onPressed: () => context.push(
                      AppRoutes.newDebt(
                        DebtType.values[DefaultTabController.of(context).index],
                      ),
                    ),
                  ),
                ),
              ],
              bottom: TabBar(
                tabs: [
                  Tab(text: l10n.debtsIOwe),
                  Tab(text: l10n.debtsOwedToMe),
                ],
              ),
            ),
            body: switch (state.status) {
              DebtsStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              DebtsStatus.success when currency != null => TabBarView(
                children: [
                  for (final type in DebtType.values)
                    _DebtsTab(type: type, state: state, currency: currency),
                ],
              ),
              _ => Center(child: Text(l10n.genericError)),
            },
          );
        },
      ),
    );
  }
}

class _DebtsTab extends StatelessWidget {
  const new({required this.type, required this.state, required this.currency});

  final DebtType type;
  final DebtsState state;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    String money(int amount) =>
        MoneyFormatter.format(Money(amount, currency.code), currency.format);
    final active = state.active(type);
    final paidOff = state.paidOff(type);
    final cards = type == DebtType.iOwe
        ? state.cards
        : const <(Account, int)>[];
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        ListTile(
          title: Text(l10n.debtsTotalPending),
          trailing: Text(
            money(state.totalPending(type)),
            style: context.textTheme.titleMedium,
          ),
        ),
        const Divider(),
        if (active.isEmpty && cards.isEmpty && paidOff.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              type == DebtType.iOwe
                  ? l10n.debtsEmptyIOwe
                  : l10n.debtsEmptyOwedToMe,
              textAlign: TextAlign.center,
            ),
          ),
        for (final line in active)
          _DebtTile(key: ValueKey(line.debt.id), line: line, state: state),
        if (cards.isNotEmpty) ...[
          SectionHeader(l10n.debtsCreditCards),
          for (final (card, balance) in cards)
            ListTile(
              key: ValueKey(('card', card.id)),
              leading: CatalogIconAvatar(
                iconKey: card.iconKey,
                color: Color(card.color),
              ),
              title: Text(card.name),
              subtitle: card.paymentDay == null
                  ? null
                  : Text(l10n.debtsDueDay(card.paymentDay!)),
              trailing: Text(money(balance)),
              onTap: () => context.push(AppRoutes.accountDetail(card.id)),
            ),
        ],
        if (paidOff.isNotEmpty)
          ExpansionTile(
            title: Text(l10n.debtsPaidOff(paidOff.length)),
            children: [
              for (final line in paidOff)
                _DebtTile(
                  key: ValueKey(line.debt.id),
                  line: line,
                  state: state,
                ),
            ],
          ),
      ],
    );
  }
}

class _DebtTile extends StatelessWidget {
  const new({required this.line, required this.state, super.key});

  final DebtLine line;
  final DebtsState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (:debt, :status) = line;
    final currency = state.currency!;
    final left = MoneyFormatter.format(
      Money(status.pending, currency.code),
      currency.format,
    );
    final dueDay = debt.dueDay;
    final dueDate = debt.dueDate;
    final details = [
      ?state.pillarOf(debt)?.name,
      if (dueDay != null) l10n.debtsDueDay(dueDay),
      if (dueDate != null)
        l10n.debtsDueDate(
          DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag())
              .format(dueDate.toDateTime()),
        ),
    ];
    return ListTile(
      onTap: () => context.push(AppRoutes.debtDetail(debt.id)),
      leading: CatalogIconAvatar(
        iconKey: debt.iconKey,
        color: Color(debt.color),
      ),
      title: Text(
        // A debt named after its payee shows the name once.
        switch (state.payeeOf(debt)?.name) {
          final payee? when payee != debt.name => '${debt.name} · $payee',
          _ => debt.name,
        },
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                status.isPaidOff ? l10n.debtPaidOffLabel : l10n.debtsLeft(left),
                style: status.pending < 0
                    ? TextStyle(color: context.tokens.expense)
                    : null,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: LinearProgressIndicator(value: status.progress)),
              const SizedBox(width: AppSpacing.sm),
              Text('${(status.progress * 100).round()}%'),
            ],
          ),
          if (details.isNotEmpty) Text(details.join(' · ')),
        ],
      ),
    );
  }
}
