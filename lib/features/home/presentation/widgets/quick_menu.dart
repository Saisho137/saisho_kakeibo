import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/theme/app_spacing.dart';
import 'package:saisho_kakeibo/features/home/presentation/cubit/home_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// ☰ panel: switches the period type, the active currency, the Balance
/// filter and the theme. Creating or configuring happens in Settings.
class QuickMenu extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.select<SettingsCubit, AppSettings>(
      (cubit) => cubit.state.settings,
    );
    final home = context.watch<HomeCubit>().state;
    final settingsCubit = context.read<SettingsCubit>();
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            _Group<PeriodType>(
              title: l10n.quickMenuPeriod,
              selected: settings.periodType,
              options: {
                PeriodType.dynamic: l10n.periodTypeDynamic,
                PeriodType.monthly: l10n.periodTypeMonthly,
                PeriodType.yearly: l10n.periodTypeYearly,
              },
              onSelected: (type) =>
                  settingsCubit.update((s) => s.copyWith(periodType: type)),
            ),
            if (home.currencyCode case final code?)
              _Group<String>(
                title: l10n.quickMenuCurrency,
                selected: code,
                options: {
                  for (final currency in home.currencyOptions)
                    currency.code: currency.code,
                },
                onSelected: context.read<HomeCubit>().currencySelected,
              ),
            _Group<BalanceFilter>(
              title: l10n.quickMenuBalance,
              selected: settings.balanceFilter,
              options: {
                BalanceFilter.cash: l10n.balanceFilterCash,
                BalanceFilter.bank: l10n.balanceFilterBank,
                BalanceFilter.both: l10n.balanceFilterBoth,
              },
              onSelected: (filter) => settingsCubit.update(
                (s) => s.copyWith(balanceFilter: filter),
              ),
            ),
            _Group<AppThemeMode>(
              title: l10n.quickMenuTheme,
              selected: settings.themeMode,
              options: {
                AppThemeMode.system: l10n.themeSystem,
                AppThemeMode.light: l10n.themeLight,
                AppThemeMode.dark: l10n.themeDark,
              },
              onSelected: (mode) =>
                  settingsCubit.update((s) => s.copyWith(themeMode: mode)),
            ),
          ],
        ),
      ),
    );
  }
}

/// A full-width segmented button under a small title.
class _Group<T extends Object> extends StatelessWidget {
  const new({
    required this.title,
    required this.selected,
    required this.options,
    required this.onSelected,
  });

  final String title;
  final T selected;
  final Map<T, String> options;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SegmentedButton<T>(
            showSelectedIcon: false,
            segments: [
              for (final MapEntry(:key, :value) in options.entries)
                ButtonSegment(value: key, label: Text(value)),
            ],
            selected: {selected},
            onSelectionChanged: (values) => onSelected(values.single),
          ),
        ],
      ),
    );
  }
}
