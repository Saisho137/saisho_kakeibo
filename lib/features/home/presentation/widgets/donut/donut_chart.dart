import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/percentages.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_geometry.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_painter.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Home donut (RF-02): a ring of expense categories with their icons
/// outside, hugged by a border per pillar. Tapping a category calls
/// [onCategoryTap]; tapping a pillar border inverts the donut, with the
/// pillars as the wide ring, until the next tap. [center] goes inside.
class DonutChart extends StatefulWidget {
  const new({
    required this.data,
    required this.center,
    this.onCategoryTap,
    super.key,
  });

  final DonutData data;
  final Widget center;
  final ValueChanged<Category>? onCategoryTap;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _inversion = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _inversion,
    curve: Curves.easeInOut,
  );

  bool get _inverted => _inversion.status.isForwardOrCompleted;

  @override
  void dispose() {
    _inversion.dispose();
    super.dispose();
  }

  void _toggle() => _inverted ? _inversion.reverse() : _inversion.forward();

  void _tapped(DonutGeometry geometry, Offset position) {
    final hit = geometry.hitTest(position);
    if (_inverted) {
      if (hit is PillarHit) _toggle();
      return;
    }
    switch (hit) {
      case CategoryHit(:final category):
        widget.onCategoryTap?.call(category.category);
      case PillarHit():
        _toggle();
      case CenterHit() || null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);
        return Center(
          child: SizedBox.square(
            dimension: size,
            child: AnimatedBuilder(
              animation: _curve,
              builder: (context, _) {
                final geometry = DonutGeometry(
                  data: widget.data,
                  size: size,
                  ringWidth: tokens.donutRingWidth,
                  borderWidth: tokens.pillarBorderWidth,
                  borderHitWidth: tokens.pillarBorderHitWidth,
                  inverted: _curve.value,
                );
                final centerSide = geometry.innerRadius * sqrt2;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapUp: (details) =>
                      _tapped(geometry, details.localPosition),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: DonutPainter(
                            geometry: geometry,
                            neutral: tokens.neutral,
                          ),
                        ),
                      ),
                      ..._labels(context, geometry),
                      Center(
                        child: SizedBox.square(
                          dimension: max(centerSide, 0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: widget.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Category icons with their percentage, or the pillar names once
  /// inverted. Sections under 3 % have none.
  List<Widget> _labels(BuildContext context, DonutGeometry geometry) {
    const side = 44.0;
    Widget at(double angle, Widget child, Key key) {
      final point = geometry.pointAt(angle, geometry.labelRadius);
      return Positioned(
        key: key,
        left: point.dx - side,
        top: point.dy - side / 2,
        width: side * 2,
        height: side,
        // Category labels fade out as the pillar labels fade in.
        child: Opacity(
          opacity: (2 * _curve.value - 1).abs().clamp(0, 1).toDouble(),
          child: Center(child: child),
        ),
      );
    }

    final textStyle = context.textTheme.labelSmall;
    if (_curve.value < 0.5) {
      final arcs = geometry.categoryArcs;
      final percents = roundPercents([for (final a in arcs) a.item.share]);
      return [
        for (final (index, arc) in arcs.indexed)
          if (arc.item.share >= DonutGeometry.minLabeledShare)
            at(
              arc.middle,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CatalogIconAvatar(
                    iconKey: arc.item.category.iconKey,
                    color: Color(arc.item.category.color),
                    radius: 12,
                  ),
                  Text('${percents[index]}%', style: textStyle),
                ],
              ),
              ValueKey('donut-category-${arc.item.category.id}'),
            ),
      ];
    }
    final arcs = geometry.pillarArcs;
    final percents = roundPercents([for (final a in arcs) a.item.share]);
    return [
      for (final (index, arc) in arcs.indexed)
        if (arc.item.share >= DonutGeometry.minLabeledShare)
          at(
            arc.middle,
            Text(
              '${arc.item.pillar?.name ?? context.l10n.donutNoPillar}\n'
              '${percents[index]}%',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
            ValueKey('donut-pillar-${arc.item.pillar?.id}'),
          ),
    ];
  }
}
