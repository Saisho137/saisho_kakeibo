import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/movements/presentation/cubit/movement_form_cubit.dart';
import 'package:saisho_kakeibo/features/movements/presentation/widgets/amount_keypad.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The quick entry form (RF-01): a new income or expense from a category
/// or a payee, or the movement [id] to edit. It pops `true` once saved.
class MovementFormPage extends StatelessWidget {
  const new({
    this.id,
    this.type = MovementType.expense,
    this.categoryId,
    this.payeeId,
    this.debtId,
    super.key,
  });

  final int? id;
  final MovementType type;
  final int? categoryId;
  final int? payeeId;

  /// Starts the payment or collection of this debt ("Pay", RF-09).
  final int? debtId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<MovementFormCubit>();
        final settings = context.read<SettingsCubit>().state.settings;
        unawaited(
          cubit.load(
            type: type,
            categoryId: categoryId,
            payeeId: payeeId,
            debtId: debtId,
            id: id,
            minDays: settings.minDaysBetweenPeriods,
          ),
        );
        return cubit;
      },
      child: const MovementFormView(),
    );
  }
}

class MovementFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<MovementFormCubit, MovementFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case MovementFormStatus.saved || MovementFormStatus.deleted) {
              context.pop(true);
            }
          },
        ),
        BlocListener<MovementFormCubit, MovementFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<MovementFormCubit, MovementFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: const CloseButton(),
            title:
                state.status == MovementFormStatus.loading ||
                    state.status == MovementFormStatus.notFound
                ? null
                : _CategoryTitle(state: state),
            actions: [
              // A movement of a template is already recurring; loans never
              // repeat.
              if (state.original
                  case Movement(:final id, recurringTemplateId: null)
                  when RecurringRules.allows(
                    state.category?.role ?? CategoryRole.custom,
                  ))
                IconButton(
                  tooltip: l10n.movementMakeRecurring,
                  icon: const Icon(Icons.event_repeat_rounded),
                  onPressed: () =>
                      context.push(AppRoutes.newRecurring(fromMovementId: id)),
                ),
              if (state.isEditing) const _DeleteButton(),
            ],
          ),
          body: switch (state.status) {
            MovementFormStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            MovementFormStatus.notFound => Center(
              child: Text(l10n.movementNotFound),
            ),
            // Read above the Scaffold, which hides the insets from its body.
            _ => _MovementForm(
              state: state,
              keyboardOpen: MediaQuery.viewInsetsOf(context).bottom > 0,
            ),
          },
        ),
      ),
    );
  }
}

/// The category in the title; tapping it picks another one.
class _CategoryTitle extends StatelessWidget {
  const new({required this.state});

  final MovementFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final category = state.category;
    final hasError =
        state.errors.contains(MovementError.missingCategory) &&
        state.showErrors;
    return Tooltip(
      message: l10n.movementChangeCategory,
      child: InkWell(
        onTap: () async {
          final cubit = context.read<MovementFormCubit>();
          final picked = await showDialog<int>(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text(l10n.movementChangeCategory),
              children: [
                for (final option in state.categoryOptions)
                  SimpleDialogOption(
                    onPressed: () => Navigator.of(context).pop(option.id),
                    child: Row(
                      children: [
                        CatalogIconAvatar(
                          iconKey: option.iconKey,
                          color: Color(option.color),
                          radius: 14,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Flexible(child: Text(option.name)),
                      ],
                    ),
                  ),
              ],
            ),
          );
          if (picked != null) cubit.categoryChanged(picked);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category != null) ...[
              CatalogIconAvatar(
                iconKey: category.iconKey,
                color: Color(category.color),
                radius: 16,
              ),
              const SizedBox(width: AppSpacing.sm),
            ],
            Flexible(
              child: Text(
                category?.name ?? l10n.movementErrorCategory,
                overflow: TextOverflow.ellipsis,
                style: hasError ? TextStyle(color: context.colors.error) : null,
              ),
            ),
            const Icon(Icons.arrow_drop_down_rounded),
          ],
        ),
      ),
    );
  }
}

class _MovementForm extends StatelessWidget {
  const new({required this.state, required this.keyboardOpen});

  final MovementFormState state;

  /// The system keyboard takes the keypad's place while a text field is
  /// focused.
  final bool keyboardOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<MovementFormCubit>();
    final errors = state.showErrors ? state.errors : const <MovementError>{};
    final date = state.date ?? LocalDate.today();
    final result = state.result;
    final currency = state.currency;
    final amountText = state.amount.isEmpty
        ? '0'
        : state.amount.display(state.format);
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            children: [
              const SizedBox(height: AppSpacing.md),
              Center(
                child: Text(
                  '${currency?.code ?? ''} $amountText'.trim(),
                  key: const Key('movementAmount'),
                  style: context.textTheme.headlineMedium?.copyWith(
                    backgroundColor: state.amountSelected
                        ? context.colors.primaryContainer
                        : null,
                    color: errors.contains(MovementError.invalidAmount)
                        ? context.colors.error
                        : null,
                  ),
                ),
              ),
              if (result != null)
                Center(
                  child: Text(
                    l10n.movementResult(
                      MoneyFormatter.format(
                        Money(result, currency?.code ?? ''),
                        state.format,
                      ),
                    ),
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              if (errors.contains(MovementError.invalidAmount))
                Center(
                  child: Text(
                    l10n.movementErrorAmount,
                    style: TextStyle(color: context.colors.error),
                  ),
                ),
              const SizedBox(height: AppSpacing.md),
              UnfocusOnPointer(
                child: DropdownButtonFormField<int>(
                  initialValue: state.accountId,
                  isExpanded: true,
                  items: [
                    for (final account in state.accountOptions)
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
                    if (id != null) cubit.accountChanged(id);
                  },
                  decoration: InputDecoration(
                    labelText: l10n.movementAccount,
                    errorText: errors.contains(MovementError.missingAccount)
                        ? l10n.movementErrorAccount
                        : null,
                  ),
                ),
              ),
              if (state.showsPayee) _PayeeField(state: state),
              if (state.debtType != null) _DebtSection(state: state),
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
                    await cubit.dateChanged(LocalDate.fromDateTime(picked));
                  }
                },
              ),
              if (state.isSalary)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.movementStartsPeriod),
                  subtitle: Text(l10n.movementStartsPeriodHint),
                  value: state.startsPeriod,
                  onChanged: (value) => cubit.startsPeriodChanged(value: value),
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
                  AmountKeypad(format: state.format, onKey: cubit.keyPressed),
                  const SizedBox(height: AppSpacing.sm),
                ],
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: state.status == MovementFormStatus.saving
                        ? null
                        : cubit.submit,
                    child: Text(
                      state.isPending ? l10n.movementConfirm : l10n.actionSave,
                    ),
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

/// The payee field, autocompleted with the stored payees (RF-07).
class _PayeeField extends StatelessWidget {
  const new({required this.state});

  final MovementFormState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MovementFormCubit>();
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: state.payeeName ?? ''),
      optionsBuilder: (value) => state.payeeOptions(value.text),
      onSelected: cubit.payeeChanged,
      fieldViewBuilder: (context, controller, focusNode, onSubmitted) =>
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            onChanged: cubit.payeeChanged,
            onFieldSubmitted: (_) => onSubmitted(),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: context.l10n.movementPayee),
          ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.movementDeleteTooltip,
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () async {
        final cubit = context.read<MovementFormCubit>();
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.movementDeleteTitle),
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

/// The debt of a debt category (RF-09): the one paid, collected or added
/// to, or the fields of the debt the movement creates.
class _DebtSection extends StatelessWidget {
  const new({required this.state});

  final MovementFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<MovementFormCubit>();
    final errors = state.showErrors ? state.errors : const <MovementError>{};
    final missing = errors.contains(MovementError.missingDebt);
    String left(int pending) => MoneyFormatter.format(
      Money(pending, state.currency?.code ?? ''),
      state.format,
    );
    final picker = state.alwaysNewDebt
        ? null
        : UnfocusOnPointer(
            child: DropdownButtonFormField<int?>(
              key: ValueKey(('debt', state.debtId, state.newDebt)),
              initialValue: state.createsDebt ? null : state.debtId,
              isExpanded: true,
              items: [
                for (final line in state.debtOptions)
                  DropdownMenuItem(
                    value: line.debt.id,
                    child: Text(
                      l10n.movementDebtOption(
                        line.debt.name,
                        left(line.status.pending),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (state.mayCreateDebt)
                  DropdownMenuItem(child: Text(l10n.movementNewDebt)),
              ],
              onChanged: cubit.debtChanged,
              decoration: InputDecoration(
                labelText: l10n.movementDebt,
                errorText: missing && !state.createsDebt
                    ? l10n.movementErrorDebt
                    : null,
              ),
            ),
          );
    return Column(
      children: [
        ?picker,
        if (state.createsDebt) ...[
          if (missing) FormNote(l10n.movementErrorDebtPayee, isError: true),
          TextFormField(
            key: const ValueKey('debtName'),
            initialValue: state.debtName,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.movementDebtName,
              helperText: l10n.movementDebtNameHint,
            ),
            onChanged: cubit.debtNameChanged,
          ),
        ],
        if (state.alwaysNewDebt) ...[
          TextFormField(
            key: const ValueKey('debtPending'),
            initialValue: state.debtPendingText,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
            ],
            decoration: InputDecoration(
              labelText: l10n.movementDebtPending,
              helperText: l10n.movementDebtPendingHint,
            ),
            onChanged: cubit.debtPendingChanged,
          ),
          UnfocusOnPointer(
            child: DropdownButtonFormField<int>(
              key: ValueKey(('debtPillar', state.debtPillarId)),
              initialValue: state.debtPillarId,
              items: [
                for (final p in state.pillars)
                  DropdownMenuItem(value: p.id, child: Text(p.name)),
              ],
              onChanged: cubit.debtPillarChanged,
              decoration: InputDecoration(
                labelText: l10n.movementDebtPillar,
                errorText: errors.contains(MovementError.missingDebtPillar)
                    ? l10n.movementErrorDebtPillar
                    : null,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
