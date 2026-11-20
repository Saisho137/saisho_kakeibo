import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application name shown in the task switcher.
  ///
  /// In en, this message translates to:
  /// **'Saisho Kakeibo'**
  String get appTitle;

  /// Fallback message for unexpected failures.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// Settings screen title and navigation entry.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings section header.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsSectionGeneral;

  /// Settings section header.
  ///
  /// In en, this message translates to:
  /// **'Periods'**
  String get settingsSectionPeriods;

  /// Settings section header.
  ///
  /// In en, this message translates to:
  /// **'Currencies'**
  String get settingsSectionCurrencies;

  /// Settings section header.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsSectionNotifications;

  /// Settings section header.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// Setting: currency shown by default.
  ///
  /// In en, this message translates to:
  /// **'Main currency'**
  String get settingsMainCurrency;

  /// Setting: day monthly periods start.
  ///
  /// In en, this message translates to:
  /// **'Cutoff day'**
  String get settingsCutoffDay;

  /// Explains the cutoff day.
  ///
  /// In en, this message translates to:
  /// **'Monthly periods start on this day. Days missing in a month fall on its last day.'**
  String get settingsCutoffDayHint;

  /// Setting: days before Salary suggests a new period.
  ///
  /// In en, this message translates to:
  /// **'Min days between salary periods'**
  String get settingsMinDays;

  /// Number of days.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String settingsMinDaysValue(int count);

  /// Setting: global switch for notifications.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// Setting: time every reminder arrives.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTime;

  /// About: app version label.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// App version and build number.
  ///
  /// In en, this message translates to:
  /// **'{version} ({build})'**
  String settingsVersionValue(String version, String build);

  /// Action to create a currency.
  ///
  /// In en, this message translates to:
  /// **'Add currency'**
  String get currencyAdd;

  /// Marks COP and USD, which cannot be deleted.
  ///
  /// In en, this message translates to:
  /// **'Built-in'**
  String get currencyBuiltIn;

  /// Currency form title when creating.
  ///
  /// In en, this message translates to:
  /// **'New currency'**
  String get currencyNewTitle;

  /// Currency form title when editing.
  ///
  /// In en, this message translates to:
  /// **'Edit {code}'**
  String currencyEditTitle(String code);

  /// Currency code field.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get currencyCode;

  /// Hint of the currency code field.
  ///
  /// In en, this message translates to:
  /// **'Three letters, such as EUR'**
  String get currencyCodeHint;

  /// Currency symbol field.
  ///
  /// In en, this message translates to:
  /// **'Symbol'**
  String get currencySymbol;

  /// Currency decimals field.
  ///
  /// In en, this message translates to:
  /// **'Decimals'**
  String get currencyDecimals;

  /// Warning shown when creating a currency.
  ///
  /// In en, this message translates to:
  /// **'Decimals can\'t be changed after creating the currency.'**
  String get currencyDecimalsWarning;

  /// Shown when editing a currency.
  ///
  /// In en, this message translates to:
  /// **'Decimals can\'t be changed: every amount is stored with them.'**
  String get currencyDecimalsLocked;

  /// Currency field.
  ///
  /// In en, this message translates to:
  /// **'Thousands separator'**
  String get currencyThousandsSeparator;

  /// Currency field.
  ///
  /// In en, this message translates to:
  /// **'Decimal separator'**
  String get currencyDecimalSeparator;

  /// Separator option: a dot (.).
  ///
  /// In en, this message translates to:
  /// **'Dot'**
  String get currencySeparatorDot;

  /// Separator option: a comma (,).
  ///
  /// In en, this message translates to:
  /// **'Comma'**
  String get currencySeparatorComma;

  /// Separator option: a space.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get currencySeparatorSpace;

  /// Separator option: no separator.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get currencySeparatorNone;

  /// Live preview of the currency format.
  ///
  /// In en, this message translates to:
  /// **'Preview: {amount}'**
  String currencyPreview(String amount);

  /// Validation error.
  ///
  /// In en, this message translates to:
  /// **'Use three letters, A to Z.'**
  String get currencyErrorCode;

  /// Validation error.
  ///
  /// In en, this message translates to:
  /// **'That currency already exists.'**
  String get currencyErrorDuplicate;

  /// Validation error.
  ///
  /// In en, this message translates to:
  /// **'Use 1 to 4 characters.'**
  String get currencyErrorSymbol;

  /// Validation error.
  ///
  /// In en, this message translates to:
  /// **'Separators must be different.'**
  String get currencyErrorSeparators;

  /// Tooltip of the delete action.
  ///
  /// In en, this message translates to:
  /// **'Delete currency'**
  String get currencyDeleteTooltip;

  /// Confirmation dialog title.
  ///
  /// In en, this message translates to:
  /// **'Delete {code}?'**
  String currencyDeleteTitle(String code);

  /// Confirmation dialog body.
  ///
  /// In en, this message translates to:
  /// **'This can\'t be undone.'**
  String get currencyDeleteMessage;

  /// Why a currency can't be deleted.
  ///
  /// In en, this message translates to:
  /// **'Built-in currencies can\'t be deleted.'**
  String get currencyBuiltInLocked;

  /// Why a currency can't be deleted.
  ///
  /// In en, this message translates to:
  /// **'The main currency can\'t be deleted.'**
  String get currencyMainLocked;

  /// Shown when the edited currency is missing.
  ///
  /// In en, this message translates to:
  /// **'This currency no longer exists.'**
  String get currencyNotFound;

  /// Generic save button.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// Generic cancel button.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// Generic delete button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// Tooltip of the button that opens Settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsOpenTooltip;

  /// Settings section header: accounts included in the Balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get settingsSectionBalance;

  /// Why a currency in use has no delete action.
  ///
  /// In en, this message translates to:
  /// **'Currencies used by an account can\'t be deleted.'**
  String get currencyInUseLocked;

  /// Icon picker dialog title.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get iconPickerTitle;

  /// Color picker dialog title.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get colorPickerTitle;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get iconGroupFood;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get iconGroupTransport;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get iconGroupHome;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get iconGroupHealth;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get iconGroupShopping;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Leisure'**
  String get iconGroupLeisure;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get iconGroupEducation;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get iconGroupFinance;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get iconGroupPeople;

  /// Icon picker group.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get iconGroupOther;

  /// Tooltip of the button that opens Accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsOpenTooltip;

  /// Accounts screen title.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accountsTitle;

  /// Sum of every account of the selected currency.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get accountsTotalBalance;

  /// Sum of the accounts included in the Balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get accountsBalance;

  /// Tooltip of the currency selector on Accounts.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get accountsCurrencyTooltip;

  /// Menu option that also lists archived accounts.
  ///
  /// In en, this message translates to:
  /// **'Show archived'**
  String get accountsShowArchived;

  /// Accounts screen without accounts in the selected currency.
  ///
  /// In en, this message translates to:
  /// **'No accounts in {currency} yet.'**
  String accountsEmpty(String currency);

  /// Accounts group header.
  ///
  /// In en, this message translates to:
  /// **'Cash & bank'**
  String get accountGroupCashAndBank;

  /// Accounts group header.
  ///
  /// In en, this message translates to:
  /// **'Credit cards'**
  String get accountGroupCreditCards;

  /// Accounts group header.
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get accountGroupInvestments;

  /// Accessibility label of the star next to the main account.
  ///
  /// In en, this message translates to:
  /// **'Main account'**
  String get accountMainMarker;

  /// Accessibility label of the dot next to accounts included in the Balance.
  ///
  /// In en, this message translates to:
  /// **'Included in Balance'**
  String get accountInBalanceMarker;

  /// Label of an archived account.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get accountArchived;

  /// Money of an account outside its pockets.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get accountFree;

  /// Credit limit left on a card.
  ///
  /// In en, this message translates to:
  /// **'{amount} left'**
  String accountCreditLeft(String amount);

  /// Credit limit left and the card's payment day.
  ///
  /// In en, this message translates to:
  /// **'{amount} left · day {day}'**
  String accountCreditLeftWithDay(String amount, int day);

  /// Tooltip of the button that creates an account.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get accountNewTooltip;

  /// Account form title when creating.
  ///
  /// In en, this message translates to:
  /// **'New account'**
  String get accountNewTitle;

  /// Account form title when editing.
  ///
  /// In en, this message translates to:
  /// **'Edit {name}'**
  String accountEditTitle(String name);

  /// Shown when the edited account was deleted.
  ///
  /// In en, this message translates to:
  /// **'This account no longer exists.'**
  String get accountNotFound;

  /// Account type field.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get accountType;

  /// Note under the read-only type.
  ///
  /// In en, this message translates to:
  /// **'The type can\'t be changed after creating the account.'**
  String get accountTypeLocked;

  /// Account type.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get accountTypeCash;

  /// Account type.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accountTypeBank;

  /// Account type.
  ///
  /// In en, this message translates to:
  /// **'Credit card'**
  String get accountTypeCreditCard;

  /// Account type.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get accountTypeInvestment;

  /// Account type: a part of a bank account, such as an emergency fund.
  ///
  /// In en, this message translates to:
  /// **'Pocket'**
  String get accountTypePocket;

  /// Tooltip of the account icon in the form.
  ///
  /// In en, this message translates to:
  /// **'Change icon'**
  String get accountIconTooltip;

  /// Account name field.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountName;

  /// Error when the account name is empty.
  ///
  /// In en, this message translates to:
  /// **'Enter a name.'**
  String get accountErrorName;

  /// Button that opens the color picker.
  ///
  /// In en, this message translates to:
  /// **'Change color'**
  String get accountChangeColor;

  /// Bank account that holds a pocket.
  ///
  /// In en, this message translates to:
  /// **'Parent account'**
  String get accountParent;

  /// Error when a pocket has no valid parent.
  ///
  /// In en, this message translates to:
  /// **'Choose a bank account.'**
  String get accountErrorParent;

  /// Note when there is no bank account for a pocket.
  ///
  /// In en, this message translates to:
  /// **'Create a bank account first: pockets live inside one.'**
  String get accountParentNone;

  /// Note under the pocket's parent field.
  ///
  /// In en, this message translates to:
  /// **'A pocket uses the currency and the Balance setting of its parent account.'**
  String get accountPocketFollowsParent;

  /// Account currency field.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get accountCurrency;

  /// Note under a locked currency.
  ///
  /// In en, this message translates to:
  /// **'The currency can\'t be changed: the account has movements.'**
  String get accountCurrencyLocked;

  /// Opening balance field.
  ///
  /// In en, this message translates to:
  /// **'Opening balance'**
  String get accountOpening;

  /// Opening balance field of a credit card: what is owed when it is created.
  ///
  /// In en, this message translates to:
  /// **'Current debt'**
  String get accountCurrentDebt;

  /// Hint under a bank account's opening balance.
  ///
  /// In en, this message translates to:
  /// **'Money outside its pockets'**
  String get accountOpeningBankHint;

  /// Error when an amount can't be read.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount.'**
  String get accountErrorAmount;

  /// Date of the opening balance.
  ///
  /// In en, this message translates to:
  /// **'Opening date'**
  String get accountOpeningDate;

  /// Credit card limit field.
  ///
  /// In en, this message translates to:
  /// **'Credit limit'**
  String get accountCreditLimit;

  /// Error when a card has no valid limit.
  ///
  /// In en, this message translates to:
  /// **'Enter a limit above zero.'**
  String get accountErrorCreditLimit;

  /// Day of the month the card is paid.
  ///
  /// In en, this message translates to:
  /// **'Payment day'**
  String get accountPaymentDay;

  /// Payment day before choosing one.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get accountPaymentDayUnset;

  /// Switch that adds the account to the main Balance.
  ///
  /// In en, this message translates to:
  /// **'Include in Balance'**
  String get accountIncludeInBalance;

  /// Switch that makes a bank account the main one.
  ///
  /// In en, this message translates to:
  /// **'Main account'**
  String get accountMain;

  /// What the main account is for.
  ///
  /// In en, this message translates to:
  /// **'Used when a category has no history yet.'**
  String get accountMainHint;

  /// Why the main switch can't be turned off.
  ///
  /// In en, this message translates to:
  /// **'Mark another bank account as main to change it.'**
  String get accountMainLocked;

  /// Why the main account has no archive or delete action.
  ///
  /// In en, this message translates to:
  /// **'The main account can\'t be archived or deleted.'**
  String get accountMainStays;

  /// Tooltip of the archive action.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get accountArchiveTooltip;

  /// Tooltip of the action that restores an archived account.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get accountUnarchiveTooltip;

  /// Tooltip of the delete action.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDeleteTooltip;

  /// Delete confirmation title.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String accountDeleteTitle(String name);

  /// Delete confirmation message.
  ///
  /// In en, this message translates to:
  /// **'The account will be removed. Archive it instead to keep it out of sight.'**
  String get accountDeleteMessage;

  /// Delete confirmation message of an account that has pockets.
  ///
  /// In en, this message translates to:
  /// **'Its {count, plural, =1{pocket} other{{count} pockets}} will be deleted too: {names}. This can\'t be undone. Archive it instead to keep it out of sight.'**
  String accountDeleteWithPocketsMessage(int count, String names);

  /// Confirm button that deletes an account and its pockets.
  ///
  /// In en, this message translates to:
  /// **'Delete all'**
  String get accountDeleteWithPocketsAction;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
