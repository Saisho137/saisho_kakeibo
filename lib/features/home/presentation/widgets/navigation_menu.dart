import 'dart:async';
import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// ⋮ panel: the app's screens, as wide as their names instead of a full
/// drawer's width.
class NavigationMenu extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (
        Icons.account_balance_wallet_outlined,
        l10n.accountsTitle,
        AppRoutes.accounts,
      ),
      (Icons.request_quote_outlined, l10n.debtsTitle, AppRoutes.debts),
      (Icons.storefront_outlined, l10n.payeesTitle, AppRoutes.payees),
      (Icons.category_outlined, l10n.categoriesTitle, AppRoutes.categories),
      (Icons.event_repeat_outlined, l10n.recurringTitle, AppRoutes.recurring),
      (Icons.settings_outlined, l10n.settingsTitle, AppRoutes.settings),
    ];
    return Drawer(
      width: _width(context, [for (final (_, title, _) in items) title]),
      child: SafeArea(
        child: ListView(
          children: [
            for (final (icon, title, route) in items)
              ListTile(
                leading: Icon(icon),
                title: Text(title, maxLines: 1),
                onTap: () {
                  Navigator.of(context).pop();
                  unawaited(context.push(route));
                },
              ),
          ],
        ),
      ),
    );
  }

  /// The widest title as a [ListTile] lays it out (16 padding, a 24 icon,
  /// a 16 gap, the title, 24 padding), never wider than a drawer.
  static double _width(BuildContext context, List<String> titles) {
    final style = context.textTheme.bodyLarge;
    final scaler = MediaQuery.textScalerOf(context);
    var widest = 0.0;
    for (final title in titles) {
      final painter = TextPainter(
        text: TextSpan(text: title, style: style),
        textDirection: Directionality.of(context),
        textScaler: scaler,
        maxLines: 1,
      )..layout();
      widest = max(widest, painter.width);
      painter.dispose();
    }
    return min(16 + 24 + 16 + widest.ceilToDouble() + 24, _drawerWidth);
  }

  static const double _drawerWidth = 304;
}
