import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/money/percentages.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/movement_tile.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/balance_pill.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_label.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Opens the history of the period on screen from the bottom, by day or,
/// with [categoryType], by category of that type.
Future<void> showHistorySheet(
  BuildContext context, {
  MovementType? categoryType,
}) {
  final cubit = context.read<HomeCubit>();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 1,
        builder: (context, controller) =>
            HistoryView(controller: controller, categoryType: categoryType),
      ),
    ),
  );
}

/// The period's movements by day, newest first, or its categories of one
/// type by amount (RF-14). Pending movements are dimmed.
class HistoryView extends StatefulWidget {
  const new({this.controller, this.categoryType, super.key});

  final ScrollController? controller;

  /// Opens the view by category of this type; the view by day otherwise.
  final MovementType? categoryType;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late bool _byCategory = widget.categoryType != null;
  late MovementType _type = widget.categoryType ?? MovementType.expense;

  /// Days folded in the view by day.
  final Set<LocalDate> _collapsed = {};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<HomeCubit>().state;
    final period = state.visiblePeriod;
    final currency = state.currency;
    if (period == null || currency == null) return const SizedBox.shrink();
    final balance = state.balance;
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Text(
            periodLabel(context, period),
            textAlign: TextAlign.center,
            style: context.textTheme.labelLarge?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              const Expanded(child: BalanceGrip()),
              if (balance != null)
                Flexible(
                  flex: 4,
                  child: BalancePill(
                    balance: balance,
                    currency: currency,
                    tooltip: l10n.historyCloseTooltip,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
              Expanded(
                // By day or by category, only here (RF-14).
                child: IconButton(
                  tooltip: _byCategory
                      ? l10n.historyByDay
                      : l10n.historyByCategory,
                  icon: Icon(
                    _byCategory
                        ? Icons.calendar_month_outlined
                        : Icons.donut_small_outlined,
                    color: context.colors.primary,
                  ),
                  onPressed: () => setState(() => _byCategory = !_byCategory),
                ),
              ),
            ],
          ),
        ),
        if (_byCategory) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: SegmentedButton<MovementType>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: MovementType.expense,
                  label: Text(l10n.homeExpenses),
                ),
                ButtonSegment(
                  value: MovementType.income,
                  label: Text(l10n.homeIncome),
                ),
                ButtonSegment(
                  value: MovementType.transfer,
                  label: Text(l10n.homeTransfers),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (values) =>
                  setState(() => _type = values.single),
            ),
          ),
          ..._categories(context, state, period, currency),
        ] else
          ..._days(context, state, period, currency),
      ],
    );
  }

  List<Widget> _days(
    BuildContext context,
    HomeState state,
    Period period,
    Currency currency,
  ) {
    final days = state.daysOf(period);
    if (days.isEmpty) return [_empty(context)];
    return [
      for (final (day, entries) in days) ...[
        _DayHeader(
          key: ValueKey(day),
          day: day,
          count: entries.length,
          net: state.netOf(entries.map((e) => e.movement)),
          currency: currency,
          collapsed: _collapsed.contains(day),
          onTap: () => setState(
            () => _collapsed.contains(day)
                ? _collapsed.remove(day)
                : _collapsed.add(day),
          ),
        ),
        if (!_collapsed.contains(day))
          for (final entry in entries)
            _tile(context, state, entry, currency, dot: true),
      ],
    ];
  }

  List<Widget> _categories(
    BuildContext context,
    HomeState state,
    Period period,
    Currency currency,
  ) {
    final rows = state.categoriesOf(period, _type);
    if (rows.isEmpty) return [_empty(context)];
    final typeName = switch (_type) {
      MovementType.income => context.l10n.homeIncome,
      MovementType.transfer => context.l10n.homeTransfers,
      _ => context.l10n.homeExpenses,
    };
    final history = state.historyOf(period);
    final percents = roundPercents([for (final row in rows) row.share]);
    return [
      for (final (index, (:category, :amount, share: _)) in rows.indexed)
        ExpansionTile(
          key: ValueKey(category.id),
          leading: CatalogIconAvatar(
            iconKey: category.iconKey,
            color: Color(category.color),
          ),
          title: Text(category.name, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            context.l10n.historyCategoryShare('${percents[index]}%', typeName),
          ),
          trailing: Text(
            MoneyFormatter.format(
              Money(amount, currency.code),
              currency.format,
            ),
            style: context.textTheme.titleSmall,
          ),
          children: [
            for (final entry in history)
              if (entry.movement.categoryId == category.id &&
                  entry.movement.type == _type)
                _tile(context, state, entry, currency),
          ],
        ),
    ];
  }

  Widget _empty(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpacing.lg),
    child: Text(context.l10n.historyEmpty, textAlign: TextAlign.center),
  );

  Widget _tile(
    BuildContext context,
    HomeState state,
    ({Movement movement, int accountId}) entry,
    Currency currency, {
    bool dot = false,
  }) {
    final (:movement, :accountId) = entry;
    final accounts = state.accounts ?? const [];
    return MovementTile(
      key: ValueKey(movement.id),
      movement: movement,
      accountId: accountId,
      currency: currency,
      dot: dot,
      category: state.categories?.byId(movement.categoryId),
      payee: state.payeeOf(movement),
      otherAccount: accounts.byId(
        movement.accountId == accountId
            ? movement.toAccountId
            : movement.accountId,
      ),
      onTap: () => unawaited(
        context.push(switch (movement.type) {
          MovementType.income ||
          MovementType.expense => AppRoutes.editMovement(movement.id),
          MovementType.transfer => AppRoutes.editTransfer(movement.id),
          MovementType.adjustment => AppRoutes.accountDetail(accountId),
        }),
      ),
    );
  }
}

/// A day of the history: its full date, how many movements it has and
/// what it adds up to, green when positive and red when negative. Tapping
/// it folds or unfolds its movements.
class _DayHeader extends StatelessWidget {
  const new({
    required this.day,
    required this.count,
    required this.net,
    required this.currency,
    required this.collapsed,
    required this.onTap,
    super.key,
  });

  final LocalDate day;
  final int count;
  final int net;
  final Currency currency;
  final bool collapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    final textTheme = context.textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date =
        (day.year == LocalDate.today().year
                ? DateFormat.MMMMd(locale)
                : DateFormat.yMMMMd(locale))
            .format(day.toDateTime());
    final amount = MoneyFormatter.format(
      Money(net, currency.code),
      currency.format,
    );
    return Semantics(
      button: true,
      expanded: !collapsed,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: kMinInteractiveDimension,
          ),
          child: Padding(
            // Its balance lines up with the amounts of the rows below.
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(
                  collapsed
                      ? Icons.expand_more_rounded
                      : Icons.expand_less_rounded,
                  color: context.colors.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          date,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Semantics(
                        label: l10n.historyDayMovements(count),
                        excludeSemantics: true,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: tokens.brand,
                            borderRadius: BorderRadius.circular(
                              tokens.radiusSmall,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            child: Text(
                              '$count',
                              style: textTheme.labelMedium?.copyWith(
                                color: tokens.onBrand,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Semantics(
                  label: l10n.historyDayBalance(amount),
                  excludeSemantics: true,
                  child: Text(
                    amount,
                    style: textTheme.titleMedium?.copyWith(
                      color: net < 0 ? tokens.expense : tokens.income,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
