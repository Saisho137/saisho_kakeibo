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

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoryTypeExpense => 'Expense';

  @override
  String get categoryTypeIncome => 'Income';

  @override
  String get categoryTypeTransfer => 'Transfer';

  @override
  String categoriesArchived(int count) {
    return 'Archived ($count)';
  }

  @override
  String get categoriesEmpty => 'No categories yet.';

  @override
  String get categoryCoreMarker => 'Core category';

  @override
  String get categoryNoPillar => 'No pillar';

  @override
  String get categoryDebtPillar => 'Debt\'s pillar';

  @override
  String get categoryNewTooltip => 'New category';

  @override
  String get categoryNewTitle => 'New category';

  @override
  String categoryEditTitle(String name) {
    return 'Edit $name';
  }

  @override
  String get categoryNotFound => 'This category no longer exists.';

  @override
  String get categoryType => 'Type';

  @override
  String get categoryTypeLocked =>
      'The type can\'t be changed after creating the category.';

  @override
  String get categoryIconTooltip => 'Change icon';

  @override
  String get categoryName => 'Name';

  @override
  String get categoryErrorName => 'Enter a name.';

  @override
  String categoryErrorDuplicate(String type) {
    return 'Another $type category has this name.';
  }

  @override
  String get categoryChangeColor => 'Change color';

  @override
  String get categoryPillar => 'Pillar';

  @override
  String get categoryErrorPillar => 'Pick a pillar.';

  @override
  String get categoryDebtPillarHint =>
      'Each payment takes the pillar of the debt it pays.';

  @override
  String get categoryNoPillarHint =>
      'It doesn\'t belong to a pillar: it shows as No pillar in the chart.';

  @override
  String get categoryCoreHint =>
      'Core category: it can be renamed, but not archived or deleted.';

  @override
  String get categoryReset => 'Reset to default';

  @override
  String get categoryArchiveTooltip => 'Archive';

  @override
  String get categoryUnarchiveTooltip => 'Restore';

  @override
  String get categoryArchivedHint =>
      'Archived: it\'s out of the quick entry grid and keeps its history.';

  @override
  String get categoryDeleteTooltip => 'Delete category';

  @override
  String categoryDeleteTitle(String name) {
    return 'Delete $name?';
  }

  @override
  String get categoryDeleteNoMovements =>
      'It has no movements. This can\'t be undone.';

  @override
  String categoryDeleteMovements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Its $count movements move',
      one: 'Its movement moves',
    );
    return '$_temp0 to the category you pick. This can\'t be undone.';
  }

  @override
  String get categoryDeleteTarget => 'Move to';

  @override
  String get pillarsTooltip => 'Pillars';

  @override
  String get pillarsTitle => 'Pillars';

  @override
  String get pillarsHint =>
      'Pillars classify expenses. Rename them or change their color.';

  @override
  String get pillarEditTitle => 'Edit pillar';

  @override
  String get pillarName => 'Name';

  @override
  String get pillarErrorName => 'Enter a name.';

  @override
  String get pillarErrorDuplicate => 'Another pillar has this name.';

  @override
  String get pillarColorInUse => 'Colors of other pillars are not available.';

  @override
  String get actionClose => 'Close';

  @override
  String get accountEditTooltip => 'Edit account';

  @override
  String get accountAdjustBalance => 'Adjust balance';

  @override
  String get accountUpdateValue => 'Update value';

  @override
  String get accountDetailNotFound => 'This account no longer exists.';

  @override
  String get adjustRealBalance => 'Real balance';

  @override
  String get adjustCurrentValue => 'Current value';

  @override
  String get adjustCurrentDebt => 'Current debt';

  @override
  String get adjustHint =>
      'The difference is saved as an adjustment: it moves no income, expense or transfer total.';

  @override
  String adjustDifference(String amount) {
    return 'Difference: $amount';
  }

  @override
  String get adjustErrorAmount => 'Enter an amount.';

  @override
  String get movementAdjustment => 'Balance adjustment';

  @override
  String get movementPending => 'Pending';

  @override
  String movementTransferTo(String name) {
    return 'To $name';
  }

  @override
  String movementTransferFrom(String name) {
    return 'From $name';
  }

  @override
  String get movementDeleteAdjustmentTitle => 'Delete this adjustment?';

  @override
  String get movementDeleteAdjustmentMessage =>
      'The balance goes back to what it was without it.';

  @override
  String get dayToday => 'Today';

  @override
  String get dayYesterday => 'Yesterday';

  @override
  String get homeNewExpense => 'Expense';

  @override
  String get homeNewIncome => 'Income';

  @override
  String get entryExpenseTitle => 'New expense';

  @override
  String get entryIncomeTitle => 'New income';

  @override
  String get entrySearchHint => 'Search categories and entities';

  @override
  String get entryEntities => 'Entities';

  @override
  String get entryNoMatches => 'Nothing matches.';

  @override
  String get movementAccount => 'Account';

  @override
  String get movementPayee => 'Entity';

  @override
  String get movementNote => 'Note';

  @override
  String get movementStartsPeriod => 'Starts period';

  @override
  String get movementStartsPeriodHint => 'A new period starts on this date.';

  @override
  String get movementConfirm => 'Confirm';

  @override
  String get movementChangeCategory => 'Change category';

  @override
  String get movementDeleteTooltip => 'Delete movement';

  @override
  String get movementDeleteTitle => 'Delete this movement?';

  @override
  String get movementDeleteMessage => 'This can\'t be undone.';

  @override
  String get movementNotFound => 'This movement no longer exists.';

  @override
  String get movementErrorAmount => 'Enter an amount above zero.';

  @override
  String get movementErrorAccount => 'Pick an account.';

  @override
  String get movementErrorCategory => 'Pick a category.';

  @override
  String movementResult(String amount) {
    return '= $amount';
  }

  @override
  String get keypadBackspace => 'Delete';

  @override
  String get keypadAdd => 'Plus';

  @override
  String get keypadSubtract => 'Minus';

  @override
  String get keypadMultiply => 'Times';

  @override
  String get keypadDivide => 'Divided by';

  @override
  String get homeNewTransfer => 'Transfer';

  @override
  String get accountTransfer => 'Transfer';

  @override
  String get transferNewTitle => 'New transfer';

  @override
  String get transferEditTitle => 'Transfer';

  @override
  String get transferFrom => 'From';

  @override
  String get transferTo => 'To';

  @override
  String get transferSent => 'Sent';

  @override
  String get transferReceived => 'Received';

  @override
  String get transferCategory => 'Category';

  @override
  String get transferErrorTo => 'Pick the account that receives it.';

  @override
  String get transferErrorSame => 'Pick two different accounts.';

  @override
  String get transferInternalHint =>
      'Between an account and its own pockets: it doesn\'t add to the Transfers total.';

  @override
  String get transferDeleteTooltip => 'Delete transfer';

  @override
  String get transferDeleteTitle => 'Delete this transfer?';

  @override
  String get settingsAdvanced => 'Advanced';

  @override
  String get periodStartNow => 'Start new period now';

  @override
  String get periodStartNowHint =>
      'Use it only when no salary started the period.';

  @override
  String get periodStartNowTitle => 'Start a new period today?';

  @override
  String get periodStartNowMessage =>
      'Periods usually start with a salary marked \"Starts period\". You can undo this start here.';

  @override
  String get periodStartAction => 'Start';

  @override
  String get periodStarted => 'A new period starts today.';

  @override
  String get periodAlreadyStarted => 'A period already starts today.';

  @override
  String periodManualStart(String date) {
    return 'Manual start · $date';
  }

  @override
  String get periodRemoveStartTooltip => 'Undo this start';

  @override
  String periodRemoveStartTitle(String date) {
    return 'Undo the start of $date?';
  }

  @override
  String get periodRemoveStartMessage => 'Its period joins the previous one.';

  @override
  String periodRange(String start, String end) {
    return '$start – $end';
  }

  @override
  String periodSince(String start) {
    return 'Since $start';
  }

  @override
  String get accountNoMovementsInPeriod => 'No movements in this period.';

  @override
  String get homeQuickMenuTooltip => 'Quick menu';

  @override
  String get homeNavigationTooltip => 'Go to';

  @override
  String get homeIncome => 'Income';

  @override
  String get homeExpenses => 'Expenses';

  @override
  String get homeTransfers => 'Transfers';

  @override
  String get homeBalance => 'Balance';

  @override
  String get quickMenuPeriod => 'Period';

  @override
  String get periodTypeDynamic => 'Dynamic';

  @override
  String get periodTypeMonthly => 'Monthly';

  @override
  String get periodTypeYearly => 'Year';

  @override
  String get quickMenuCurrency => 'Currency';

  @override
  String get quickMenuBalance => 'Balance';

  @override
  String get balanceFilterCash => 'Cash';

  @override
  String get balanceFilterBank => 'Bank';

  @override
  String get balanceFilterBoth => 'Both';

  @override
  String get quickMenuTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get donutNoPillar => 'No pillar';

  @override
  String get homeHistoryTooltip => 'History';

  @override
  String get historyByDay => 'By day';

  @override
  String get historyByCategory => 'By category';

  @override
  String get historyEmpty => 'No movements in this period.';

  @override
  String historyCategoryShare(String percent, String type) {
    return '$percent of $type';
  }
}
