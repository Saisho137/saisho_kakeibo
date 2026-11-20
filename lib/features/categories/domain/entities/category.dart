import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// What a category classifies (RT-12).
enum CategoryType { income, expense, transfer }

/// What a category does beyond classifying (RT-12). Special logic always
/// follows the role, never the name, so renaming a core category is safe.
enum CategoryRole {
  /// A category created by the user, or a default one without behavior.
  custom,

  // Income
  salary,
  loanReceived,
  loanRepaid,

  // Expense
  loanGiven,
  debtPayment,
  uncategorized,

  // Transfer
  savings,
  savingsWithdrawal,
  investing,
  investmentWithdrawal,
  cardPayment,
  cashAdvance,
  cashWithdrawal,
  currencyExchange,
  betweenAccounts;

  /// Core categories come with the app and cannot be deleted or archived.
  bool get isCore => this != custom;

  /// Roles that create or pay a debt. Their movements need debts, which
  /// arrive in phase 8; until then the quick entry leaves them out.
  bool get needsDebt =>
      this == loanReceived ||
      this == loanRepaid ||
      this == loanGiven ||
      this == debtPayment;

  /// Type of the only category with this role; `null` for [custom].
  CategoryType? get type => switch (this) {
    custom => null,
    salary || loanReceived || loanRepaid => CategoryType.income,
    loanGiven || debtPayment || uncategorized => CategoryType.expense,
    _ => CategoryType.transfer,
  };
}

/// Classifies a movement (RF-13). Expenses created by the user also carry a
/// Kakeibo pillar (RF-02).
@freezed
abstract class Category with _$Category {
  const factory({
    required String name,

    /// Key of the icon in the core icon catalog (RT-13).
    required String iconKey,

    /// ARGB color of the icon circle.
    required int color,
    required CategoryType type,

    /// Database id; `0` for a category that is not stored yet.
    @Default(0) int id,
    @Default(CategoryRole.custom) CategoryRole role,

    /// Pillar of a custom expense; `null` for every other category.
    int? pillarId,

    /// Name and icon a core category is reset to.
    String? defaultName,
    String? defaultIconKey,

    /// Position inside its type: the order of the quick entry grid.
    @Default(0) int sortOrder,
    @Default(false) bool isArchived,
  }) = _Category;

  const new _();

  bool get isCore => role.isCore;

  /// Whether the category takes its pillar from itself. A debt payment
  /// takes it from the debt; loans given and uncategorized have none.
  bool get hasPillar => type == CategoryType.expense && !isCore;
}
