import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/color_picker_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/icon_picker_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/number_grid_dialog.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/debts/presentation/cubit/debt_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Creates a debt of [type] or edits the debt [id] (RF-09). It pops once
/// saved.
class DebtFormPage extends StatelessWidget {
  const new({this.id, this.type = DebtType.iOwe, super.key});

  final int? id;
  final DebtType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<DebtFormCubit>();
        unawaited(
          cubit.load(
            id: id,
            type: type,
            settings: context.read<SettingsCubit>().state.settings,
          ),
        );
        return cubit;
      },
      child: const DebtFormView(),
    );
  }
}

class DebtFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<DebtFormCubit, DebtFormState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == DebtFormStatus.saved,
          listener: (context, state) => context.pop(true),
        ),
        BlocListener<DebtFormCubit, DebtFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<DebtFormCubit, DebtFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing
                  ? l10n.debtEditTitle(state.original!.name)
                  : l10n.debtNewTitle,
            ),
          ),
          body: switch (state.status) {
            DebtFormStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            DebtFormStatus.notFound => Center(child: Text(l10n.debtNotFound)),
            _ => _Form(state: state),
          },
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const new({required this.state});

  final DebtFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<DebtFormCubit>();
    final errors = state.showErrors ? state.errors : const <DebtError>{};
    final dueDay = state.dueDay;
    final dueDate = state.dueDate;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (!state.isEditing)
          SegmentedButton<DebtType>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(value: DebtType.iOwe, label: Text(l10n.debtsIOwe)),
              ButtonSegment(
                value: DebtType.owedToMe,
                label: Text(l10n.debtsOwedToMe),
              ),
            ],
            selected: {state.type},
            onSelectionChanged: (values) => cubit.typeChanged(values.single),
          ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            InkResponse(
              onTap: () async {
                FocusScope.of(context).unfocus();
                final icon = await showIconPickerDialog(
                  context,
                  selectedKey: state.iconKey,
                );
                if (icon != null) {
                  cubit.iconChanged(icon.key, icon.color.toARGB32());
                }
              },
              child: CatalogIconAvatar(
                iconKey: state.iconKey,
                color: Color(state.color),
                radius: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextFormField(
                key: const ValueKey('name'),
                initialValue: state.name,
                maxLength: DebtRules.maxNameLength,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n.debtName,
                  counterText: '',
                  errorText: errors.contains(DebtError.emptyName)
                      ? l10n.debtErrorName
                      : errors.contains(DebtError.nameTooLong)
                      ? l10n.debtErrorNameTooLong(DebtRules.maxNameLength)
                      : null,
                ),
                onChanged: cubit.nameChanged,
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              final color = await showColorPickerDialog(
                context,
                iconKey: state.iconKey,
                selected: Color(state.color),
              );
              if (color != null) cubit.colorChanged(color.toARGB32());
            },
            child: Text(l10n.debtChangeColor),
          ),
        ),
        TextFormField(
          key: const ValueKey('payee'),
          initialValue: state.payeeName,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: state.iOwe
                ? l10n.debtEntityIOwe
                : l10n.debtEntityOwedToMe,
            errorText: errors.contains(DebtError.missingPayee)
                ? l10n.debtErrorPayee
                : null,
          ),
          onChanged: cubit.payeeChanged,
        ),
        DropdownButtonFormField<String>(
          // Otherwise closing the menu refocuses the last text field.
          onTap: () => FocusScope.of(context).unfocus(),
          key: ValueKey(('currency', state.currencyCode)),
          initialValue: state.currencyCode,
          items: [
            for (final c in state.currencies)
              DropdownMenuItem(value: c.code, child: Text(c.code)),
          ],
          onChanged: state.currencyLocked
              ? null
              : (code) {
                  if (code != null) cubit.currencyChanged(code);
                },
          decoration: InputDecoration(
            labelText: l10n.debtCurrency,
            helperText: state.currencyLocked ? l10n.debtCurrencyLocked : null,
          ),
        ),
        TextFormField(
          key: const ValueKey('pending'),
          initialValue: state.pendingText,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
          ],
          decoration: InputDecoration(
            labelText: l10n.debtPendingAmount,
            helperText: l10n.debtPendingHint,
            suffixText: state.currencyCode,
            errorText: errors.contains(DebtError.invalidPending)
                ? l10n.debtErrorPending
                : null,
          ),
          onChanged: cubit.pendingChanged,
        ),
        if (state.iOwe)
          DropdownButtonFormField<int>(
            // Otherwise closing the menu refocuses the last text field.
            onTap: () => FocusScope.of(context).unfocus(),
            key: ValueKey(('pillar', state.pillarId)),
            initialValue: state.pillarId,
            items: [
              for (final p in state.pillars)
                DropdownMenuItem(value: p.id, child: Text(p.name)),
            ],
            onChanged: cubit.pillarChanged,
            decoration: InputDecoration(
              labelText: l10n.debtPillar,
              helperText: l10n.debtPillarHint,
              errorText: errors.contains(DebtError.missingPillar)
                  ? l10n.debtErrorPillar
                  : null,
            ),
          ),
        TextFormField(
          key: const ValueKey('installment'),
          initialValue: state.installmentText,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
          ],
          decoration: InputDecoration(
            labelText: l10n.debtInstallment,
            helperText: l10n.debtInstallmentHint,
            suffixText: state.currencyCode,
            errorText: errors.contains(DebtError.invalidInstallment)
                ? l10n.debtErrorInstallment
                : null,
          ),
          onChanged: cubit.installmentChanged,
        ),
        if (state.iOwe)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.debtDueDay),
            subtitle: Text(
              dueDay == null ? l10n.debtNone : l10n.debtsDueDay(dueDay),
            ),
            trailing: dueDay == null
                ? null
                : IconButton(
                    tooltip: l10n.debtClearDue,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => cubit.dueDayChanged(null),
                  ),
            onTap: () async {
              FocusScope.of(context).unfocus();
              final day = await showNumberGridDialog(
                context,
                title: l10n.debtDueDay,
                min: DebtRules.minDueDay,
                max: DebtRules.maxDueDay,
                selected: dueDay ?? 0,
              );
              if (day != null) cubit.dueDayChanged(day);
            },
          )
        else
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.debtDueDate),
            subtitle: Text(
              dueDate == null
                  ? l10n.debtNone
                  : DateFormat.yMMMd(
                      Localizations.localeOf(context).toLanguageTag(),
                    ).format(dueDate.toDateTime()),
            ),
            trailing: dueDate == null
                ? null
                : IconButton(
                    tooltip: l10n.debtClearDue,
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => cubit.dueDateChanged(null),
                  ),
            onTap: () async {
              FocusScope.of(context).unfocus();
              final today = LocalDate.today();
              final picked = await showDatePicker(
                context: context,
                initialDate: (dueDate ?? today).toDateTime(),
                firstDate: today.addDays(-365 * 5).toDateTime(),
                lastDate: today.addDays(365 * 10).toDateTime(),
              );
              if (picked != null) {
                cubit.dueDateChanged(LocalDate.fromDateTime(picked));
              }
            },
          ),
        const SizedBox(height: AppSpacing.md),
        FilledButton(
          onPressed: state.status == DebtFormStatus.saving
              ? null
              : cubit.submit,
          child: Text(context.l10n.actionSave),
        ),
      ],
    );
  }
}
