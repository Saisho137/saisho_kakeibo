import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/text/text_normalizer.dart';

void main() {
  group('TextNormalizer.display', () {
    test('trims and collapses whitespace', () {
      expect(
        TextNormalizer.display('  Crepes &   Waffles \n'),
        'Crepes & Waffles',
      );
    });

    test('capitalizes only the first letter and keeps the rest', () {
      expect(TextNormalizer.display('barbería'), 'Barbería');
      expect(TextNormalizer.display('peaje Palmas'), 'Peaje Palmas');
      expect(TextNormalizer.display('interest & fees'), 'Interest & fees');
      expect(TextNormalizer.display('éxito'), 'Éxito');
    });

    test('returns an empty string for blank input', () {
      expect(TextNormalizer.display('   '), '');
    });
  });

  group('TextNormalizer.key', () {
    test('lowercases and strips diacritics', () {
      expect(TextNormalizer.key('Barbería'), 'barberia');
      expect(TextNormalizer.key('ÁÉÍÓÚ Ñandú Ünico Ça'), 'aeiounanduunicoca');
    });

    test('strips decomposed accents', () {
      expect(TextNormalizer.key('Cafe\u0301'), 'cafe');
    });

    test('removes leading, inner and trailing whitespace', () {
      expect(TextNormalizer.key('  Peaje   Palmas\t'), 'peajepalmas');
    });

    test('matches spellings that differ only in spaces, case or accents', () {
      expect(
        TextNormalizer.key('Peaje Palmas'),
        TextNormalizer.key('PEAJEPALMAS'),
      );
      expect(TextNormalizer.key('Café'), TextNormalizer.key('cafe'));
    });

    test('keeps symbols and digits', () {
      expect(TextNormalizer.key('Crepes & Waffles 2'), 'crepes&waffles2');
    });
  });
}
