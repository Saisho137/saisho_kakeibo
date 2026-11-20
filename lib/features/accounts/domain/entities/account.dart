import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';

part 'account.freezed.dart';

/// What kind of place holds the money (RT-12). It never changes after the
/// account is created.
enum AccountType {
  cash,
  bank,
  creditCard,
  investment,

  /// A child of a bank account, such as an emergency fund.
  pocket;

  /// Section of the Accounts screen. Pockets are shown under their parent.
  AccountGroup get group => switch (this) {
    cash || bank || pocket => AccountGroup.cashAndBank,
    creditCard => AccountGroup.creditCards,
    investment => AccountGroup.investments,
  };

  /// Catalog icon suggested for a new account of this type.
  String get defaultIconKey => switch (this) {
    cash => 'payments',
    bank => 'account_balance',
    creditCard => 'credit_card',
    investment => 'trending_up',
    pocket => 'savings',
  };
}

/// Sections of the Accounts screen, in display order.
enum AccountGroup { cashAndBank, creditCards, investments }

/// A place where money of mine lives (RF-03, RF-04, RF-15).
@freezed
abstract class Account with _$Account {
  const factory({
    required String name,

    /// Key of the icon in the core icon catalog.
    required String iconKey,

    /// ARGB color of the icon circle.
    required int color,
    required AccountType type,
    required String currencyCode,

    /// Balance in the currency's minor unit when the account was created.
    /// Negative for a credit card that already had debt.
    required int openingBalance,
    required LocalDate openingDate,

    /// Database id; `0` for an account that is not stored yet.
    @Default(0) int id,

    /// Whether the account adds to the main Balance. Pockets copy it from
    /// their parent.
    @Default(false) bool includeInBalance,

    /// The default bank account. There is always exactly one.
    @Default(false) bool isMain,

    /// Parent bank account; only pockets have one.
    int? parentAccountId,

    /// Credit card limit in minor units.
    int? creditLimit,

    /// Day of the month the credit card is paid, 1–31.
    int? paymentDay,

    /// Position inside its group (or among its siblings for pockets).
    @Default(0) int sortOrder,
    @Default(false) bool isArchived,
  }) = _Account;

  const new _();

  bool get isPocket => type == AccountType.pocket;

  Money get opening => Money(openingBalance, currencyCode);
}
