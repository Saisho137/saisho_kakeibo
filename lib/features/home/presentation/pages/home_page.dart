import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Placeholder entry screen until the Home feature is implemented.
class HomePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.l10n.appTitle,
          style: context.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
