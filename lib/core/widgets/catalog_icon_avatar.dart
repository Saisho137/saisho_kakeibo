import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';

/// A catalog icon as a line glyph in its [color], without a filled circle
/// (RF-07): the app's minimalist identity. A light color on a light
/// surface (or a dark one on a dark surface) is deepened just enough to
/// stand out. A [selected] icon shows a ring around it, as in the pickers.
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

  /// Half the square it takes, as a [CircleAvatar]'s.
  final double radius;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    final glyph = SizedBox.square(
      dimension: radius * 2,
      child: Icon(
        IconCatalog.resolve(iconKey).icon,
        color: AppTokens.readable(color, on: context.colors.surface),
        size: radius * 1.5,
      ),
    );
    final selected = this.selected;
    if (selected == null) return glyph;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? context.colors.onSurface : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(2), child: glyph),
    );
  }
}
