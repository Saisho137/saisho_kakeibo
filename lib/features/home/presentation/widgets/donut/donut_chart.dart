import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/percentages.dart';
import 'package:saisho_kakeibo/core/theme/app_tokens.dart';
import 'package:saisho_kakeibo/core/widgets/catalog_icon_avatar.dart';
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

  /// A category section, or a debt's section of its payments.
  final ValueChanged<DonutCategory>? onCategoryTap;

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
        widget.onCategoryTap?.call(category);
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
                // A box inside the hole, taller than wide: the center is a
                // column (the totals), which gets more room than in the
                // inscribed square.
                final hole = max(geometry.innerRadius, 0);
                final centerHeight = hole * 1.5;
                final centerWidth = sqrt(
                  4 * hole * hole - pow(centerHeight, 2),
                );
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
                      // The icons and percentages are drawn; screen readers
                      // get one button per section instead.
                      ExcludeSemantics(
                        child: Stack(children: _labels(context, geometry)),
                      ),
                      ..._semantics(context, geometry),
                      Center(
                        child: SizedBox(
                          width: centerWidth,
                          height: centerHeight,
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

  /// A button per section for screen readers (accessibility), small ones
  /// too: categories, which start an expense, and pillars, which invert
  /// the donut. Once inverted, only the pillars.
  List<Widget> _semantics(BuildContext context, DonutGeometry geometry) {
    final l10n = context.l10n;
    const side = 24.0;
    Widget at(double angle, double radius, Widget child) {
      final point = geometry.pointAt(angle, radius);
      return Positioned(
        left: point.dx - side / 2,
        top: point.dy - side / 2,
        width: side,
        height: side,
        child: child,
      );
    }

    final inverted = _curve.value >= 0.5;
    final categories = geometry.categoryArcs;
    final categoryPercents = roundPercents([
      for (final a in categories) a.item.share,
    ]);
    final pillars = geometry.pillarArcs;
    final pillarPercents = roundPercents([
      for (final a in pillars) a.item.share,
    ]);
    return [
      if (!inverted)
        for (final (index, arc) in categories.indexed)
          at(
            arc.middle,
            geometry.categoryRadius,
            Semantics(
              button: true,
              label: l10n.donutSectionSemantics(
                arc.item.name,
                categoryPercents[index],
              ),
              onTapHint: l10n.donutNewExpenseHint,
              onTap: widget.onCategoryTap == null
                  ? null
                  : () => widget.onCategoryTap!(arc.item),
              child: const SizedBox.expand(),
            ),
          ),
      for (final (index, arc) in pillars.indexed)
        at(
          arc.middle,
          geometry.pillarRadius,
          Semantics(
            button: true,
            label: l10n.donutSectionSemantics(
              arc.item.pillar?.name ?? l10n.donutNoPillar,
              pillarPercents[index],
            ),
            onTapHint: inverted
                ? l10n.donutShowCategoriesHint
                : l10n.donutShowPillarsHint,
            onTap: _toggle,
            child: const SizedBox.expand(),
          ),
        ),
    ];
  }

  /// Category icons with their percentage, or the pillar names once
  /// inverted. Sections under 3 % have none.
  List<Widget> _labels(BuildContext context, DonutGeometry geometry) {
    const side = 52.0;
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
                    iconKey: arc.item.iconKey,
                    color: Color(arc.item.color),
                    radius: 16,
                  ),
                  Text(
                    '${percents[index]}%',
                    style: textStyle?.copyWith(
                      color: AppTokens.readable(
                        Color(arc.item.color),
                        on: context.colors.surface,
                        min: AppTokens.minTextContrast,
                      ),
                    ),
                  ),
                ],
              ),
              ValueKey(
                'donut-category-${arc.item.category.id}'
                '${arc.item.debt == null ? '' : '-${arc.item.debt!.id}'}',
              ),
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
