import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Placeholder entry screen until the Home feature is implemented. The
/// Accounts and Settings buttons are temporary: phase 6 moves them to the ⋮
/// navigation menu.
class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: context.l10n.accountsOpenTooltip,
            icon: const Icon(Icons.account_balance_wallet_rounded),
            onPressed: () => context.push(AppRoutes.accounts),
          ),
          IconButton(
            tooltip: context.l10n.settingsOpenTooltip,
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.l10n.appTitle,
          style: context.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
