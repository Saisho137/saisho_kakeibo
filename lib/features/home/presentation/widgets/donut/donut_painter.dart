import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_geometry.dart';

/// Draws the category ring and the pillar border of [geometry]. An empty
/// period draws a gray ring.
class DonutPainter extends CustomPainter {
  const new({required this.geometry, required this.neutral});

  final DonutGeometry geometry;

  /// Color of the empty ring and of the *No pillar* border.
  final Color neutral;

  /// Space between two category sections, in radians.
  static const double gap = 0.012;

  @override
  void paint(Canvas canvas, Size size) {
    final g = geometry;
    if (g.data.isEmpty) {
      canvas.drawCircle(
        g.center,
        g.categoryRadius,
        _stroke(neutral, g.categoryStroke),
      );
      return;
    }
    for (final arc in g.categoryArcs) {
      _arc(
        canvas,
        arc,
        g.categoryRadius,
        _stroke(Color(arc.item.color), g.categoryStroke),
        gap: g.categoryArcs.length > 1 ? gap : 0,
      );
    }
    for (final arc in g.pillarArcs) {
      final color = arc.item.pillar?.color;
      _arc(
        canvas,
        arc,
        g.pillarRadius,
        _stroke(color == null ? neutral : Color(color), g.pillarStroke),
        gap: 0,
      );
    }
  }

  void _arc(
    Canvas canvas,
    DonutArc<Object> arc,
    double radius,
    Paint paint, {
    required double gap,
  }) {
    final sweep = max(arc.sweep - gap, arc.sweep / 2);
    canvas.drawArc(
      Rect.fromCircle(center: geometry.center, radius: radius),
      arc.start - pi / 2 + (arc.sweep - sweep) / 2,
      sweep,
      false,
      paint,
    );
  }

  static Paint _stroke(Color color, double width) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;

  @override
  bool shouldRepaint(DonutPainter oldDelegate) =>
      oldDelegate.geometry != geometry || oldDelegate.neutral != neutral;
}
