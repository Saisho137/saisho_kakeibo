import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/currency_rules.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currency_form_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/widgets/currency_preview.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Creates a currency, or edits the one with [code].
class CurrencyFormPage extends StatelessWidget {
  const new({this.code, super.key});

  final String? code;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CurrencyFormCubit>();
        unawaited(cubit.load(code));
        return cubit;
      },
      child: const CurrencyFormView(),
    );
  }
}

class CurrencyFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<CurrencyFormCubit, CurrencyFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case CurrencyFormStatus.saved || CurrencyFormStatus.deleted) {
              context.pop();
            }
          },
        ),
        BlocListener<CurrencyFormCubit, CurrencyFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<CurrencyFormCubit, CurrencyFormState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing
                  ? l10n.currencyEditTitle(state.code)
                  : l10n.currencyNewTitle,
            ),
            actions: [if (_canDelete(context, state)) const _DeleteButton()],
          ),
          body: switch (state.status) {
            CurrencyFormStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            CurrencyFormStatus.notFound => Center(
              child: Text(l10n.currencyNotFound),
            ),
            _ => _CurrencyForm(state: state),
          },
        ),
      ),
    );
  }

  static bool _canDelete(BuildContext context, CurrencyFormState state) {
    final original = state.original;
    if (original == null || original.isBuiltIn || state.inUse) return false;
    final mainCode = context.select<SettingsCubit, String>(
      (cubit) => cubit.state.settings.mainCurrencyCode,
    );
    return original.code != mainCode;
  }
}

class _CurrencyForm extends StatelessWidget {
  const new({required this.state});

  final CurrencyFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CurrencyFormCubit>();
    final errors = state.errors;
    final format = state.format;
    final lockReason = _lockReason(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (state.isEditing)
          ReadOnlyField(label: l10n.currencyCode, value: state.code)
        else
          TextFormField(
            initialValue: state.code,
            onChanged: cubit.codeChanged,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              labelText: l10n.currencyCode,
              hintText: l10n.currencyCodeHint,
              errorText: errors.contains(CurrencyError.duplicateCode)
                  ? l10n.currencyErrorDuplicate
                  : errors.contains(CurrencyError.invalidCode)
                  ? l10n.currencyErrorCode
                  : null,
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        TextFormField(
          initialValue: state.symbol,
          onChanged: cubit.symbolChanged,
          inputFormatters: [
            LengthLimitingTextInputFormatter(CurrencyRules.maxSymbolLength),
          ],
          decoration: InputDecoration(
            labelText: l10n.currencySymbol,
            errorText: errors.contains(CurrencyError.invalidSymbol)
                ? l10n.currencyErrorSymbol
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (state.isEditing) ...[
          ReadOnlyField(
            label: l10n.currencyDecimals,
            value: '${state.decimals}',
          ),
          FormNote(l10n.currencyDecimalsLocked),
        ] else ...[
          FormLabel(l10n.currencyDecimals),
          SegmentedButton<int>(
            segments: [
              for (var d = 0; d <= CurrencyRules.maxDecimals; d++)
                ButtonSegment(value: d, label: Text('$d')),
            ],
            selected: {state.decimals},
            onSelectionChanged: (value) => cubit.decimalsChanged(value.single),
          ),
          FormNote(l10n.currencyDecimalsWarning, isWarning: true),
        ],
        const SizedBox(height: AppSpacing.lg),
        FormLabel(l10n.currencyThousandsSeparator),
        SegmentedButton<String>(
          segments: [
            for (final separator in CurrencyRules.thousandsSeparators)
              ButtonSegment(
                value: separator,
                label: Text(_separatorLabel(context, separator)),
              ),
          ],
          selected: {state.thousandsSeparator},
          onSelectionChanged: (value) =>
              cubit.thousandsSeparatorChanged(value.single),
        ),
        const SizedBox(height: AppSpacing.md),
        FormLabel(l10n.currencyDecimalSeparator),
        SegmentedButton<String>(
          segments: [
            for (final separator in CurrencyRules.decimalSeparators)
              ButtonSegment(
                value: separator,
                label: Text(_separatorLabel(context, separator)),
              ),
          ],
          selected: {state.decimalSeparator},
          onSelectionChanged: (value) =>
              cubit.decimalSeparatorChanged(value.single),
        ),
        if (errors.contains(CurrencyError.sameSeparators))
          FormNote(l10n.currencyErrorSeparators, isError: true),
        const SizedBox(height: AppSpacing.lg),
        if (format != null)
          Text(
            l10n.currencyPreview(currencyPreview(format)),
            style: context.textTheme.titleMedium,
          ),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: state.status == CurrencyFormStatus.saving
              ? null
              : cubit.submit,
          child: Text(l10n.actionSave),
        ),
        if (lockReason != null) FormNote(lockReason),
      ],
    );
  }

  String? _lockReason(BuildContext context) {
    final original = state.original;
    if (original == null) return null;
    if (original.isBuiltIn) return context.l10n.currencyBuiltInLocked;
    if (state.inUse) return context.l10n.currencyInUseLocked;
    final mainCode = context.select<SettingsCubit, String>(
      (cubit) => cubit.state.settings.mainCurrencyCode,
    );
    return original.code == mainCode ? context.l10n.currencyMainLocked : null;
  }

  static String _separatorLabel(BuildContext context, String separator) =>
      switch (separator) {
        '.' => context.l10n.currencySeparatorDot,
        ',' => context.l10n.currencySeparatorComma,
        ' ' => context.l10n.currencySeparatorSpace,
        '' => context.l10n.currencySeparatorNone,
        _ => separator,
      };
}

class _DeleteButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: l10n.currencyDeleteTooltip,
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () async {
        final cubit = context.read<CurrencyFormCubit>();
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.currencyDeleteTitle(cubit.state.code)),
            content: Text(l10n.currencyDeleteMessage),
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
