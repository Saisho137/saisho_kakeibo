import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Balance as a solid brand pill with dark ink, the currency code
/// small (RF-17): on the Home, where it opens the history, and atop the
/// history, where it closes it.
class BalancePill extends StatelessWidget {
  const new({
    required this.balance,
    required this.currency,
    required this.tooltip,
    required this.onTap,
    super.key,
  });

  final Money balance;
  final Currency currency;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    final textTheme = context.textTheme;
    final ink = tokens.onBrand;
    final radius = BorderRadius.circular(tokens.radiusSmall);
    return Tooltip(
      message: tooltip,
      child: Material(
        color: tokens.brand,
        elevation: 2,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: kMinInteractiveDimension,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Center(
                widthFactor: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '${l10n.homeBalance} '),
                        TextSpan(
                          text: '${currency.code} ',
                          style: textTheme.labelMedium?.copyWith(color: ink),
                        ),
                        TextSpan(
                          text: MoneyFormatter.format(balance, currency.format),
                          style: textTheme.titleLarge?.copyWith(color: ink),
                        ),
                      ],
                    ),
                    style: textTheme.titleMedium?.copyWith(color: ink),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Three lines beside the Balance that hint it can be pulled up.
class BalanceGrip extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.tokens.brand;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              height: 2,
              margin: const EdgeInsets.symmetric(vertical: 3),
              color: color,
            ),
        ],
      ),
    );
  }
}
