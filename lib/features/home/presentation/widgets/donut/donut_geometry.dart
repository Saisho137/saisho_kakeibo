import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';

/// An arc of the donut, in radians clockwise from 12 o'clock.
@immutable
final class DonutArc<T> {
  const new({required this.item, required this.start, required this.sweep});

  final T item;
  final double start;
  final double sweep;

  double get end => start + sweep;

  double get middle => start + sweep / 2;

  bool contains(double angle) => angle >= start && angle < end;
}

/// What a tap on the donut hit.
sealed class DonutHit {
  const new();
}

final class CategoryHit extends DonutHit {
  const new(this.category);

  final DonutCategory category;
}

final class PillarHit extends DonutHit {
  const new(this.pillar);

  final DonutPillar pillar;
}

final class CenterHit extends DonutHit {
  const new();
}

/// Where the donut's parts go in a square of [size]: the category ring
/// inside, the pillar border hugging it from outside, and room for the
/// icons around. [inverted] (0 to 1, animated) swaps their widths: the
/// pillars become the wide ring and the categories a thin strip (RF-02).
@immutable
final class DonutGeometry {
  new({
    required this.data,
    required this.size,
    required this.ringWidth,
    required this.borderWidth,
    required this.borderHitWidth,
    this.inverted = 0,
    this.iconSpace = 44,
  }) : categoryArcs = _arcs([
         for (final pillar in data.pillars)
           for (final category in pillar.categories) (category, category.share),
       ]),
       pillarArcs = _arcs([
         for (final pillar in data.pillars) (pillar, pillar.share),
       ]);

  final DonutData data;
  final double size;
  final double ringWidth;
  final double borderWidth;

  /// Width of the touch band of the pillar border, wider than the border.
  final double borderHitWidth;
  final double inverted;

  /// Room left outside the border for the icons.
  final double iconSpace;

  final List<DonutArc<DonutCategory>> categoryArcs;
  final List<DonutArc<DonutPillar>> pillarArcs;

  /// Sections under 3 % show no icon nor percentage.
  static const double minLabeledShare = 0.03;

  Offset get center => Offset(size / 2, size / 2);

  double get _categoryWidth => ringWidth + (borderWidth - ringWidth) * inverted;

  double get _pillarWidth => borderWidth + (ringWidth - borderWidth) * inverted;

  /// Outer edge of the pillar border.
  double get outerRadius => size / 2 - iconSpace;

  /// Space between the category ring and the pillar border, so a border
  /// stands out from a category of its same color.
  static const double separation = 2;

  /// Outer edge of the category ring.
  double get ringOuterRadius => outerRadius - _pillarWidth - separation;

  double get innerRadius => ringOuterRadius - _categoryWidth;

  /// Center line of the category ring, for drawing its stroke.
  double get categoryRadius => ringOuterRadius - _categoryWidth / 2;

  double get categoryStroke => _categoryWidth;

  double get pillarRadius => outerRadius - _pillarWidth / 2;

  double get pillarStroke => _pillarWidth;

  /// Where an icon or a pillar label sits: outside the border.
  double get labelRadius => outerRadius + iconSpace / 2;

  Offset pointAt(double angle, double radius) =>
      Offset(center.dx + radius * sin(angle), center.dy - radius * cos(angle));

  /// The part of the donut under [position], if any. The pillar border
  /// catches taps from the ring's outer edge across [borderHitWidth]; once
  /// inverted, the whole donut belongs to the pillars.
  DonutHit? hitTest(Offset position) {
    final delta = position - center;
    final distance = delta.distance;
    if (distance < innerRadius) return const CenterHit();
    if (data.isEmpty) return null;
    final angle = (atan2(delta.dx, -delta.dy) + 2 * pi) % (2 * pi);
    final inPillars = inverted >= 0.5
        ? distance <= outerRadius + borderHitWidth / 2
        : distance >= ringOuterRadius &&
              distance <= ringOuterRadius + borderHitWidth;
    if (inPillars) {
      final arc = pillarArcs.where((a) => a.contains(angle)).firstOrNull;
      return arc == null ? null : PillarHit(arc.item);
    }
    if (distance <= ringOuterRadius) {
      final arc = categoryArcs.where((a) => a.contains(angle)).firstOrNull;
      return arc == null ? null : CategoryHit(arc.item);
    }
    return null;
  }

  static List<DonutArc<T>> _arcs<T>(List<(T, double)> items) {
    final arcs = <DonutArc<T>>[];
    var start = 0.0;
    for (final (item, share) in items) {
      final sweep = share * 2 * pi;
      arcs.add(DonutArc(item: item, start: start, sweep: sweep));
      start += sweep;
    }
    return arcs;
  }
}
