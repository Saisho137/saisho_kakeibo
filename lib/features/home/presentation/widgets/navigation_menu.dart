import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// ⋮ panel: the app's screens. Debts, Entities and Recurring join it in
/// their phases.
class NavigationMenu extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    Widget item(IconData icon, String title, String route) => ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        unawaited(context.push(route));
      },
    );
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            item(
              Icons.account_balance_wallet_rounded,
              l10n.accountsTitle,
              AppRoutes.accounts,
            ),
            item(
              Icons.category_rounded,
              l10n.categoriesTitle,
              AppRoutes.categories,
            ),
            item(
              Icons.settings_rounded,
              l10n.settingsTitle,
              AppRoutes.settings,
            ),
          ],
        ),
      ),
    );
  }
}
