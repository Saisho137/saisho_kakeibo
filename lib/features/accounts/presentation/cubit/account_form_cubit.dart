import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/rules/account_rules.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/account_has_movements.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/create_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/delete_account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/get_accounts.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/set_account_archived.dart';
import 'package:saisho_kakeibo/features/accounts/domain/usecases/update_account.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

part 'account_form_cubit.freezed.dart';
part 'account_form_state.dart';

/// Creates an account or edits one, with the fields of its type.
class AccountFormCubit extends Cubit<AccountFormState> {
  new({
    required this._getAccounts,
    required this._getCurrencies,
    required this._hasMovements,
    required this._createAccount,
    required this._updateAccount,
    required this._setArchived,
    required this._deleteAccount,
  }) : super(const AccountFormState());

  final GetAccounts _getAccounts;
  final GetCurrencies _getCurrencies;
  final AccountHasMovements _hasMovements;
  final CreateAccount _createAccount;
  final UpdateAccount _updateAccount;
  final SetAccountArchived _setArchived;
  final DeleteAccount _deleteAccount;

  /// Starts a new account in [mainCurrencyCode], or loads [id] to edit it.
  Future<void> load({required String mainCurrencyCode, int? id}) async {
    final List<Account> accounts;
    final List<Currency> currencies;
    switch ((
      await _getAccounts(const NoParams()),
      await _getCurrencies(const NoParams()),
    )) {
      case (Ok(value: final a), Ok(value: final c)):
        (accounts, currencies) = (a, c);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        emit(
          state.copyWith(status: AccountFormStatus.notFound, failure: failure),
        );
        return;
    }

    final loaded = state.copyWith(accounts: accounts, currencies: currencies);
    if (id == null) {
      const type = AccountType.bank;
      emit(
        _withTypeDefaults(
          loaded.copyWith(
            status: AccountFormStatus.editing,
            currencyCode: mainCurrencyCode,
            openingDate: LocalDate.today(),
            parentAccountId: _defaultParent(accounts)?.id,
          ),
          type,
        ),
      );
      return;
    }
    final account = accounts.byId(id);
    if (account == null) {
      emit(loaded.copyWith(status: AccountFormStatus.notFound));
      return;
    }
    var moved = false;
    for (final each in [id, ...accounts.pocketsOf(id).map((p) => p.id)]) {
      if (await _hasMovements(each) case Ok(value: true)) moved = true;
    }
    final currency = currencies
        .where((c) => c.code == account.currencyCode)
        .firstOrNull;
    String amount(int? minor) => minor == null || currency == null
        ? ''
        : MoneyFormatter.format(Money(minor, currency.code), currency.format);
    final isCard = account.type == AccountType.creditCard;
    emit(
      loaded.copyWith(
        status: AccountFormStatus.editing,
        original: account,
        hasMovements: moved,
        name: account.name,
        iconKey: account.iconKey,
        color: account.color,
        iconChosen: true,
        type: account.type,
        currencyCode: account.currencyCode,
        openingText: amount(
          isCard ? -account.openingBalance : account.openingBalance,
        ),
        openingDate: account.openingDate,
        includeInBalance: account.includeInBalance,
        isMain: account.isMain,
        parentAccountId: account.parentAccountId,
        creditLimitText: amount(account.creditLimit),
        paymentDay: account.paymentDay,
      ),
    );
  }

  void typeChanged(AccountType type) {
    if (state.isEditing) return;
    _change(_withTypeDefaults(state, type));
  }

  void nameChanged(String name) => _change(state.copyWith(name: name));

  void iconChanged(String key, int color) =>
      _change(state.copyWith(iconKey: key, color: color, iconChosen: true));

  void colorChanged(int color) => _change(state.copyWith(color: color));

  void currencyChanged(String code) {
    if (state.currencyLocked) return;
    _change(state.copyWith(currencyCode: code));
  }

  void openingChanged(String text) =>
      _change(state.copyWith(openingText: text));

  void openingDateChanged(LocalDate date) =>
      _change(state.copyWith(openingDate: date));

  void includeInBalanceChanged({required bool value}) =>
      _change(state.copyWith(includeInBalance: value));

  /// The main mark is only set here; it moves away by marking another
  /// account.
  void isMainChanged({required bool value}) {
    if (state.original?.isMain ?? false) return;
    _change(state.copyWith(isMain: value));
  }

  void parentChanged(int id) => _change(state.copyWith(parentAccountId: id));

  void creditLimitChanged(String text) =>
      _change(state.copyWith(creditLimitText: text));

  void paymentDayChanged(int day) => _change(state.copyWith(paymentDay: day));

  /// Validates and saves. Field errors are shown only after the first try.
  Future<void> submit() async {
    final (account, errors) = _read(state);
    if (errors.isNotEmpty) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: AccountFormStatus.saving, errors: {}));
    final result = state.isEditing
        ? await _updateAccount(account)
        : await _createAccount(account);
    _finish(result, AccountFormStatus.saved);
  }

  Future<void> setArchived({required bool archived}) async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: AccountFormStatus.saving));
    _finish(
      await _setArchived(SetAccountArchivedParams(id: id, archived: archived)),
      AccountFormStatus.saved,
    );
  }

  Future<void> delete() async {
    final id = state.original?.id;
    if (id == null) return;
    emit(state.copyWith(status: AccountFormStatus.saving));
    _finish(await _deleteAccount(id), AccountFormStatus.deleted);
  }

  void _finish(Result<void> result, AccountFormStatus done) =>
      emit(switch (result) {
        Ok() => state.copyWith(status: done),
        Err(:final failure) => state.copyWith(
          status: AccountFormStatus.editing,
          failure: failure,
        ),
      });

  void _change(AccountFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  /// Applies the defaults of [type] to a new account: icon and color until
  /// the user picks one, and Balance inclusion (only cash by default).
  AccountFormState _withTypeDefaults(AccountFormState form, AccountType type) {
    final icon = IconCatalog.resolve(type.defaultIconKey);
    return form.copyWith(
      type: type,
      includeInBalance: type == AccountType.cash,
      isMain: false,
      iconKey: form.iconChosen ? form.iconKey : icon.key,
      color: form.iconChosen ? form.color : icon.color.toARGB32(),
    );
  }

  static Account? _defaultParent(List<Account> accounts) {
    final banks = accounts.where(
      (a) => a.type == AccountType.bank && !a.isArchived,
    );
    return banks.where((a) => a.isMain).firstOrNull ?? banks.firstOrNull;
  }

  /// The account the form describes, normalized, and its errors.
  (Account, Set<AccountError>) _read(AccountFormState form) {
    final errors = <AccountError>{};
    final format = form.currency?.format;
    int? amount(String text) =>
        format == null ? null : AmountParser.parse(text, format);
    final isCard = form.type == AccountType.creditCard;
    final opening = amount(form.openingText);
    if (opening == null) errors.add(AccountError.invalidOpeningBalance);
    final limit = isCard ? amount(form.creditLimitText) : null;
    final parent = form.accounts.byId(form.parentAccountId);
    final original = form.original;
    final account = AccountRules.normalize(
      (original ??
              Account(
                name: '',
                iconKey: '',
                color: 0,
                type: form.type,
                currencyCode: '',
                openingBalance: 0,
                openingDate: form.openingDate ?? LocalDate.today(),
              ))
          .copyWith(
            name: form.name,
            iconKey: form.iconKey,
            color: form.color,
            currencyCode: form.currencyCode,
            openingBalance: isCard ? -(opening ?? 0) : opening ?? 0,
            openingDate: form.openingDate ?? LocalDate.today(),
            includeInBalance: form.includeInBalance,
            isMain: form.isMain,
            parentAccountId: form.parentAccountId,
            creditLimit: limit == 0 ? null : limit,
            paymentDay: form.paymentDay,
          ),
      parent: parent,
    );
    errors.addAll(
      AccountRules.validate(
        account,
        parent: parent,
        parentMayBeArchived:
            original != null &&
            original.parentAccountId == form.parentAccountId,
      ),
    );
    return (account, errors);
  }
}
