import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_router.dart';
import 'package:saisho_kakeibo/core/theme/app_theme.dart';
import 'package:saisho_kakeibo/core/theme/app_theme_mode_x.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

class App extends StatefulWidget {
  const new({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router = createAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..load(),
      child: BlocSelector<SettingsCubit, SettingsState, ThemeMode>(
        selector: (state) => state.settings.themeMode.themeMode,
        builder: (context, themeMode) => MaterialApp.router(
          onGenerateTitle: (context) => context.l10n.appTitle,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
        ),
      ),
    );
  }
}
