import 'package:saisho_kakeibo/core/text/text_normalizer.dart';

/// The name of a payee as typed, normalized for display and comparison
/// (RF-07, RT-08). `null` when the text is blank.
final class PayeeName {
  const new _(this.name, this.key);

  static PayeeName? parse(String? text) {
    final name = TextNormalizer.display(text ?? '');
    if (name.isEmpty) return null;
    final short = name.length > PayeeRules.maxNameLength
        ? name.substring(0, PayeeRules.maxNameLength).trimRight()
        : name;
    return PayeeName._(short, TextNormalizer.key(short));
  }

  final String name;
  final String key;
}

abstract final class PayeeRules {
  static const int maxNameLength = 40;
}
