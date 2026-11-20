/// Normalizes user-entered names (RF-07, RT-08).
///
/// Every normalized text keeps two values: [display], what the user sees,
/// and [key], what is compared to avoid duplicates.
abstract final class TextNormalizer {
  static final RegExp _whitespace = RegExp(r'\s+');

  /// Trims, collapses inner whitespace and capitalizes the first letter,
  /// keeping the rest as typed: `'  crepes &   Waffles '` → `'Crepes &
  /// Waffles'`.
  static String display(String text) {
    final collapsed = text.trim().replaceAll(_whitespace, ' ');
    if (collapsed.isEmpty) return collapsed;
    return collapsed[0].toUpperCase() + collapsed.substring(1);
  }

  /// Removes every whitespace, strips diacritics and lowercases:
  /// `' Barbería  El Paso '` → `'barberiaelpaso'`.
  static String key(String text) {
    final buffer = StringBuffer();
    for (final rune in text.toLowerCase().replaceAll(_whitespace, '').runes) {
      if (_isCombiningMark(rune)) continue;
      final char = String.fromCharCode(rune);
      buffer.write(_diacritics[char] ?? char);
    }
    return buffer.toString();
  }

  // Accents typed or pasted as a separate code point (`e` + U+0301).
  static bool _isCombiningMark(int rune) => rune >= 0x0300 && rune <= 0x036F;

  // Lowercase Latin letters with diacritics and their base letter.
  static const Map<String, String> _diacritics = {
    'á': 'a', 'à': 'a', 'â': 'a', 'ä': 'a', 'ã': 'a', 'å': 'a', //
    'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e', //
    'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i', //
    'ó': 'o', 'ò': 'o', 'ô': 'o', 'ö': 'o', 'õ': 'o', //
    'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u', //
    'ñ': 'n', 'ç': 'c', 'ý': 'y', 'ÿ': 'y', //
  };
}
