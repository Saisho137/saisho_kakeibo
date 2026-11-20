import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Shows the numbers from [min] to [max] in a calendar-like grid and returns
/// the one picked, or `null` if the dialog is dismissed.
Future<int?> showNumberGridDialog(
  BuildContext context, {
  required String title,
  required int min,
  required int max,
  required int selected,
  String? message,
}) {
  return showDialog<int>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message != null) ...[
              Text(message),
              const SizedBox(height: AppSpacing.md),
            ],
            Flexible(
              child: GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                mainAxisSpacing: AppSpacing.xs,
                crossAxisSpacing: AppSpacing.xs,
                children: [
                  for (var value = min; value <= max; value++)
                    _NumberCell(
                      value: value,
                      isSelected: value == selected,
                      onTap: () => Navigator.of(context).pop(value),
                    ),
                ],
              ),
            ),
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

class _NumberCell extends StatelessWidget {
  const new({
    required this.value,
    required this.isSelected,
    required this.onTap,
  });

  final int value;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.zero;
    final label = Text('$value');
    return isSelected
        ? FilledButton(
            onPressed: onTap,
            style: FilledButton.styleFrom(padding: padding),
            child: label,
          )
        : TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(padding: padding),
            child: label,
          );
  }
}
