import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';

/// A catalog icon as a white glyph on a circle of [color] (RF-07). A
/// [selected] avatar shows a ring around it, as in the pickers.
class CatalogIconAvatar extends StatelessWidget {
  const new({
    required this.iconKey,
    required this.color,
    this.radius = 20,
    this.selected,
    super.key,
  });

  final String iconKey;
  final Color color;
  final double radius;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Icon(
        IconCatalog.resolve(iconKey).icon,
        color: context.tokens.iconGlyph,
        size: radius,
      ),
    );
    final selected = this.selected;
    if (selected == null) return avatar;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? context.colors.onSurface : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(2), child: avatar),
    );
  }
}
