import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';

void main() {
  group('IconCatalog', () {
    test('has unique keys', () {
      final keys = IconCatalog.all.map((icon) => icon.key).toList();

      expect(keys.toSet(), hasLength(keys.length));
    });

    test('every group has icons', () {
      for (final group in IconGroup.values) {
        expect(IconCatalog.inGroup(group), isNotEmpty, reason: group.name);
      }
    });

    test('groups list icons in catalog order', () {
      final food = IconCatalog.inGroup(IconGroup.food);

      expect(food.first.key, 'restaurant');
      expect(food.every((icon) => icon.group == IconGroup.food), isTrue);
    });

    test('resolves a known key', () {
      final icon = IconCatalog.resolve('restaurant');

      expect(icon.key, 'restaurant');
      expect(IconCatalog.contains('restaurant'), isTrue);
    });

    test('falls back for unknown keys', () {
      expect(IconCatalog.contains('unknown'), isFalse);
      expect(IconCatalog.resolve('unknown').key, IconCatalog.fallbackKey);
    });

    test('suggested colors are opaque', () {
      for (final icon in IconCatalog.all) {
        expect(icon.color.a, 1, reason: icon.key);
      }
    });
  });
}
