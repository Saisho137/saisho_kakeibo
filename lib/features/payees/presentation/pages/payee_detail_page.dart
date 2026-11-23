import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/text/text_normalizer.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/currency_menu_button.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/movement_tile.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/payees/presentation/cubit/payee_detail_cubit.dart';
import 'package:saisho_kakeibo/features/payees/presentation/widgets/payee_net_text.dart';
import 'package:saisho_kakeibo/features/payees/presentation/widgets/price_chart.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/day_label.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// An entity's totals, price evolution and movements, with *Rename*,
/// *Merge into…* and *Delete* (RF-08).
class PayeeDetailPage extends StatelessWidget {
  const new({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PayeeDetailCubit>()..load(id),
      child: const PayeeDetailView(),
    );
  }
}

enum _Action { rename, merge, delete }

class PayeeDetailView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        // The entity was merged or deleted.
        BlocListener<PayeeDetailCubit, PayeeDetailState>(
          listenWhen: (previous, current) =>
              previous.status == PayeeDetailStatus.success &&
              current.status == PayeeDetailStatus.notFound,
          listener: (context, state) => context.pop(),
        ),
        BlocListener<PayeeDetailCubit, PayeeDetailState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<PayeeDetailCubit, PayeeDetailState>(
        builder: (context, state) {
          final payee = state.payee;
          final currency = state.currency;
          return Scaffold(
            appBar: AppBar(
              title: Text(payee?.name ?? ''),
              actions: [
                if (state.currencyOptions.length > 1 &&
                    state.currencyCode != null)
                  CurrencyMenuButton(
                    selected: state.currencyCode!,
                    currencies: state.currencyOptions,
                    onSelected: context
                        .read<PayeeDetailCubit>()
                        .currencySelected,
                  ),
                if (payee != null)
                  PopupMenuButton<_Action>(
                    tooltip: l10n.payeeMoreTooltip,
                    onSelected: (action) => switch (action) {
                      _Action.rename => _rename(context, state, payee),
                      _Action.merge => _merge(context, state, payee),
                      _Action.delete => _delete(context, payee),
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: _Action.rename,
                        child: Text(l10n.payeeRename),
                      ),
                      PopupMenuItem(
                        value: _Action.merge,
                        enabled: state.mergeTargets.isNotEmpty,
                        child: Text(l10n.payeeMerge),
                      ),
                      PopupMenuItem(
                        value: _Action.delete,
                        enabled: state.debt == null,
                        child: Text(l10n.actionDelete),
                      ),
                    ],
                  ),
              ],
            ),
            body: switch (state.status) {
              PayeeDetailStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              PayeeDetailStatus.notFound => Center(
                child: Text(l10n.payeeNotFound),
              ),
              PayeeDetailStatus.success when currency != null => _Detail(
                state: state,
                currency: currency,
              ),
              _ => Center(child: Text(l10n.genericError)),
            },
          );
        },
      ),
    );
  }

  static Future<void> _rename(
    BuildContext context,
    PayeeDetailState state,
    Payee payee,
  ) async {
    final cubit = context.read<PayeeDetailCubit>();
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _RenameDialog(
        current: payee.name,
        debtName: state.debt?.name,
        isTaken: state.nameTaken,
      ),
    );
    if (name != null) await cubit.rename(name);
  }

  static Future<void> _merge(
    BuildContext context,
    PayeeDetailState state,
    Payee payee,
  ) async {
    final l10n = context.l10n;
    final cubit = context.read<PayeeDetailCubit>();
    final target = await showDialog<Payee>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.payeeMergeTitle(payee.name)),
        children: [
          for (final p in state.mergeTargets)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(p),
              child: Text(p.name),
            ),
        ],
      ),
    );
    if (target == null || !context.mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.payeeMergeConfirmTitle(target.name)),
        content: Text(l10n.payeeMergeMessage(payee.name, target.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.payeeMergeAction),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.mergeInto(target.id);
  }

  static Future<void> _delete(BuildContext context, Payee payee) async {
    final l10n = context.l10n;
    final cubit = context.read<PayeeDetailCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.payeeDeleteTitle(payee.name)),
        content: Text(l10n.payeeDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.actionCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.actionDelete),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.delete();
  }
}

class _Detail extends StatelessWidget {
  const new({required this.state, required this.currency});

  final PayeeDetailState state;
  final Currency currency;

  String _money(int amount) =>
      MoneyFormatter.format(Money(amount, currency.code), currency.format);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final allTime = state.allTime;
    final period = state.thisPeriod;
    final average = allTime.averagePrice;
    final last = allTime.lastPrice;
    final debt = state.debt;
    final days = <(DateTime, List<Movement>)>[];
    for (final m in state.payeeMovements) {
      final day = m.date.toDateTime();
      if (days.isEmpty || days.last.$1 != day) days.add((day, []));
      days.last.$2.add(m);
    }
    Widget row(String label, Widget value) => ListTile(
      dense: true,
      title: Text(label),
      trailing: DefaultTextStyle.merge(
        style: context.textTheme.titleSmall,
        child: value,
      ),
    );
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        row(
          l10n.payeesThisPeriod,
          PayeeNetText(stats: period, currency: currency),
        ),
        row(
          l10n.payeesAllTime,
          PayeeNetText(stats: allTime, currency: currency),
        ),
        row(l10n.payeeMovementCount, Text('${allTime.count}')),
        if (average != null) row(l10n.payeeAveragePrice, Text(_money(average))),
        if (last != null) row(l10n.payeeLastPrice, Text(_money(last))),
        if (debt != null) ...[
          ListTile(
            leading: const Icon(Icons.request_quote_rounded),
            title: Text(l10n.payeeIsDebt(debt.name)),
            subtitle: Text(l10n.payeeDeleteBlocked(debt.name)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => context.push(AppRoutes.debtDetail(debt.id)),
          ),
        ],
        if (allTime.prices.length > 1) ...[
          SectionHeader(l10n.payeePriceChart),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: PriceChart(prices: allTime.prices, currency: currency),
          ),
        ],
        SectionHeader(l10n.payeeMovements),
        if (days.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(l10n.payeeNoMovements, textAlign: TextAlign.center),
          ),
        for (final (_, movements) in days) ...[
          SectionHeader(dayLabel(context, movements.first.date)),
          for (final m in movements)
            MovementTile(
              key: ValueKey(m.id),
              movement: m,
              accountId: m.accountId,
              currency: currency,
              category: state.categoryOf(m),
              payee: state.payee,
              onTap: () => context.push(AppRoutes.editMovement(m.id)),
            ),
        ],
      ],
    );
  }
}

/// Asks the new name; a name another entity has is refused, since merging
/// is how two entities become one.
class _RenameDialog extends StatefulWidget {
  const new({
    required this.current,
    required this.debtName,
    required this.isTaken,
  });

  final String current;

  /// The debt that is this entity, renamed along.
  final String? debtName;
  final bool Function(String key) isTaken;

  @override
  State<_RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<_RenameDialog> {
  late String _text = widget.current;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = PayeeName.parse(_text);
    final error = name == null
        ? l10n.payeeErrorName
        : widget.isTaken(TextNormalizer.key(name.name))
        ? l10n.payeeErrorNameTaken
        : null;
    final debtName = widget.debtName;
    return AlertDialog(
      title: Text(l10n.payeeRename),
      content: TextFormField(
        initialValue: _text,
        autofocus: true,
        maxLength: PayeeRules.maxNameLength,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: l10n.payeeName,
          counterText: '',
          errorText: error,
          errorMaxLines: 2,
          helperText: debtName == null ? null : l10n.payeeRenameDebt(debtName),
        ),
        onChanged: (text) => setState(() => _text = text),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: error == null
              ? () => Navigator.of(context).pop(_text)
              : null,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
