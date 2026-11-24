import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_geometry.dart';

import '../../../../helpers/category_fixtures.dart';

void main() {
  final food = DonutCategory(
    category: category(id: 1),
    amount: 75,
    share: 0.75,
  );
  final movies = DonutCategory(
    category: category(id: 2, pillarId: leisure.id),
    amount: 25,
    share: 0.25,
  );
  final data = DonutData(
    total: 100,
    pillars: [
      DonutPillar(
        pillar: survival,
        amount: 75,
        share: 0.75,
        categories: [food],
      ),
      DonutPillar(
        pillar: leisure,
        amount: 25,
        share: 0.25,
        categories: [movies],
      ),
    ],
  );

  // A 400 square: border from 148 to 156, ring from 110 to 146.
  DonutGeometry geometry({double inverted = 0, DonutData? donut}) =>
      DonutGeometry(
        data: donut ?? data,
        size: 400,
        ringWidth: 36,
        borderWidth: 8,
        borderHitWidth: 32,
        iconSpace: 44,
        inverted: inverted,
      );

  /// The point at [radius] from the center at [angle] (clockwise from 12).
  Offset at(double angle, double radius) => geometry().pointAt(angle, radius);

  group('DonutGeometry', () {
    test('lays out the radii', () {
      final g = geometry();
      expect(g.center, const Offset(200, 200));
      expect(g.outerRadius, 156);
      expect(g.ringOuterRadius, 146);
      expect(g.innerRadius, 110);
      expect(g.categoryRadius, 128);
      expect(g.pillarRadius, 152);
      expect(g.labelRadius, 178);
    });

    test('splits the circle by share, clockwise from 12', () {
      final g = geometry();
      expect(g.categoryArcs.map((a) => a.item), [food, movies]);
      expect(g.categoryArcs.first.start, 0);
      expect(g.categoryArcs.first.sweep, closeTo(1.5 * pi, 1e-9));
      expect(g.categoryArcs.last.middle, closeTo(1.75 * pi, 1e-9));
      expect(g.pillarArcs.map((a) => a.item.pillar), [survival, leisure]);
    });

    test('hits the center, the categories and the wide pillar band', () {
      final g = geometry();
      expect(g.hitTest(at(1, 50)), isA<CenterHit>());
      expect(
        g.hitTest(at(pi / 2, 128)),
        isA<CategoryHit>().having((h) => h.category, 'category', food),
      );
      expect(
        g.hitTest(at(1.8 * pi, 128)),
        isA<CategoryHit>().having((h) => h.category, 'category', movies),
      );
      // The border is 8 wide, but taps 20 outside the ring still count.
      expect(
        g.hitTest(at(pi, 166)),
        isA<PillarHit>().having((h) => h.pillar.pillar, 'pillar', survival),
      );
      expect(g.hitTest(at(pi, 190)), isNull);
    });

    test('once inverted, the pillars take the whole donut', () {
      final g = geometry(inverted: 1);
      expect(g.categoryStroke, 8);
      expect(g.pillarStroke, 36);
      expect(
        g.hitTest(g.pointAt(1.8 * pi, g.categoryRadius)),
        isA<PillarHit>().having((h) => h.pillar.pillar, 'pillar', leisure),
      );
    });

    test('an empty donut only has a center', () {
      final g = geometry(donut: const DonutData(total: 0, pillars: []));
      expect(g.categoryArcs, isEmpty);
      expect(g.hitTest(at(1, 128)), isNull);
      expect(g.hitTest(at(1, 10)), isA<CenterHit>());
    });
  });
}
