import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/color_picker_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/core/widgets/icon_picker_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/number_grid_dialog.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/account_form_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/account_names.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Creates an account, or edits the one with [id].
class AccountFormPage extends StatelessWidget {
  const new({this.id, super.key});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<AccountFormCubit>();
        final settings = context.read<SettingsCubit>().state.settings;
        unawaited(
          cubit.load(mainCurrencyCode: settings.mainCurrencyCode, id: id),
        );
        return cubit;
      },
      child: const AccountFormView(),
    );
  }
}

class AccountFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<AccountFormCubit, AccountFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case AccountFormStatus.saved || AccountFormStatus.deleted) {
              context.pop();
            }
          },
        ),
        BlocListener<AccountFormCubit, AccountFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<AccountFormCubit, AccountFormState>(
        builder: (context, state) {
          final original = state.original;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                original == null
                    ? l10n.accountNewTitle
                    : l10n.accountEditTitle(original.name),
              ),
              actions: [
                if (state.canArchive && original != null)
                  _ArchiveButton(archived: original.isArchived),
                if (state.canDelete) const _DeleteButton(),
              ],
            ),
            body: switch (state.status) {
              AccountFormStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              AccountFormStatus.notFound => Center(
                child: Text(l10n.accountNotFound),
              ),
              _ => _AccountForm(state: state),
            },
          );
        },
      ),
    );
  }
}

class _AccountForm extends StatelessWidget {
  const new({required this.state});

  final AccountFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<AccountFormCubit>();
    final errors = state.errors;
    final type = state.type;
    final isCard = type == AccountType.creditCard;
    final currency = state.currency;
    final amountFormatters = [
      FilteringTextInputFormatter.allow(RegExp(r'[\d.,\s]')),
    ];
    final amountKeyboard = TextInputType.numberWithOptions(
      decimal: (currency?.format.decimals ?? 0) > 0,
    );
    final openingDate = state.openingDate ?? LocalDate.today();
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (state.isEditing) ...[
          ReadOnlyField(label: l10n.accountType, value: type.label(context)),
          FormNote(l10n.accountTypeLocked),
        ] else ...[
          FormLabel(l10n.accountType),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final option in AccountType.values)
                ChoiceChip(
                  label: Text(option.label(context)),
                  selected: option == type,
                  onSelected: (_) => cubit.typeChanged(option),
                ),
            ],
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Tooltip(
              message: l10n.accountIconTooltip,
              child: InkResponse(
                onTap: () async {
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
                  radius: 28,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextFormField(
                initialValue: state.name,
                onChanged: cubit.nameChanged,
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(AccountRules.maxNameLength),
                ],
                decoration: InputDecoration(
                  labelText: l10n.accountName,
                  errorText: errors.contains(AccountError.emptyName)
                      ? l10n.accountErrorName
                      : null,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () async {
              final color = await showColorPickerDialog(
                context,
                iconKey: state.iconKey,
                selected: Color(state.color),
              );
              if (color != null) cubit.colorChanged(color.toARGB32());
            },
            child: Text(l10n.accountChangeColor),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (state.isPocket) ...[
          DropdownButtonFormField<int>(
            initialValue: state.parentAccountId,
            items: [
              for (final parent in state.parentOptions)
                DropdownMenuItem(value: parent.id, child: Text(parent.name)),
            ],
            onChanged: (id) {
              if (id != null) cubit.parentChanged(id);
            },
            decoration: InputDecoration(
              labelText: l10n.accountParent,
              errorText:
                  errors.contains(AccountError.missingParent) ||
                      errors.contains(AccountError.invalidParent)
                  ? l10n.accountErrorParent
                  : null,
            ),
          ),
          FormNote(
            state.parentOptions.isEmpty
                ? l10n.accountParentNone
                : l10n.accountPocketFollowsParent,
          ),
        ] else ...[
          DropdownButtonFormField<String>(
            initialValue: state.currencyCode,
            items: [
              for (final currency in state.currencies)
                DropdownMenuItem(
                  value: currency.code,
                  child: Text('${currency.code} · ${currency.symbol}'),
                ),
            ],
            onChanged: state.currencyLocked
                ? null
                : (code) {
                    if (code != null) cubit.currencyChanged(code);
                  },
            decoration: InputDecoration(labelText: l10n.accountCurrency),
          ),
          if (state.currencyLocked) FormNote(l10n.accountCurrencyLocked),
        ],
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          initialValue: state.openingText,
          onChanged: cubit.openingChanged,
          keyboardType: amountKeyboard,
          inputFormatters: amountFormatters,
          decoration: InputDecoration(
            labelText: isCard ? l10n.accountCurrentDebt : l10n.accountOpening,
            helperText: type == AccountType.bank
                ? l10n.accountOpeningBankHint
                : null,
            suffixText: currency?.code,
            errorText: errors.contains(AccountError.invalidOpeningBalance)
                ? l10n.accountErrorAmount
                : null,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.accountOpeningDate),
          subtitle: Text(
            MaterialLocalizations.of(context)
                .formatMediumDate(openingDate.toDateTime()),
          ),
          trailing: const Icon(Icons.calendar_today_rounded),
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: openingDate.toDateTime(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              cubit.openingDateChanged(LocalDate.fromDateTime(picked));
            }
          },
        ),
        if (isCard) ...[
          TextFormField(
            initialValue: state.creditLimitText,
            onChanged: cubit.creditLimitChanged,
            keyboardType: amountKeyboard,
            inputFormatters: amountFormatters,
            decoration: InputDecoration(
              labelText: l10n.accountCreditLimit,
              suffixText: currency?.code,
              errorText: errors.contains(AccountError.invalidCreditLimit)
                  ? l10n.accountErrorCreditLimit
                  : null,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.accountPaymentDay),
            subtitle: Text(
              state.paymentDay?.toString() ?? l10n.accountPaymentDayUnset,
              style: errors.contains(AccountError.invalidPaymentDay)
                  ? TextStyle(color: context.colors.error)
                  : null,
            ),
            onTap: () async {
              final day = await showNumberGridDialog(
                context,
                title: l10n.accountPaymentDay,
                min: AccountRules.minPaymentDay,
                max: AccountRules.maxPaymentDay,
                selected: state.paymentDay ?? 0,
              );
              if (day != null) cubit.paymentDayChanged(day);
            },
          ),
        ],
        if (!state.isPocket)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.accountIncludeInBalance),
            value: state.includeInBalance,
            onChanged: (value) => cubit.includeInBalanceChanged(value: value),
          ),
        if (type == AccountType.bank)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.accountMain),
            subtitle: Text(
              (state.original?.isMain ?? false)
                  ? l10n.accountMainLocked
                  : l10n.accountMainHint,
            ),
            value: state.isMain,
            onChanged: (state.original?.isMain ?? false)
                ? null
                : (value) => cubit.isMainChanged(value: value),
          ),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: state.status == AccountFormStatus.saving
              ? null
              : cubit.submit,
          child: Text(l10n.actionSave),
        ),
        if (_lockReason(context) case final reason?) FormNote(reason),
      ],
    );
  }

  String? _lockReason(BuildContext context) {
    final original = state.original;
    if (original == null) return null;
    if (original.isMain) return context.l10n.accountMainStays;
    return null;
  }
}

class _ArchiveButton extends StatelessWidget {
  const new({required this.archived});

  final bool archived;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: archived
          ? l10n.accountUnarchiveTooltip
          : l10n.accountArchiveTooltip,
      icon: Icon(archived ? Icons.unarchive_outlined : Icons.archive_outlined),
      onPressed: () =>
          context.read<AccountFormCubit>().setArchived(archived: !archived),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.accountDeleteTooltip,
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () async {
        final cubit = context.read<AccountFormCubit>();
        final pockets = cubit.state.pockets;
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.accountDeleteTitle(cubit.state.original!.name)),
            content: Text(
              pockets.isEmpty
                  ? l10n.accountDeleteMessage
                  : l10n.accountDeleteWithPocketsMessage(
                      pockets.length,
                      pockets.map((p) => p.name).join(', '),
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.actionCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: context.colors.error,
                ),
                child: Text(
                  pockets.isEmpty
                      ? l10n.actionDelete
                      : l10n.accountDeleteWithPocketsAction,
                ),
              ),
            ],
          ),
        );
        if (confirmed ?? false) await cubit.delete();
      },
    );
  }
}
