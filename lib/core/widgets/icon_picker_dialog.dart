import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Shows the icon catalog by group and returns the icon picked, or `null`
/// if the dialog is dismissed.
Future<CatalogIcon?> showIconPickerDialog(
  BuildContext context, {
  required String selectedKey,
}) {
  return showDialog<CatalogIcon>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.iconPickerTitle),
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final group in IconGroup.values)
              if (IconCatalog.inGroup(group) case final icons
                  when icons.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.md,
                    AppSpacing.lg,
                    AppSpacing.sm,
                  ),
                  child: Text(
                    _groupName(context, group),
                    style: context.textTheme.labelLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final icon in icons)
                        _IconOption(
                          icon: icon,
                          isSelected: icon.key == selectedKey,
                        ),
                    ],
                  ),
                ),
              ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.actionCancel),
        ),
      ],
    ),
  );
}

String _groupName(BuildContext context, IconGroup group) {
  final l10n = context.l10n;
  return switch (group) {
    IconGroup.food => l10n.iconGroupFood,
    IconGroup.transport => l10n.iconGroupTransport,
    IconGroup.home => l10n.iconGroupHome,
    IconGroup.health => l10n.iconGroupHealth,
    IconGroup.shopping => l10n.iconGroupShopping,
    IconGroup.leisure => l10n.iconGroupLeisure,
    IconGroup.education => l10n.iconGroupEducation,
    IconGroup.finance => l10n.iconGroupFinance,
    IconGroup.people => l10n.iconGroupPeople,
    IconGroup.other => l10n.iconGroupOther,
  };
}

class _IconOption extends StatelessWidget {
  const new({required this.icon, required this.isSelected});

  final CatalogIcon icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: icon.key,
      child: InkResponse(
        onTap: () => Navigator.of(context).pop(icon),
        child: CatalogIconAvatar(
          iconKey: icon.key,
          color: icon.color,
          selected: isSelected,
        ),
      ),
    );
  }
}
