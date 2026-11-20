part of 'transfer_form_cubit.dart';

enum TransferFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class TransferFormState with _$TransferFormState {
  const factory({
    @Default(TransferFormStatus.loading) TransferFormStatus status,

    /// The stored transfer when editing; `null` when creating.
    Movement? original,
    int? fromAccountId,
    int? toAccountId,

    /// What leaves [fromAccountId].
    @Default(AmountInput()) AmountInput amount,

    /// What arrives at [toAccountId]; only between currencies (RT-05).
    @Default(AmountInput()) AmountInput toAmount,

    /// Whether the keypad types [toAmount].
    @Default(false) bool editingTo,
    int? categoryId,

    /// Whether the user picked the category; then accounts no longer
    /// change it.
    @Default(false) bool categoryTouched,
    @Default('') String note,
    LocalDate? date,
    @Default(<Account>[]) List<Account> accounts,
    @Default(<Category>[]) List<Category> categories,
    @Default(<Currency>[]) List<Currency> currencies,
    @Default(<MovementError>{}) Set<MovementError> errors,
    @Default(false) bool showErrors,

    /// Last failure of a save or delete, shown once by the UI.
    Failure? failure,
  }) = _TransferFormState;

  const new _();

  bool get isEditing => original != null;

  Account? get from => accounts.byId(fromAccountId);

  Account? get to => accounts.byId(toAccountId);

  Currency? _currencyOf(Account? account) =>
      currencies.where((c) => c.code == account?.currencyCode).firstOrNull;

  Currency? get fromCurrency => _currencyOf(from);

  Currency? get toCurrency => _currencyOf(to);

  CurrencyFormat get fromFormat => fromCurrency?.format ?? CurrencyFormat.cop;

  CurrencyFormat get toFormat => toCurrency?.format ?? fromFormat;

  /// Without a destination yet, the amounts are taken as one currency.
  bool get sameCurrency {
    final to = this.to;
    return to == null || from?.currencyCode == to.currencyCode;
  }

  /// Between an account and its own pockets: it adds nothing to the
  /// Transfers total.
  bool get isInternal {
    final from = this.from;
    final to = this.to;
    return from != null && to != null && TransferRules.isInternal(from, to);
  }

  /// Active accounts, pockets included, plus the stored ones of an edited
  /// transfer.
  List<Account> get accountOptions => [
    for (final a in accounts)
      if (!a.isArchived ||
          a.id == original?.accountId ||
          a.id == original?.toAccountId)
        a,
  ];

  /// Active transfer categories, plus the stored one.
  List<Category> get categoryOptions => [
    for (final c in categories)
      if (c.type == CategoryType.transfer &&
          (!c.isArchived || c.id == original?.categoryId))
        c,
  ];

  Category? get category => categories.byId(categoryId);
}
