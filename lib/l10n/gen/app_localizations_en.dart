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
  String get currencySeparatorDot => 'Dot';

  @override
  String get currencySeparatorComma => 'Comma';

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

  @override
  String get settingsSectionBalance => 'Balance';

  @override
  String get currencyInUseLocked =>
      'Currencies used by an account can\'t be deleted.';

  @override
  String get iconPickerTitle => 'Icon';

  @override
  String get colorPickerTitle => 'Color';

  @override
  String get iconGroupFood => 'Food';

  @override
  String get iconGroupTransport => 'Transport';

  @override
  String get iconGroupHome => 'Home';

  @override
  String get iconGroupHealth => 'Health';

  @override
  String get iconGroupShopping => 'Shopping';

  @override
  String get iconGroupLeisure => 'Leisure';

  @override
  String get iconGroupEducation => 'Education';

  @override
  String get iconGroupFinance => 'Finance';

  @override
  String get iconGroupPeople => 'People';

  @override
  String get iconGroupOther => 'Other';

  @override
  String get accountsOpenTooltip => 'Accounts';

  @override
  String get accountsTitle => 'Accounts';

  @override
  String get accountsTotalBalance => 'Total balance';

  @override
  String get accountsBalance => 'Balance';

  @override
  String get accountsCurrencyTooltip => 'Currency';

  @override
  String get accountsShowArchived => 'Show archived';

  @override
  String accountsEmpty(String currency) {
    return 'No accounts in $currency yet.';
  }

  @override
  String get accountGroupCashAndBank => 'Cash & bank';

  @override
  String get accountGroupCreditCards => 'Credit cards';

  @override
  String get accountGroupInvestments => 'Investments';

  @override
  String get accountMainMarker => 'Main account';

  @override
  String get accountInBalanceMarker => 'Included in Balance';

  @override
  String get accountArchived => 'Archived';

  @override
  String get accountFree => 'Free';

  @override
  String accountCreditLeft(String amount) {
    return '$amount left';
  }

  @override
  String accountCreditLeftWithDay(String amount, int day) {
    return '$amount left · day $day';
  }

  @override
  String get accountNewTooltip => 'New account';

  @override
  String get accountNewTitle => 'New account';

  @override
  String accountEditTitle(String name) {
    return 'Edit $name';
  }

  @override
  String get accountNotFound => 'This account no longer exists.';

  @override
  String get accountType => 'Type';

  @override
  String get accountTypeLocked =>
      'The type can\'t be changed after creating the account.';

  @override
  String get accountTypeCash => 'Cash';

  @override
  String get accountTypeBank => 'Bank';

  @override
  String get accountTypeCreditCard => 'Credit card';

  @override
  String get accountTypeInvestment => 'Investment';

  @override
  String get accountTypePocket => 'Pocket';

  @override
  String get accountIconTooltip => 'Change icon';

  @override
  String get accountName => 'Name';

  @override
  String get accountErrorName => 'Enter a name.';

  @override
  String get accountChangeColor => 'Change color';

  @override
  String get accountParent => 'Parent account';

  @override
  String get accountErrorParent => 'Choose a bank account.';

  @override
  String get accountParentNone =>
      'Create a bank account first: pockets live inside one.';

  @override
  String get accountPocketFollowsParent =>
      'A pocket uses the currency and the Balance setting of its parent account.';

  @override
  String get accountCurrency => 'Currency';

  @override
  String get accountCurrencyLocked =>
      'The currency can\'t be changed: the account has movements.';

  @override
  String get accountOpening => 'Opening balance';

  @override
  String get accountCurrentDebt => 'Current debt';

  @override
  String get accountOpeningBankHint => 'Money outside its pockets';

  @override
  String get accountErrorAmount => 'Enter a valid amount.';

  @override
  String get accountOpeningDate => 'Opening date';

  @override
  String get accountCreditLimit => 'Credit limit';

  @override
  String get accountErrorCreditLimit => 'Enter a limit above zero.';

  @override
  String get accountPaymentDay => 'Payment day';

  @override
  String get accountPaymentDayUnset => 'Not set';

  @override
  String get accountIncludeInBalance => 'Include in Balance';

  @override
  String get accountMain => 'Main account';

  @override
  String get accountMainHint => 'Used when a category has no history yet.';

  @override
  String get accountMainLocked =>
      'Mark another bank account as main to change it.';

  @override
  String get accountMainStays =>
      'The main account can\'t be archived or deleted.';

  @override
  String get accountArchiveTooltip => 'Archive';

  @override
  String get accountUnarchiveTooltip => 'Restore';

  @override
  String get accountDeleteTooltip => 'Delete account';

  @override
  String accountDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get accountDeleteMessage =>
      'The account will be removed. Archive it instead to keep it out of sight.';

  @override
  String accountDeleteWithPocketsMessage(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pockets',
      one: 'pocket',
    );
    return 'Its $_temp0 will be deleted too: $names. This can\'t be undone. Archive it instead to keep it out of sight.';
  }

  @override
  String get accountDeleteWithPocketsAction => 'Delete all';
}
