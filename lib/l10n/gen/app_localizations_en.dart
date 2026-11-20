// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Saisho Kakeibo';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsSectionPeriods => 'Periods';

  @override
  String get settingsSectionCurrencies => 'Currencies';

  @override
  String get settingsSectionNotifications => 'Notifications';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsMainCurrency => 'Main currency';

  @override
  String get settingsCutoffDay => 'Cutoff day';

  @override
  String get settingsCutoffDayHint =>
      'Monthly periods start on this day. Days missing in a month fall on its last day.';

  @override
  String get settingsMinDays => 'Min days between salary periods';

  @override
  String settingsMinDaysValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsReminderTime => 'Reminder time';

  @override
  String get settingsVersion => 'Version';

  @override
  String settingsVersionValue(String version, String build) {
    return '$version ($build)';
  }

  @override
  String get currencyAdd => 'Add currency';

  @override
  String get currencyBuiltIn => 'Built-in';

  @override
  String get currencyNewTitle => 'New currency';

  @override
  String currencyEditTitle(String code) {
    return 'Edit $code';
  }

  @override
  String get currencyCode => 'Code';

  @override
  String get currencyCodeHint => 'Three letters, such as EUR';

  @override
  String get currencySymbol => 'Symbol';

  @override
  String get currencyDecimals => 'Decimals';

  @override
  String get currencyDecimalsWarning =>
      'Decimals can\'t be changed after creating the currency.';

  @override
  String get currencyDecimalsLocked =>
      'Decimals can\'t be changed: every amount is stored with them.';

  @override
  String get currencyThousandsSeparator => 'Thousands separator';

  @override
  String get currencyDecimalSeparator => 'Decimal separator';

  @override
  String get currencySeparatorSpace => 'Space';

  @override
  String get currencySeparatorNone => 'None';

  @override
  String currencyPreview(String amount) {
    return 'Preview: $amount';
  }

  @override
  String get currencyErrorCode => 'Use three letters, A to Z.';

  @override
  String get currencyErrorDuplicate => 'That currency already exists.';

  @override
  String get currencyErrorSymbol => 'Use 1 to 4 characters.';

  @override
  String get currencyErrorSeparators => 'Separators must be different.';

  @override
  String get currencyDeleteTooltip => 'Delete currency';

  @override
  String currencyDeleteTitle(String code) {
    return 'Delete $code?';
  }

  @override
  String get currencyDeleteMessage => 'This can\'t be undone.';

  @override
  String get currencyBuiltInLocked => 'Built-in currencies can\'t be deleted.';

  @override
  String get currencyMainLocked => 'The main currency can\'t be deleted.';

  @override
  String get currencyNotFound => 'This currency no longer exists.';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get settingsOpenTooltip => 'Settings';
}
