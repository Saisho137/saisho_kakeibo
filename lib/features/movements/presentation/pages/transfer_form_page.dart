import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/transfer_form_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/widgets/amount_keypad.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// A new transfer from [fromAccountId], or the transfer [id] to edit.
class TransferFormPage extends StatelessWidget {
  const new({this.id, this.fromAccountId, super.key});

  final int? id;
  final int? fromAccountId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<TransferFormCubit>();
        unawaited(cubit.load(fromAccountId: fromAccountId, id: id));
        return cubit;
      },
      child: const TransferFormView(),
    );
  }
}

class TransferFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<TransferFormCubit, TransferFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case TransferFormStatus.saved || TransferFormStatus.deleted) {
              context.pop(true);
            }
          },
        ),
        BlocListener<TransferFormCubit, TransferFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<TransferFormCubit, TransferFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: const CloseButton(),
            title: Text(
              state.isEditing ? l10n.transferEditTitle : l10n.transferNewTitle,
            ),
            actions: [if (state.isEditing) const _DeleteButton()],
          ),
          body: switch (state.status) {
            TransferFormStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            TransferFormStatus.notFound => Center(
              child: Text(l10n.movementNotFound),
            ),
            // Read above the Scaffold, which hides the insets from its body.
            _ => _TransferForm(
              state: state,
              keyboardOpen: MediaQuery.viewInsetsOf(context).bottom > 0,
            ),
          },
        ),
      ),
    );
  }
}

class _TransferForm extends StatelessWidget {
  const new({required this.state, required this.keyboardOpen});

  final TransferFormState state;
  final bool keyboardOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<TransferFormCubit>();
    final errors = state.showErrors ? state.errors : const <MovementError>{};
    final date = state.date ?? LocalDate.today();
    final accountError = errors.contains(MovementError.sameAccounts)
        ? l10n.transferErrorSame
        : null;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            children: [
              const SizedBox(height: AppSpacing.md),
              _AmountLine(
                label: l10n.transferSent,
                code: state.fromCurrency?.code,
                input: state.amount,
                format: state.fromFormat,
                selected: !state.editingTo,
                hasError: errors.contains(MovementError.invalidAmount),
                onTap: () => cubit.editingToChanged(value: false),
              ),
              if (!state.sameCurrency)
                _AmountLine(
                  label: l10n.transferReceived,
                  code: state.toCurrency?.code,
                  input: state.toAmount,
                  format: state.toFormat,
                  selected: state.editingTo,
                  hasError: errors.contains(MovementError.invalidAmount),
                  onTap: () => cubit.editingToChanged(value: true),
                ),
              if (errors.contains(MovementError.invalidAmount))
                Center(
                  child: Text(
                    l10n.movementErrorAmount,
                    style: TextStyle(color: context.colors.error),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              _AccountPicker(
                label: l10n.transferFrom,
                value: state.fromAccountId,
                options: state.accountOptions,
                errorText:
                    errors.contains(MovementError.missingAccount) &&
                        state.from == null
                    ? l10n.movementErrorAccount
                    : accountError,
                onChanged: cubit.fromChanged,
              ),
              _AccountPicker(
                label: l10n.transferTo,
                value: state.toAccountId,
                options: state.accountOptions,
                errorText:
                    errors.contains(MovementError.missingAccount) &&
                        state.to == null
                    ? l10n.transferErrorTo
                    : accountError,
                onChanged: cubit.toChanged,
              ),
              if (state.isInternal) FormNote(l10n.transferInternalHint),
              DropdownButtonFormField<int>(
                // Rebuilt when the suggestion changes the category.
                key: ValueKey(state.categoryId),
                initialValue: state.categoryId,
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
                onChanged: (id) {
                  if (id != null) cubit.categoryChanged(id);
                },
                decoration: InputDecoration(
                  labelText: l10n.transferCategory,
                  errorText: errors.contains(MovementError.missingCategory)
                      ? l10n.movementErrorCategory
                      : null,
                ),
              ),
              TextFormField(
                initialValue: state.note,
                onChanged: cubit.noteChanged,
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(MovementRules.maxNoteLength),
                ],
                decoration: InputDecoration(labelText: l10n.movementNote),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today_rounded),
                title: Text(_dateLabel(context, date)),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: date.toDateTime(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    cubit.dateChanged(LocalDate.fromDateTime(picked));
                  }
                },
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              children: [
                if (!keyboardOpen) ...[
                  AmountKeypad(
                    format: state.editingTo ? state.toFormat : state.fromFormat,
                    onKey: cubit.keyPressed,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                ],
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.status == TransferFormStatus.saving
                        ? null
                        : cubit.submit,
                    child: Text(l10n.actionSave),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static String _dateLabel(BuildContext context, LocalDate date) {
    final today = LocalDate.today();
    if (date == today) return context.l10n.dayToday;
    if (date == today.addDays(-1)) return context.l10n.dayYesterday;
    return MaterialLocalizations.of(context).formatFullDate(date.toDateTime());
  }
}

/// An amount of the transfer; the selected one receives the keypad.
class _AmountLine extends StatelessWidget {
  const new({
    required this.label,
    required this.code,
    required this.input,
    required this.format,
    required this.selected,
    required this.hasError,
    required this.onTap,
  });

  final String label;
  final String? code;
  final AmountInput input;
  final CurrencyFormat format;
  final bool selected;
  final bool hasError;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final result = input.hasOperator ? input.evaluate(format) : null;
    final text = input.isEmpty ? '0' : input.display(format);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
          border: Border.all(
            color: selected ? context.colors.primary : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            Text(label, style: context.textTheme.labelMedium),
            Text(
              '${code ?? ''} $text'.trim(),
              style: context.textTheme.headlineSmall?.copyWith(
                color: hasError ? context.colors.error : null,
              ),
            ),
            if (result != null)
              Text(
                context.l10n.movementResult(
                  MoneyFormatter.format(Money(result, code ?? ''), format),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AccountPicker extends StatelessWidget {
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
  final ValueChanged<int> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: value,
      isExpanded: true,
      items: [
        for (final account in options)
          DropdownMenuItem(
            value: account.id,
            child: Text(
              account.isPocket
                  ? '↳ ${account.name}'
                  : '${account.name} · ${account.currencyCode}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
      onChanged: (id) {
        if (id != null) onChanged(id);
      },
      decoration: InputDecoration(labelText: label, errorText: errorText),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.transferDeleteTooltip,
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () async {
        final cubit = context.read<TransferFormCubit>();
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.transferDeleteTitle),
            content: Text(l10n.movementDeleteMessage),
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
      },
    );
  }
}
