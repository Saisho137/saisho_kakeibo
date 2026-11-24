import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/home/presentation/widgets/history_sheet.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Balance as a solid pill between grip lines, with the currency
/// code small, above the Expense, Transfer and Income rings (RF-17).
/// Tapping the Balance or dragging it up opens the history.
class HomeBalanceBar extends StatelessWidget {
  const new({required this.balance, required this.currency, super.key});

  final Money balance;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    // Above the system's gesture bar.
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragEnd: (details) {
              if ((details.primaryVelocity ?? 0) < 0) {
                unawaited(showHistorySheet(context));
              }
            },
            child: Row(
              children: [
                const Expanded(child: _Grip()),
                Flexible(
                  flex: 4,
                  child: _BalancePill(balance: balance, currency: currency),
                ),
                const Expanded(child: _Grip()),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RingButton(
                size: _mainRing,
                color: tokens.expenseAccent,
                icon: Icons.remove_rounded,
                tooltip: l10n.homeNewExpense,
                onPressed: () =>
                    context.push(AppRoutes.entry(MovementType.expense)),
              ),
              _RingButton(
                size: _transferRing,
                color: tokens.transfer,
                icon: Icons.swap_horiz_rounded,
                tooltip: l10n.homeNewTransfer,
                onPressed: () => context.push(AppRoutes.newTransfer()),
              ),
              _RingButton(
                size: _mainRing,
                color: tokens.incomeAccent,
                icon: Icons.add_rounded,
                tooltip: l10n.homeNewIncome,
                onPressed: () =>
                    context.push(AppRoutes.entry(MovementType.income)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const double _mainRing = 96;
  static const double _transferRing = 56;
}

class _BalancePill extends StatelessWidget {
  const new({required this.balance, required this.currency});

  final Money balance;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    final textTheme = context.textTheme;
    final ink = tokens.onBrand;
    final radius = BorderRadius.circular(tokens.radiusSmall);
    return Tooltip(
      message: l10n.homeHistoryTooltip,
      child: Material(
        color: tokens.brand,
        elevation: 2,
        borderRadius: radius,
        child: InkWell(
          onTap: () => showHistorySheet(context),
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
class _Grip extends StatelessWidget {
  const new();

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

/// A round button drawn as a ring, without text: its [tooltip] names it,
/// for screen readers too (accessibility).
class _RingButton extends StatelessWidget {
  const new({
    required this.size,
    required this.color,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final double size;
  final Color color;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        label: tooltip,
        excludeSemantics: true,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: size * 0.06),
            ),
            child: Icon(icon, color: color, size: size * 0.45),
          ),
        ),
      ),
    );
  }
}
