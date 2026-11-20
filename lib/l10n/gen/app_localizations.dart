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
