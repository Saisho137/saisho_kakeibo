import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// A category of the Categories screen: icon, name, a lock on core
/// categories and, for expenses, where its pillar comes from.
class CategoryTile extends StatelessWidget {
  const new({
    required this.category,
    required this.pillar,
    required this.onTap,
    super.key,
  });

  final Category category;

  /// Pillar of a custom expense; `null` otherwise.
  final Pillar? pillar;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pillarLabel = _pillarLabel(context);
    return ListTile(
      onTap: onTap,
      leading: CatalogIconAvatar(
        iconKey: category.iconKey,
        color: Color(category.color),
      ),
      title: Row(
        children: [
          Flexible(child: Text(category.name, overflow: TextOverflow.ellipsis)),
          if (category.isCore) ...[
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.lock_rounded,
              size: 16,
              color: context.colors.onSurfaceVariant,
              semanticLabel: l10n.categoryCoreMarker,
            ),
          ],
        ],
      ),
      trailing: pillarLabel == null
          ? null
          : _PillarLabel(
              label: pillarLabel,
              color: switch (pillar) {
                final pillar? => Color(pillar.color),
                null => context.colors.outline,
              },
            ),
    );
  }

  String? _pillarLabel(BuildContext context) {
    if (category.type != CategoryType.expense) return null;
    if (category.role == CategoryRole.debtPayment) {
      return context.l10n.categoryDebtPillar;
    }
    return pillar?.name ?? context.l10n.categoryNoPillar;
  }
}

class _PillarLabel extends StatelessWidget {
  const new({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // At most a third of the row, so large text still leaves room for the
    // name (accessibility).
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width / 3,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: const SizedBox.square(dimension: 10),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              label,
              style: context.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
