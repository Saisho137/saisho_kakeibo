import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The "COP ▾" picker of the screens that show one currency at a time. It
/// keeps a 48 × 48 touch target (accessibility).
class CurrencyMenuButton extends StatelessWidget {
  const new({
    required this.selected,
    required this.currencies,
    required this.onSelected,
    super.key,
  });

  /// Code of the shown currency.
  final String selected;
  final List<Currency> currencies;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: context.l10n.currencyMenuTooltip,
      initialValue: selected,
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final c in currencies)
          PopupMenuItem(value: c.code, child: Text(c.code)),
      ],
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: kMinInteractiveDimension,
          minHeight: kMinInteractiveDimension,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(selected),
              const Icon(Icons.arrow_drop_down_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
