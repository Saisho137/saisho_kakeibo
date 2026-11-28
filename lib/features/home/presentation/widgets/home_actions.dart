import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// The Expense, Transfer and Income rings at the foot of the Home, visible
/// with the history open too.
class HomeActions extends StatelessWidget {
  const new({super.key});

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
      child: Row(
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
            onPressed: () => context.push(AppRoutes.entry(MovementType.income)),
          ),
        ],
      ),
    );
  }

  static const double _mainRing = 96;
  static const double _transferRing = 56;
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
