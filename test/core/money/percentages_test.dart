import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/money/percentages.dart';

void main() {
  group('roundPercents', () {
    test('adds up to 100 by giving the points to the largest rests', () {
      expect(roundPercents([0.625, 0.375]), [63, 37]);
      expect(roundPercents([1 / 3, 1 / 3, 1 / 3]), [34, 33, 33]);
      expect(roundPercents([0.505, 0.485, 0.01]), [51, 48, 1]);
    });

    test('keeps exact values and handles nothing', () {
      expect(roundPercents([0.5, 0.25, 0.25]), [50, 25, 25]);
      expect(roundPercents([1]), [100]);
      expect(roundPercents([]), isEmpty);
    });
  });
}
