import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/money/amount_parser.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/categories/domain/usecases/get_pillars.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/get_debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/usecases/save_debt.dart';
import 'package:saisho_kakeibo/features/movements/domain/usecases/get_payees.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/settings/domain/usecases/get_currencies.dart';

part 'debt_form_cubit.freezed.dart';
part 'debt_form_state.dart';

/// Creates or edits a debt registered on the Debts screen (RF-09), such as
/// a mortgage that never went through an account.
class DebtFormCubit extends Cubit<DebtFormState> {
  new({
    required this._getDebt,
    required this._getPillars,
    required this._getCurrencies,
    required this._getPayees,
    required this._debts,
    required this._saveDebt,
  }) : super(const DebtFormState());

  final GetDebt _getDebt;
  final GetPillars _getPillars;
  final GetCurrencies _getCurrencies;
  final GetPayees _getPayees;
  final DebtRepository _debts;
  final SaveDebt _saveDebt;

  static const String newIconKey = 'request_quote';

  /// Loads the debt [id], or starts a new one of [type] in [settings]'
  /// main currency.
  Future<void> load({
    int? id,
    DebtType type = DebtType.iOwe,
    AppSettings settings = const AppSettings(),
  }) async {
    final List<Pillar> pillars;
    final List<Currency> currencies;
    final List<Payee> payees;
    switch ((
      await _getPillars(const NoParams()),
      await _getCurrencies(const NoParams()),
      await _getPayees(const NoParams()),
    )) {
      case (Ok(value: final p), Ok(value: final c), Ok(value: final pa)):
        (pillars, currencies, payees) = (p, c, pa);
      case (Err(:final failure), _, _) ||
          (_, Err(:final failure), _) ||
          (_, _, Err(:final failure)):
        emit(state.copyWith(status: DebtFormStatus.notFound, failure: failure));
        return;
    }
    final icon = IconCatalog.resolve(newIconKey);
    final loaded = state.copyWith(
      status: DebtFormStatus.editing,
      pillars: pillars,
      currencies: currencies,
      payees: payees,
      type: type,
      currencyCode: settings.mainCurrencyCode,
      iconKey: icon.key,
      color: icon.color.toARGB32(),
    );
    if (id == null) return emit(loaded);

    final found = await _getDebt(id);
    if (found case Ok(value: final debt?)) {
      final movements = await _debts.getMovements(id);
      final form = loaded.copyWith(
        original: debt,
        type: debt.type,
        name: debt.name,
        iconKey: debt.iconKey,
        color: debt.color,
        payeeName: payees.where((p) => p.id == debt.payeeId).firstOrNull?.name,
        currencyCode: debt.currencyCode,
        pillarId: debt.pillarId,
        dueDay: debt.dueDay,
        dueDate: debt.dueDate,
        currencyLocked: switch (movements) {
          Ok(:final value) => value.isNotEmpty,
          Err() => true,
        },
      );
      String text(int? amount) => amount == null
          ? ''
          : MoneyFormatter.format(
              Money(amount, debt.currencyCode),
              form.format,
            );
      emit(
        form.copyWith(
          pendingText: text(debt.initialPending),
          installmentText: text(debt.installment),
        ),
      );
    } else {
      emit(loaded.copyWith(status: DebtFormStatus.notFound));
    }
  }

  /// Only a new debt picks its type.
  void typeChanged(DebtType type) {
    if (state.isEditing) return;
    _change(state.copyWith(type: type));
  }

  void nameChanged(String name) => _change(state.copyWith(name: name));

  void iconChanged(String key, int color) =>
      _change(state.copyWith(iconKey: key, color: color));

  void colorChanged(int color) => _change(state.copyWith(color: color));

  void payeeChanged(String name) => _change(state.copyWith(payeeName: name));

  void currencyChanged(String code) {
    if (state.currencyLocked) return;
    _change(state.copyWith(currencyCode: code));
  }

  void pendingChanged(String text) =>
      _change(state.copyWith(pendingText: text));

  void pillarChanged(int? id) => _change(state.copyWith(pillarId: id));

  void installmentChanged(String text) =>
      _change(state.copyWith(installmentText: text));

  void dueDayChanged(int? day) => _change(state.copyWith(dueDay: day));

  void dueDateChanged(LocalDate? date) =>
      _change(state.copyWith(dueDate: date));

  Future<void> submit() async {
    final (debt, errors) = _read(state);
    if (debt == null) {
      emit(state.copyWith(errors: errors, showErrors: true));
      return;
    }
    emit(state.copyWith(status: DebtFormStatus.saving));
    final payeeName = state.payeeName;
    final result = await _saveDebt(SaveDebtParams(debt, payeeName: payeeName));
    emit(switch (result) {
      Ok() => state.copyWith(status: DebtFormStatus.saved),
      Err(:final failure) => state.copyWith(
        status: DebtFormStatus.editing,
        failure: failure,
      ),
    });
  }

  void _change(DebtFormState next) =>
      emit(next.copyWith(errors: next.showErrors ? _read(next).$2 : const {}));

  /// The debt the form describes and its errors; `null` while not valid.
  static (Debt?, Set<DebtError>) _read(DebtFormState form) {
    final pending = AmountParser.parse(form.pendingText, form.format);
    // An unreadable installment becomes 0, which the rules reject.
    final installment = form.installmentText.trim().isEmpty
        ? null
        : AmountParser.parse(form.installmentText, form.format) ?? 0;
    final debt = DebtRules.normalize(
      (form.original ??
              Debt(
                type: form.type,
                name: '',
                iconKey: form.iconKey,
                color: form.color,
                payeeId: 0,
                currencyCode: form.currencyCode,
                initialPending: 0,
                createdOn: LocalDate.today(),
              ))
          .copyWith(
            name: form.name,
            iconKey: form.iconKey,
            color: form.color,
            currencyCode: form.currencyCode,
            initialPending: pending ?? -1,
            pillarId: form.pillarId,
            installment: installment,
            dueDay: form.dueDay,
            dueDate: form.dueDate,
          ),
    );
    final typed = form.payeeName?.trim() ?? '';
    final errors = DebtRules.validate(debt, hasPayee: typed.isNotEmpty);
    return (errors.isEmpty ? debt : null, errors);
  }
}
