import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Shows the catalog palette with [iconKey] on each color and returns the
/// color picked, or `null` if the dialog is dismissed.
Future<Color?> showColorPickerDialog(
  BuildContext context, {
  required String iconKey,
  required Color selected,
}) {
  return showDialog<Color>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.l10n.colorPickerTitle),
      content: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          for (final color in IconCatalog.palette)
            Semantics(
              button: true,
              selected: color == selected,
              child: InkResponse(
                onTap: () => Navigator.of(context).pop(color),
                child: CatalogIconAvatar(
                  iconKey: iconKey,
                  color: color,
                  selected: color == selected,
                ),
              ),
            ),
        ],
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
