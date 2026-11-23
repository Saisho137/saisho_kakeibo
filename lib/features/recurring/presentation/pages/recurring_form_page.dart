import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/core/widgets/number_grid_dialog.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/presentation/widgets/category_names.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';
import 'package:saisho_kakeibo/features/recurring/presentation/cubit/recurring_form_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Creates or edits a recurring template (RF-06); [fromMovementId] starts
/// it from a saved movement ("Make recurring"). It pops once saved.
class RecurringFormPage extends StatelessWidget {
  const new({this.id, this.fromMovementId, super.key});

  final int? id;
  final int? fromMovementId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<RecurringFormCubit>();
        unawaited(cubit.load(id: id, fromMovementId: fromMovementId));
        return cubit;
      },
      child: const RecurringFormView(),
    );
  }
}

class RecurringFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<RecurringFormCubit, RecurringFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case RecurringFormStatus.saved || RecurringFormStatus.deleted) {
              context.pop(true);
            }
          },
        ),
        BlocListener<RecurringFormCubit, RecurringFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<RecurringFormCubit, RecurringFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing
                  ? l10n.recurringEditTitle
                  : l10n.recurringNewTitle,
            ),
            actions: [
              if (state.isEditing)
                IconButton(
                  tooltip: l10n.recurringDeleteTooltip,
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => _confirmDelete(context),
                ),
            ],
          ),
          body: switch (state.status) {
            RecurringFormStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            RecurringFormStatus.notFound => Center(
              child: Text(l10n.recurringNotFound),
            ),
            _ => _Form(state: state),
          },
        ),
      ),
    );
  }

  static Future<void> _confirmDelete(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<RecurringFormCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.recurringDeleteTitle),
        content: Text(l10n.recurringDeleteMessage),
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

class _Form extends StatelessWidget {
  const new({required this.state});

  final RecurringFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RecurringFormCubit>();
    final errors = state.showErrors ? state.errors : const <MovementError>{};
    final isTransfer = state.type == MovementType.transfer;
    final dueDay = state.dueDay;
    final sameAccounts = errors.contains(MovementError.sameAccounts)
        ? l10n.transferErrorSame
        : null;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        SegmentedButton<MovementType>(
          showSelectedIcon: false,
          segments: [
            for (final (type, categoryType) in const [
              (MovementType.expense, CategoryType.expense),
              (MovementType.transfer, CategoryType.transfer),
              (MovementType.income, CategoryType.income),
            ])
              ButtonSegment(
                value: type,
                label: Text(categoryType.label(context)),
              ),
          ],
          selected: {state.type},
          onSelectionChanged: (values) => cubit.typeChanged(values.single),
        ),
        const SizedBox(height: AppSpacing.md),
        DropdownButtonFormField<int>(
          // Otherwise closing the menu refocuses the last text field.
          onTap: () => FocusScope.of(context).unfocus(),
          key: ValueKey(('category', state.type, state.categoryId)),
          initialValue:
              state.categoryOptions.any((c) => c.id == state.categoryId)
              ? state.categoryId
              : null,
          isExpanded: true,
          items: [
            for (final category in state.categoryOptions)
              DropdownMenuItem(
                value: category.id,
                child: Row(
                  children: [
                    CatalogIconAvatar(
                      iconKey: category.iconKey,
                      color: Color(category.color),
                      radius: 12,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        category.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
          ],
          onChanged: cubit.categoryChanged,
          decoration: InputDecoration(
            labelText: l10n.recurringCategory,
            errorText: errors.contains(MovementError.missingCategory)
                ? l10n.movementErrorCategory
                : null,
          ),
        ),
        _AccountField(
          label: isTransfer ? l10n.recurringFrom : l10n.movementAccount,
          value: state.accountId,
          options: state.accountOptions,
          errorText:
              errors.contains(MovementError.missingAccount) &&
                  state.account == null
              ? l10n.movementErrorAccount
              : sameAccounts,
          onChanged: cubit.accountChanged,
        ),
        if (isTransfer)
          _AccountField(
            label: l10n.recurringTo,
            value: state.toAccountId,
            options: state.accountOptions,
            errorText:
                errors.contains(MovementError.missingAccount) &&
                    state.toAccount == null
                ? l10n.transferErrorTo
                : sameAccounts,
            onChanged: cubit.toAccountChanged,
          ),
        TextFormField(
          key: const ValueKey('amount'),
          initialValue: state.amountText,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
          ],
          decoration: InputDecoration(
            labelText: l10n.recurringAmount,
            suffixText: state.account?.currencyCode,
            errorText: errors.contains(MovementError.invalidAmount)
                ? l10n.movementErrorAmount
                : null,
          ),
          onChanged: cubit.amountChanged,
        ),
        if (isTransfer && !state.sameCurrency)
          TextFormField(
            key: const ValueKey('toAmount'),
            initialValue: state.toAmountText,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.recurringToAmount,
              suffixText: state.toAccount?.currencyCode,
            ),
            onChanged: cubit.toAmountChanged,
          ),
        if (!isTransfer)
          TextFormField(
            key: const ValueKey('payee'),
            initialValue: state.payeeName,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.movementPayee),
            onChanged: cubit.payeeChanged,
          ),
        TextFormField(
          key: const ValueKey('note'),
          initialValue: state.note,
          maxLength: MovementRules.maxNoteLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: l10n.movementNote,
            counterText: '',
          ),
          onChanged: cubit.noteChanged,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.recurringCadence, style: context.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        SegmentedButton<RecurringCadence>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: RecurringCadence.period,
              label: Text(l10n.recurringCadencePeriod),
            ),
            ButtonSegment(
              value: RecurringCadence.monthly,
              label: Text(l10n.recurringCadenceMonthly),
            ),
          ],
          selected: {state.cadence},
          onSelectionChanged: (values) => cubit.cadenceChanged(values.single),
        ),
        FormNote(
          state.cadence == RecurringCadence.period
              ? l10n.recurringCadencePeriodHint
              : l10n.recurringCadenceMonthlyHint,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.recurringDueDay),
          subtitle: Text(
            dueDay == null
                ? l10n.recurringNoDueDay
                : l10n.recurringDueDayValue(dueDay),
          ),
          trailing: dueDay == null
              ? null
              : IconButton(
                  tooltip: l10n.recurringClearDueDay,
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => cubit.dueDayChanged(null),
                ),
          onTap: () async {
            // Otherwise the text field regains focus and reopens the keyboard.
            FocusScope.of(context).unfocus();
            final day = await showNumberGridDialog(
              context,
              title: l10n.recurringDueDay,
              message: l10n.recurringDueDayHint,
              min: RecurringRules.minDueDay,
              max: RecurringRules.maxDueDay,
              selected: dueDay ?? 0,
            );
            if (day != null) cubit.dueDayChanged(day);
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.recurringRemind),
          value: state.remind,
          onChanged: dueDay == null
              ? null
              : (value) => cubit.remindChanged(value: value),
        ),
        if (!state.isEditing) FormNote(l10n.recurringFirstHint),
        const SizedBox(height: AppSpacing.md),
        FilledButton(
          onPressed: state.status == RecurringFormStatus.saving
              ? null
              : cubit.submit,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}

class _AccountField extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.errorText,
  });

  final String label;
  final int? value;
  final List<Account> options;
  final ValueChanged<int?> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      // Otherwise closing the menu refocuses the last text field.
      onTap: () => FocusScope.of(context).unfocus(),
      key: ValueKey((label, value)),
      initialValue: options.any((a) => a.id == value) ? value : null,
      isExpanded: true,
      items: [
        for (final account in options)
          DropdownMenuItem(
            value: account.id,
            child: Text(
              '${account.name} · ${account.currencyCode}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(labelText: label, errorText: errorText),
    );
  }
}
