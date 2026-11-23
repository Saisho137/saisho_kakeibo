import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/movement_tile.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/services/debt_status.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_detail_cubit.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/day_label.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// A debt with what is pending, its details and its movements (RF-09).
class DebtDetailPage extends StatelessWidget {
  const new({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DebtDetailCubit>()..load(id),
      child: const DebtDetailView(),
    );
  }
}

class DebtDetailView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        // The debt was deleted.
        BlocListener<DebtDetailCubit, DebtDetailState>(
          listenWhen: (previous, current) =>
              previous.status == DebtDetailStatus.success &&
              current.status == DebtDetailStatus.notFound,
          listener: (context, state) => context.pop(),
        ),
        BlocListener<DebtDetailCubit, DebtDetailState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<DebtDetailCubit, DebtDetailState>(
        builder: (context, state) {
          final debt = state.debt;
          final status = state.debtStatus;
          final currency = state.currency;
          return Scaffold(
            appBar: AppBar(
              title: Text(debt?.name ?? ''),
              actions: [
                if (debt != null)
                  IconButton(
                    tooltip: l10n.debtEditTooltip,
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => context.push(AppRoutes.editDebt(debt.id)),
                  ),
                if (state.canDelete && debt != null)
                  IconButton(
                    tooltip: l10n.debtDeleteTooltip,
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () => _confirmDelete(context, debt),
                  ),
              ],
            ),
            body: switch (state.status) {
              DebtDetailStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              DebtDetailStatus.notFound => Center(
                child: Text(l10n.debtNotFound),
              ),
              DebtDetailStatus.success
                  when debt != null && status != null && currency != null =>
                _Detail(
                  state: state,
                  debt: debt,
                  status: status,
                  currency: currency,
                ),
              _ => Center(child: Text(l10n.genericError)),
            },
          );
        },
      ),
    );
  }

  static Future<void> _confirmDelete(BuildContext context, Debt debt) async {
    final l10n = context.l10n;
    final cubit = context.read<DebtDetailCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.debtDeleteTitle(debt.name)),
        content: Text(l10n.debtDeleteMessage),
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
  const new({
    required this.state,
    required this.debt,
    required this.status,
    required this.currency,
  });

  final DebtDetailState state;
  final Debt debt;
  final DebtStatus status;
  final Currency currency;

  String _money(int amount) =>
      MoneyFormatter.format(Money(amount, currency.code), currency.format);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dueDay = debt.dueDay;
    final dueDate = debt.dueDate;
    final details = [
      ?state.payeeOf(debt.payeeId)?.name,
      ?state.pillar?.name,
      if (dueDay != null) l10n.debtsDueDay(dueDay),
      if (dueDate != null)
        l10n.debtsDueDate(
          DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag())
              .format(dueDate.toDateTime()),
        ),
    ];
    final days = <(DateTime, List<Movement>)>[];
    for (final m in state.debtMovements) {
      final day = m.date.toDateTime();
      if (days.isEmpty || days.last.$1 != day) days.add((day, []));
      days.last.$2.add(m);
    }
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        ListTile(
          leading: CatalogIconAvatar(
            iconKey: debt.iconKey,
            color: Color(debt.color),
            radius: 24,
          ),
          title: Text(
            '${_money(status.pending)} ${currency.code}',
            style: context.textTheme.headlineSmall?.copyWith(
              color: status.pending < 0 ? context.tokens.expense : null,
            ),
          ),
          subtitle: Text(
            status.isPaidOff
                ? l10n.debtPaidOffLabel
                : l10n.debtInitial(_money(debt.initialPending)),
          ),
        ),
        if (details.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(details.join(' · ')),
          ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Expanded(child: LinearProgressIndicator(value: status.progress)),
              const SizedBox(width: AppSpacing.sm),
              Text('${(status.progress * 100).round()}%'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (state.paymentCategory case final category?)
                FilledButton.icon(
                  icon: Icon(
                    debt.iOwe ? Icons.payments_rounded : Icons.savings_rounded,
                  ),
                  label: Text(debt.iOwe ? l10n.debtPay : l10n.debtCollect),
                  // "Pay" opens the payment with this debt and its
                  // installment (RF-09).
                  onPressed: () => context.push(
                    AppRoutes.newMovement(
                      debt.iOwe ? MovementType.expense : MovementType.income,
                      categoryId: category.id,
                      debtId: debt.id,
                    ),
                  ),
                ),
              OutlinedButton.icon(
                icon: const Icon(Icons.tune_rounded),
                label: Text(l10n.debtEditPending),
                onPressed: () async {
                  final cubit = context.read<DebtDetailCubit>();
                  final pending = await showDialog<int>(
                    context: context,
                    builder: (_) => _EditPendingDialog(
                      currency: currency,
                      current: status.pending,
                    ),
                  );
                  if (pending != null) await cubit.editPending(pending);
                },
              ),
            ],
          ),
        ),
        SectionHeader(l10n.debtMovements),
        if (days.isEmpty)
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(l10n.debtNoMovements, textAlign: TextAlign.center),
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
              payee: state.payeeOf(m.payeeId),
              onTap: () => context.push(AppRoutes.editMovement(m.id)),
            ),
        ],
      ],
    );
  }
}

/// Asks what is pending now, as a positive amount.
class _EditPendingDialog extends StatefulWidget {
  const new({required this.currency, required this.current});

  final Currency currency;
  final int current;

  @override
  State<_EditPendingDialog> createState() => _EditPendingDialogState();
}

class _EditPendingDialogState extends State<_EditPendingDialog> {
  late String _text = MoneyFormatter.format(
    Money(widget.current < 0 ? 0 : widget.current, widget.currency.code),
    widget.currency.format,
  );

  int? get _pending => _text.trim().isEmpty
      ? null
      : AmountParser.parse(_text, widget.currency.format);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.debtEditPending),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: _text,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.debtPending,
              suffixText: widget.currency.code,
              errorText: _pending == null ? l10n.debtErrorPending : null,
            ),
            onChanged: (text) => setState(() => _text = text),
          ),
          FormNote(l10n.debtEditPendingHint),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () {
            final pending = _pending;
            if (pending != null) Navigator.of(context).pop(pending);
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}
