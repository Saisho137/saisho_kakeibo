import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/home/domain/services/donut_data.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/donut/donut_chart.dart';

import '../../../../helpers/category_fixtures.dart';
import '../../../../helpers/helpers.dart';

void main() {
  final food = category(id: 1, name: 'Food', iconKey: 'restaurant');
  final movies = category(id: 2, pillarId: leisure.id);
  final tiny = category(id: 3, pillarId: leisure.id);
  DonutCategory slice(Category c, int amount) =>
      DonutCategory(category: c, amount: amount, share: amount / 100);
  final data = DonutData(
    total: 100,
    pillars: [
      DonutPillar(
        pillar: survival,
        amount: 70,
        share: 0.7,
        categories: [slice(food, 70)],
      ),
      DonutPillar(
        pillar: leisure,
        amount: 28,
        share: 0.28,
        categories: [slice(movies, 26), slice(tiny, 2)],
      ),
      DonutPillar(
        pillar: null,
        amount: 2,
        share: 0.02,
        categories: [slice(category(id: 4), 2)],
      ),
    ],
  );

  Future<List<Category>> pump(WidgetTester tester, DonutData donut) async {
    final tapped = <Category>[];
    tester.view.physicalSize = const Size(1200, 1200);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpApp(
      Scaffold(
        body: DonutChart(
          data: donut,
          center: const Text('center'),
          onCategoryTap: (section) => tapped.add(section.category),
        ),
      ),
    );
    return tapped;
  }

  /// A point of the 400 donut at [radius] and [angle] (clockwise from 12).
  Offset at(WidgetTester tester, double angle, double radius) =>
      tester.getCenter(find.byType(DonutChart)) +
      Offset(radius * sin(angle), -radius * cos(angle));

  group('DonutChart', () {
    testWidgets('labels the categories of 3 % or more', (tester) async {
      await pump(tester, data);

      expect(find.text('center'), findsOneWidget);
      expect(find.byKey(const ValueKey('donut-category-1')), findsOneWidget);
      expect(find.text('70%'), findsOneWidget);
      expect(find.text('26%'), findsOneWidget);
      expect(find.byKey(const ValueKey('donut-category-3')), findsNothing);
    });

    testWidgets('tapping a category reports it', (tester) async {
      final tapped = await pump(tester, data);

      // The ring's middle sits at 128 in a 400 donut.
      await tester.tapAt(at(tester, pi / 2, 128));
      await tester.tapAt(at(tester, 0.01, 30));

      expect(tapped, [food]);
    });

    testWidgets('a pillar inverts the donut until the next tap', (
      tester,
    ) async {
      final tapped = await pump(tester, data);

      await tester.tapAt(at(tester, pi / 2, 160));
      await tester.pumpAndSettle();
      expect(find.text('Survival\n70%'), findsOneWidget);
      expect(find.text('Leisure\n28%'), findsOneWidget);
      expect(find.textContaining('No pillar'), findsNothing);
      expect(find.text('70%'), findsNothing);

      // Inverted, a tap on a category goes to its pillar and turns back.
      await tester.tapAt(at(tester, pi / 2, 128));
      await tester.pumpAndSettle();
      expect(tapped, isEmpty);
      expect(find.text('70%'), findsOneWidget);
    });

    testWidgets('the center and the empty donut ignore taps', (tester) async {
      final tapped = await pump(tester, const DonutData(total: 0, pillars: []));

      await tester.tapAt(at(tester, 1, 128));
      await tester.tapAt(at(tester, 1, 10));
      await tester.pumpAndSettle();

      expect(tapped, isEmpty);
      expect(find.textContaining('%'), findsNothing);
    });

    testWidgets('No pillar shows its name when large enough', (tester) async {
      await pump(
        tester,
        DonutData(
          total: 10,
          pillars: [
            DonutPillar(
              pillar: null,
              amount: 10,
              share: 1,
              categories: [DonutCategory(category: food, amount: 10, share: 1)],
            ),
          ],
        ),
      );

      await tester.tapAt(at(tester, 1, 160));
      await tester.pumpAndSettle();
      expect(find.text('No pillar\n100%'), findsOneWidget);
    });
  });
}
