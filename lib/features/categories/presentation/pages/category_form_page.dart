import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/core/widgets/color_picker_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/core/widgets/icon_picker_dialog.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/category_rules.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/category_form_cubit.dart';
import 'package:saisho_kakeibo/features/categories/presentation/widgets/category_names.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Creates a custom category of [type], or edits the one with [id].
class CategoryFormPage extends StatelessWidget {
  const new({this.id, this.type = CategoryType.expense, super.key});

  final int? id;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<CategoryFormCubit>();
        unawaited(cubit.load(type: type, id: id));
        return cubit;
      },
      child: const CategoryFormView(),
    );
  }
}

class CategoryFormView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryFormCubit, CategoryFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status
                case CategoryFormStatus.saved || CategoryFormStatus.deleted) {
              context.pop();
            }
          },
        ),
        BlocListener<CategoryFormCubit, CategoryFormState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.genericError))),
        ),
      ],
      child: BlocBuilder<CategoryFormCubit, CategoryFormState>(
        builder: (context, state) {
          final original = state.original;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                original == null
                    ? l10n.categoryNewTitle
                    : l10n.categoryEditTitle(original.name),
              ),
              actions: [
                if (state.canArchive && original != null)
                  _ArchiveButton(archived: original.isArchived),
                if (state.canDelete) const _DeleteButton(),
              ],
            ),
            body: switch (state.status) {
              CategoryFormStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
              CategoryFormStatus.notFound => Center(
                child: Text(l10n.categoryNotFound),
              ),
              _ => _CategoryForm(state: state),
            },
          );
        },
      ),
    );
  }
}

class _CategoryForm extends StatelessWidget {
  const new({required this.state});

  final CategoryFormState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<CategoryFormCubit>();
    final errors = state.errors;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        if (state.isEditing) ...[
          ReadOnlyField(
            label: l10n.categoryType,
            value: state.type.label(context),
          ),
          FormNote(l10n.categoryTypeLocked),
        ] else ...[
          FormLabel(l10n.categoryType),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final option in categoryTabs)
                ChoiceChip(
                  label: Text(option.label(context)),
                  selected: option == state.type,
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
              message: l10n.categoryIconTooltip,
              child: InkResponse(
                onTap: () async {
                  final icon = await showIconPickerDialog(
                    context,
                    selectedKey: state.iconKey,
                  );
                  if (icon != null) cubit.iconChanged(icon.key);
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
              // A new key after Reset to default refills the field.
              child: TextFormField(
                key: ValueKey(state.resets),
                initialValue: state.name,
                onChanged: cubit.nameChanged,
                textCapitalization: TextCapitalization.sentences,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(CategoryRules.maxNameLength),
                ],
                decoration: InputDecoration(
                  labelText: l10n.categoryName,
                  errorText: errors.contains(CategoryError.emptyName)
                      ? l10n.categoryErrorName
                      : errors.contains(CategoryError.duplicateName)
                      ? l10n.categoryErrorDuplicate(
                          state.type.label(context).toLowerCase(),
                        )
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
            child: Text(l10n.categoryChangeColor),
          ),
        ),
        if (state.hasPillar) ...[
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<int>(
            initialValue: state.pillarId,
            items: [
              for (final pillar in state.pillars)
                DropdownMenuItem(
                  value: pillar.id,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 6,
                        backgroundColor: Color(pillar.color),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(pillar.name),
                    ],
                  ),
                ),
            ],
            onChanged: (id) {
              if (id != null) cubit.pillarChanged(id);
            },
            decoration: InputDecoration(
              labelText: l10n.categoryPillar,
              errorText: errors.contains(CategoryError.missingPillar)
                  ? l10n.categoryErrorPillar
                  : null,
            ),
          ),
        ],
        if (_pillarNote(context) case final note?) FormNote(note),
        if (state.isCore) ...[
          FormNote(l10n.categoryCoreHint),
          if (state.canReset)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                onPressed: cubit.resetToDefault,
                icon: const Icon(Icons.restart_alt_rounded),
                label: Text(l10n.categoryReset),
              ),
            ),
        ],
        if (state.original?.isArchived ?? false)
          FormNote(l10n.categoryArchivedHint, isWarning: true),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: state.status == CategoryFormStatus.saving
              ? null
              : cubit.submit,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }

  String? _pillarNote(BuildContext context) => switch (state.role) {
    CategoryRole.debtPayment => context.l10n.categoryDebtPillarHint,
    CategoryRole.loanGiven ||
    CategoryRole.uncategorized => context.l10n.categoryNoPillarHint,
    _ => null,
  };
}

class _ArchiveButton extends StatelessWidget {
  const new({required this.archived});

  final bool archived;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return IconButton(
      tooltip: archived
          ? l10n.categoryUnarchiveTooltip
          : l10n.categoryArchiveTooltip,
      icon: Icon(archived ? Icons.unarchive_outlined : Icons.archive_outlined),
      onPressed: () =>
          context.read<CategoryFormCubit>().setArchived(archived: !archived),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.l10n.categoryDeleteTooltip,
      icon: const Icon(Icons.delete_outline_rounded),
      onPressed: () async {
        final cubit = context.read<CategoryFormCubit>();
        final state = cubit.state;
        final confirmed = await showDialog<_DeleteChoice>(
          context: context,
          builder: (_) => _DeleteDialog(state: state),
        );
        if (confirmed != null) {
          await cubit.delete(reassignTo: confirmed.reassignTo);
        }
      },
    );
  }
}

final class _DeleteChoice {
  const new(this.reassignTo);

  final int? reassignTo;
}

/// Confirms the delete. With movements, it asks which category receives
/// them, so deleting also merges (RF-13).
class _DeleteDialog extends StatefulWidget {
  const new({required this.state});

  final CategoryFormState state;

  @override
  State<_DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<_DeleteDialog> {
  late int? _target = widget.state.defaultDeleteTarget?.id;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = widget.state;
    final count = state.movementCount;
    final ready = count == 0 || _target != null;
    return AlertDialog(
      title: Text(l10n.categoryDeleteTitle(state.original!.name)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count == 0
                ? l10n.categoryDeleteNoMovements
                : l10n.categoryDeleteMovements(count),
          ),
          if (count > 0) ...[
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<int>(
              initialValue: _target,
              isExpanded: true,
              items: [
                for (final target in state.deleteTargets)
                  DropdownMenuItem(value: target.id, child: Text(target.name)),
              ],
              onChanged: (id) => setState(() => _target = id),
              decoration: InputDecoration(labelText: l10n.categoryDeleteTarget),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: ready
              ? () =>
                    Navigator.of(context)
                        .pop(_DeleteChoice(count == 0 ? null : _target))
              : null,
          style: TextButton.styleFrom(foregroundColor: context.colors.error),
          child: Text(l10n.actionDelete),
        ),
      ],
    );
  }
}
