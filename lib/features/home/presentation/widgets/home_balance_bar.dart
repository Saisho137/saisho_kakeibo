import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Balance, with the currency code small and subtle, above the
/// Expense, Transfer and Income buttons (RF-17).
class HomeBalanceBar extends StatelessWidget {
  const new({required this.balance, required this.currency, super.key});

  final Money balance;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    final textTheme = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: '${l10n.homeBalance} '),
                TextSpan(
                  text: '${currency.code} ',
                  style: textTheme.labelMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                TextSpan(
                  text: MoneyFormatter.format(balance, currency.format),
                  style: textTheme.titleLarge,
                ),
              ],
            ),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: tokens.expense,
                  ),
                  icon: const Icon(Icons.remove_rounded),
                  label: Text(l10n.homeNewExpense),
                  onPressed: () =>
                      context.push(AppRoutes.entry(MovementType.expense)),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              IconButton.outlined(
                tooltip: l10n.homeNewTransfer,
                icon: const Icon(Icons.swap_horiz_rounded),
                onPressed: () => context.push(AppRoutes.newTransfer()),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: tokens.income),
                  icon: const Icon(Icons.add_rounded),
                  label: Text(l10n.homeNewIncome),
                  onPressed: () =>
                      context.push(AppRoutes.entry(MovementType.income)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
