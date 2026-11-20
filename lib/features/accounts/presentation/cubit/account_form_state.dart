part of 'account_form_cubit.dart';

enum AccountFormStatus { loading, editing, saving, saved, deleted, notFound }

@freezed
abstract class AccountFormState with _$AccountFormState {
  const factory({
    @Default(AccountFormStatus.loading) AccountFormStatus status,

    /// The stored account when editing; `null` when creating.
    Account? original,

    /// Whether the edited account has movements: its currency is locked and
    /// it cannot be deleted.
    @Default(false) bool hasMovements,

    /// Every account, for the parent picker and the delete rule.
    @Default(<Account>[]) List<Account> accounts,
    @Default(<Currency>[]) List<Currency> currencies,
    @Default('') String name,
    @Default('') String iconKey,
    @Default(0) int color,

    /// Whether the user picked the icon; until then it follows the type.
    @Default(false) bool iconChosen,
    @Default(AccountType.bank) AccountType type,
    @Default('') String currencyCode,

    /// Opening balance as typed. For credit cards it is the debt, positive.
    @Default('') String openingText,
    LocalDate? openingDate,
    @Default(false) bool includeInBalance,
    @Default(false) bool isMain,
    int? parentAccountId,
    @Default('') String creditLimitText,
    int? paymentDay,
    @Default(<AccountError>{}) Set<AccountError> errors,

    /// Errors appear after the first submit, then update while typing.
    @Default(false) bool showErrors,

    /// Last failure of a save, archive or delete, shown once by the UI.
    Failure? failure,
  }) = _AccountFormState;

  const new _();

  bool get isEditing => original != null;

  bool get isPocket => type == AccountType.pocket;

  /// The pocket's parent, whose currency the pocket uses.
  Account? get parent => accounts.byId(parentAccountId);

  /// Currency of the amounts: a pocket's comes from its parent.
  Currency? get currency {
    final code = isPocket ? parent?.currencyCode : currencyCode;
    return currencies.where((c) => c.code == code).firstOrNull;
  }

  /// Bank accounts that can hold the pocket being edited.
  List<Account> get parentOptions {
    final self = original;
    return [
      for (final account in accounts)
        if (AccountRules.canBeParent(
          account,
          of: self ?? account.copyWith(id: -1),
          mayBeArchived: account.id == self?.parentAccountId,
        ))
          account,
    ];
  }

  bool get currencyLocked => isEditing && hasMovements;

  bool get hasPockets {
    final self = original;
    return self != null && accounts.pocketsOf(self.id).isNotEmpty;
  }

  bool get canArchive => isEditing && !(original?.isMain ?? false);

  bool get canDelete =>
      isEditing && !(original?.isMain ?? false) && !hasMovements && !hasPockets;
}
