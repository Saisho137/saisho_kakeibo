import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/money/percentages.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/movement_tile.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/day_label.dart';
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
    showDragHandle: true,
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<HomeCubit>().state;
    final period = state.visiblePeriod;
    final currency = state.currency;
    if (period == null || currency == null) return const SizedBox.shrink();
    return ListView(
      controller: widget.controller,
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        Text(
          periodLabel(context, period),
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: false, label: Text(l10n.historyByDay)),
              ButtonSegment(value: true, label: Text(l10n.historyByCategory)),
            ],
            selected: {_byCategory},
            onSelectionChanged: (values) =>
                setState(() => _byCategory = values.single),
          ),
        ),
        if (_byCategory) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
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
        SectionHeader(dayLabel(context, day)),
        for (final entry in entries) _tile(context, state, entry, currency),
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
    Currency currency,
  ) {
    final (:movement, :accountId) = entry;
    final accounts = state.accounts ?? const [];
    return MovementTile(
      key: ValueKey(movement.id),
      movement: movement,
      accountId: accountId,
      currency: currency,
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
