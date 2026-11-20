import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/form_parts.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/rules/pillar_rules.dart';
import 'package:saisho_kakeibo/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Lists the pillars of [CategoriesCubit]; tapping one edits it (RF-02).
Future<void> showPillarsDialog(BuildContext context) {
  final cubit = context.read<CategoriesCubit>();
  return showDialog<void>(
    context: context,
    builder: (context) =>
        BlocProvider.value(value: cubit, child: const PillarsDialog()),
  );
}

class PillarsDialog extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pillars = context.select<CategoriesCubit, List<Pillar>>(
      (cubit) => cubit.state.pillars ?? const [],
    );
    return AlertDialog(
      title: Text(l10n.pillarsTitle),
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(l10n.pillarsHint),
          ),
          for (final pillar in pillars)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              leading: CircleAvatar(
                radius: 12,
                backgroundColor: Color(pillar.color),
              ),
              title: Text(pillar.name),
              trailing: const Icon(Icons.edit_outlined),
              onTap: () async {
                final edited = await showDialog<Pillar>(
                  context: context,
                  builder: (_) =>
                      PillarEditDialog(pillar: pillar, pillars: pillars),
                );
                if (edited != null && context.mounted) {
                  await context.read<CategoriesCubit>().updatePillar(edited);
                }
              },
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionClose),
        ),
      ],
    );
  }
}

/// Edits the name and color of [pillar] and returns it, or `null` if
/// cancelled. Colors of the other [pillars] cannot be picked.
class PillarEditDialog extends StatefulWidget {
  const new({required this.pillar, required this.pillars, super.key});

  final Pillar pillar;
  final List<Pillar> pillars;

  @override
  State<PillarEditDialog> createState() => _PillarEditDialogState();
}

class _PillarEditDialogState extends State<PillarEditDialog> {
  late Pillar _pillar = widget.pillar;
  bool _showErrors = false;

  Set<PillarError> get _errors => PillarRules.validate(
    PillarRules.normalize(_pillar),
    pillars: widget.pillars,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final errors = _showErrors ? _errors : const <PillarError>{};
    final taken = {
      for (final p in widget.pillars)
        if (p.id != _pillar.id) p.color,
    };
    return AlertDialog(
      title: Text(l10n.pillarEditTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _pillar.name,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              inputFormatters: [
                LengthLimitingTextInputFormatter(PillarRules.maxNameLength),
              ],
              onChanged: (name) =>
                  setState(() => _pillar = _pillar.copyWith(name: name)),
              decoration: InputDecoration(
                labelText: l10n.pillarName,
                errorText: errors.contains(PillarError.emptyName)
                    ? l10n.pillarErrorName
                    : errors.contains(PillarError.duplicateName)
                    ? l10n.pillarErrorDuplicate
                    : null,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final color in IconCatalog.palette)
                  _Swatch(
                    color: color,
                    selected: color.toARGB32() == _pillar.color,
                    onTap: taken.contains(color.toARGB32())
                        ? null
                        : () => setState(
                            () => _pillar = _pillar.copyWith(
                              color: color.toARGB32(),
                            ),
                          ),
                  ),
              ],
            ),
            FormNote(l10n.pillarColorInUse),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.actionCancel),
        ),
        TextButton(
          onPressed: () {
            if (_errors.isNotEmpty) {
              setState(() => _showErrors = true);
              return;
            }
            Navigator.of(context).pop(PillarRules.normalize(_pillar));
          },
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  const new({required this.color, required this.selected, this.onTap});

  final Color color;
  final bool selected;

  /// `null` when another pillar uses the color.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      selected: selected,
      child: InkResponse(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? context.colors.onSurface : Colors.transparent,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: enabled ? color : color.withValues(alpha: 0.25),
              child: enabled
                  ? null
                  : Icon(
                      Icons.block_rounded,
                      size: 16,
                      color: context.tokens.iconGlyph,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
