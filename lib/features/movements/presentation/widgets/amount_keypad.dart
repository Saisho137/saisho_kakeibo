import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/amount_input.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The keypad of the quick entry with operations (RF-01). Its bottom-left
/// key is `000` for currencies without decimals, or the decimal separator.
class AmountKeypad extends StatelessWidget {
  const new({required this.format, required this.onKey, super.key});

  final CurrencyFormat format;
  final ValueChanged<KeypadKey> onKey;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final extra = format.decimals == 0
        ? (KeypadKey.triple0, '000')
        : (KeypadKey.decimal, format.decimalSeparator);
    final rows = [
      [
        (KeypadKey.d7, '7'),
        (KeypadKey.d8, '8'),
        (KeypadKey.d9, '9'),
        (KeypadKey.divide, '÷'),
      ],
      [
        (KeypadKey.d4, '4'),
        (KeypadKey.d5, '5'),
        (KeypadKey.d6, '6'),
        (KeypadKey.multiply, '×'),
      ],
      [
        (KeypadKey.d1, '1'),
        (KeypadKey.d2, '2'),
        (KeypadKey.d3, '3'),
        (KeypadKey.subtract, '−'),
      ],
      [
        extra,
        (KeypadKey.d0, '0'),
        (KeypadKey.backspace, ''),
        (KeypadKey.add, '+'),
      ],
    ];
    String? semantics(KeypadKey key) => switch (key) {
      KeypadKey.backspace => l10n.keypadBackspace,
      KeypadKey.add => l10n.keypadAdd,
      KeypadKey.subtract => l10n.keypadSubtract,
      KeypadKey.multiply => l10n.keypadMultiply,
      KeypadKey.divide => l10n.keypadDivide,
      _ => null,
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final row in rows)
          Row(
            children: [
              for (final (key, label) in row)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xs),
                    child: Semantics(
                      label: semantics(key),
                      button: true,
                      excludeSemantics: semantics(key) != null,
                      child: _Key(
                        label: label,
                        isOperator: key.isOperator,
                        icon: key == KeypadKey.backspace
                            ? Icons.backspace_outlined
                            : null,
                        onTap: () => onKey(key),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _Key extends StatelessWidget {
  const new({
    required this.label,
    required this.isOperator,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isOperator;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: isOperator
          ? colors.secondaryContainer
          : colors.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.tokens.radiusSmall),
        child: SizedBox(
          height: 52,
          child: Center(
            child: icon == null
                ? Text(label, style: context.textTheme.titleLarge)
                : Icon(icon),
          ),
        ),
      ),
    );
  }
}
