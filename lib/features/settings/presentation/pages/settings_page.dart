import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/app/di/injector.dart';
import 'package:saisho_kakeibo/app/router/app_routes.dart';
import 'package:saisho_kakeibo/core/config/app_info.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/widgets/number_grid_dialog.dart';
import 'package:saisho_kakeibo/core/widgets/section_header.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/cubit/accounts_cubit.dart';
import 'package:saisho_kakeibo/features/accounts/presentation/widgets/balance_accounts_section.dart';
import 'package:saisho_kakeibo/features/periods/presentation/cubit/period_starts_cubit.dart';
import 'package:saisho_kakeibo/features/settings/domain/rules/settings_rules.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/currencies_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:saisho_kakeibo/features/settings/presentation/widgets/currency_tile.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Settings screen. The global [SettingsCubit] comes from the app; the
/// currency and account lists and the manual period starts are provided
/// here.
class SettingsPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CurrenciesCubit>()..load()),
        BlocProvider(create: (_) => getIt<PeriodStartsCubit>()..load()),
        BlocProvider(
          create: (context) => getIt<AccountsCubit>()
            ..load(
              context.read<SettingsCubit>().state.settings.mainCurrencyCode,
            ),
        ),
      ],
      child: SettingsView(appInfo: getIt<AppInfo>()),
    );
  }
}

class SettingsView extends StatelessWidget {
  const new({required this.appInfo, super.key});

  final AppInfo appInfo;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void show(String message) => ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => show(l10n.genericError),
        ),
        BlocListener<PeriodStartsCubit, PeriodStartsState>(
          listenWhen: (previous, current) =>
              current.failure != null && previous.failure != current.failure,
          listener: (context, state) => show(l10n.genericError),
        ),
        BlocListener<PeriodStartsCubit, PeriodStartsState>(
          listenWhen: (previous, current) =>
              previous.notices != current.notices,
          listener: (context, state) => show(switch (state.notice) {
            PeriodStartNotice.alreadyStarted => l10n.periodAlreadyStarted,
            _ => l10n.periodStarted,
          }),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.settingsTitle)),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, settingsState) {
            final settings = settingsState.settings;
            final currencies = context.select<CurrenciesCubit, List<Currency>>(
              (cubit) => cubit.state.currencies,
            );
            return ListView(
              children: [
                SectionHeader(l10n.settingsSectionGeneral),
                ListTile(
                  title: Text(l10n.settingsMainCurrency),
                  subtitle: Text(settings.mainCurrencyCode),
                  onTap: () => _pickMainCurrency(context, settings, currencies),
                ),
                SectionHeader(l10n.settingsSectionPeriods),
                ListTile(
                  title: Text(l10n.settingsCutoffDay),
                  subtitle: Text('${settings.cutoffDay}'),
                  onTap: () => _pickCutoffDay(context, settings),
                ),
                ListTile(
                  title: Text(l10n.settingsMinDays),
                  subtitle: Text(
                    l10n.settingsMinDaysValue(settings.minDaysBetweenPeriods),
                  ),
                  onTap: () => _pickMinDays(context, settings),
                ),
                const _AdvancedPeriods(),
                SectionHeader(l10n.settingsSectionBalance),
                const BalanceAccountsSection(),
                SectionHeader(l10n.settingsSectionCurrencies),
                for (final currency in currencies)
                  CurrencyTile(
                    key: ValueKey(currency.code),
                    currency: currency,
                    onTap: () =>
                        context.push(AppRoutes.editCurrency(currency.code)),
                  ),
                ListTile(
                  leading: const Icon(Icons.add_rounded),
                  title: Text(l10n.currencyAdd),
                  onTap: () => context.push(AppRoutes.newCurrency),
                ),
                SectionHeader(l10n.settingsSectionNotifications),
                SwitchListTile(
                  title: Text(l10n.settingsReminders),
                  value: settings.notificationsEnabled,
                  onChanged: (enabled) => context.read<SettingsCubit>().update(
                    (s) => s.copyWith(notificationsEnabled: enabled),
                  ),
                ),
                ListTile(
                  enabled: settings.notificationsEnabled,
                  title: Text(l10n.settingsReminderTime),
                  subtitle: Text(
                    _timeOf(settings.reminderMinutes).format(context),
                  ),
                  onTap: () => _pickReminderTime(context, settings),
                ),
                SectionHeader(l10n.settingsSectionAbout),
                ListTile(
                  title: Text(l10n.settingsVersion),
                  subtitle: Text(
                    l10n.settingsVersionValue(
                      appInfo.version,
                      appInfo.buildNumber,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  static TimeOfDay _timeOf(int minutes) =>
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);

  Future<void> _pickMainCurrency(
    BuildContext context,
    AppSettings settings,
    List<Currency> currencies,
  ) async {
    final cubit = context.read<SettingsCubit>();
    final code = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsMainCurrency),
        children: [
          for (final currency in currencies)
            SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(currency.code),
              child: Text(
                '${currency.code} · ${currency.symbol}',
                style: currency.code == settings.mainCurrencyCode
                    ? TextStyle(color: context.colors.primary)
                    : null,
              ),
            ),
        ],
      ),
    );
    if (code != null) {
      await cubit.update((s) => s.copyWith(mainCurrencyCode: code));
    }
  }

  Future<void> _pickCutoffDay(
    BuildContext context,
    AppSettings settings,
  ) async {
    final cubit = context.read<SettingsCubit>();
    final day = await showNumberGridDialog(
      context,
      title: context.l10n.settingsCutoffDay,
      message: context.l10n.settingsCutoffDayHint,
      min: SettingsRules.minCutoffDay,
      max: SettingsRules.maxCutoffDay,
      selected: settings.cutoffDay,
    );
    if (day != null) await cubit.update((s) => s.copyWith(cutoffDay: day));
  }

  Future<void> _pickMinDays(BuildContext context, AppSettings settings) async {
    final cubit = context.read<SettingsCubit>();
    final days = await showNumberGridDialog(
      context,
      title: context.l10n.settingsMinDays,
      min: SettingsRules.minDaysBetweenPeriods,
      max: SettingsRules.maxDaysBetweenPeriods,
      selected: settings.minDaysBetweenPeriods,
    );
    if (days != null) {
      await cubit.update((s) => s.copyWith(minDaysBetweenPeriods: days));
    }
  }

  Future<void> _pickReminderTime(
    BuildContext context,
    AppSettings settings,
  ) async {
    final cubit = context.read<SettingsCubit>();
    final time = await showTimePicker(
      context: context,
      initialTime: _timeOf(settings.reminderMinutes),
    );
    if (time != null) {
      await cubit.update(
        (s) => s.copyWith(reminderMinutes: time.hour * 60 + time.minute),
      );
    }
  }
}

/// Settings → Periods → Advanced: "Start new period now" and the manual
/// starts, each one undoable (RF-05).
class _AdvancedPeriods extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final starts = context.select<PeriodStartsCubit, List<LocalDate>>(
      (cubit) => cubit.state.manualStarts,
    );
    return ExpansionTile(
      title: Text(l10n.settingsAdvanced),
      children: [
        ListTile(
          leading: const Icon(Icons.flag_outlined),
          title: Text(l10n.periodStartNow),
          subtitle: Text(l10n.periodStartNowHint),
          onTap: () => _confirmStart(context),
        ),
        for (final date in starts)
          ListTile(
            key: ValueKey(date),
            title: Text(l10n.periodManualStart(_format(context, date))),
            trailing: IconButton(
              tooltip: l10n.periodRemoveStartTooltip,
              icon: const Icon(Icons.undo_rounded),
              onPressed: () => _confirmRemove(context, date),
            ),
          ),
      ],
    );
  }

  static String _format(BuildContext context, LocalDate date) =>
      DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag())
          .format(date.toDateTime());

  static Future<void> _confirmStart(BuildContext context) async {
    final l10n = context.l10n;
    final cubit = context.read<PeriodStartsCubit>();
    final confirmed = await _confirm(
      context,
      title: l10n.periodStartNowTitle,
      message: l10n.periodStartNowMessage,
      action: l10n.periodStartAction,
    );
    if (confirmed) await cubit.startNow();
  }

  static Future<void> _confirmRemove(
    BuildContext context,
    LocalDate date,
  ) async {
    final l10n = context.l10n;
    final cubit = context.read<PeriodStartsCubit>();
    final confirmed = await _confirm(
      context,
      title: l10n.periodRemoveStartTitle(_format(context, date)),
      message: l10n.periodRemoveStartMessage,
      action: l10n.actionDelete,
    );
    if (confirmed) await cubit.remove(date);
  }

  static Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String action,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(context.l10n.actionCancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(action),
            ),
          ],
        ),
      ) ??
      false;
}
