import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/debt_choice.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/repositories/movement_repository.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/movement_rules.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';

final class SaveMovementParams {
  const new(this.movement, {this.payeeName, this.debt});

  /// A movement with id `0` is created; any other id is replaced.
  final Movement movement;

  /// Payee as typed; it is reused if one with the same key exists (RF-08).
  final String? payeeName;

  /// The debt of a debt category (RF-09); ignored for the others.
  final DebtChoice? debt;
}

/// Creates or edits a movement (RT-04). Archived accounts only keep the
/// movements they already had. Confirming a pending movement of a
/// recurring template copies its amounts to the template (RF-06).
///
/// A debt category needs its debt (RF-09): of its type and currency. A
/// movement on an existing debt takes the debt's payee. A loan received,
/// or a loan given that adds to no debt, creates its debt first; if the
/// movement then fails, that debt is deleted again.
class SaveMovement implements UseCase<Future<Result<int>>, SaveMovementParams> {
  const new({
    required this._movements,
    required this._accounts,
    required this._categories,
    required this._recurring,
    required this._debts,
  });

  final MovementRepository _movements;
  final AccountRepository _accounts;
  final CategoryRepository _categories;
  final RecurringRepository _recurring;
  final DebtRepository _debts;

  @override
  Future<Result<int>> call(SaveMovementParams params) async {
    final List<Account> accounts;
    final List<Category> categories;
    switch ((
      await _accounts.getAccounts(),
      await _categories.getCategories(),
    )) {
      case (Ok(value: final a), Ok(value: final c)):
        (accounts, categories) = (a, c);
      case (Err(:final failure), _) || (_, Err(:final failure)):
        return Err(failure);
    }
    Movement? original;
    if (params.movement.id != 0) {
      final found = await _movements.findById(params.movement.id);
      if (found case Err(:final failure)) return Err(failure);
      original = (found as Ok<Movement?>).value;
      if (original == null) {
        return Err(ValidationFailure('Unknown movement ${params.movement.id}'));
      }
    }

    final account = accounts.byId(params.movement.accountId);
    final toAccount = accounts.byId(params.movement.toAccountId);
    final movement = MovementRules.normalize(
      params.movement,
      account: account,
      toAccount: toAccount,
    );
    final payee = PayeeName.parse(params.payeeName);
    final errors = MovementRules.validate(
      movement,
      account: account,
      toAccount: toAccount,
      category: categories.byId(movement.categoryId),
      hasPayee: payee != null,
    );
    if (errors.isNotEmpty) {
      return Err(ValidationFailure('Invalid movement: $errors'));
    }
    bool newlyUsed(Account? a) =>
        a != null && a.isArchived && original?.involves(a.id) != true;
    if (newlyUsed(account) || newlyUsed(toAccount)) {
      return const Err(ValidationFailure('Archived accounts take no more.'));
    }
    final role = categories.byId(movement.categoryId)!.role;
    final debtType = DebtRules.typeFor(role);
    var toSave = movement.copyWith(payeeId: null, debtId: null);
    var savePayee = payee;
    int? createdDebt;
    if (debtType != null) {
      switch (params.debt) {
        case ExistingDebt(:final id):
          final Debt? debt;
          switch (await _debts.findDebt(id)) {
            case Ok(:final value):
              debt = value;
            case Err(:final failure):
              return Err(failure);
          }
          if (debt == null ||
              debt.type != debtType ||
              debt.currencyCode != account!.currencyCode) {
            return const Err(ValidationFailure('Pick a debt that fits.'));
          }
          toSave = toSave.copyWith(debtId: id, payeeId: debt.payeeId);
          savePayee = null;
        case NewDebt(:final name, :final pillarId, :final initialPending)
            when DebtRules.createsDebt(role):
          if (payee == null) {
            return const Err(ValidationFailure('A new debt needs a payee.'));
          }
          final iOwe = debtType == DebtType.iOwe;
          final category = categories.byId(movement.categoryId)!;
          final debt = DebtRules.normalize(
            Debt(
              type: debtType,
              name: name.trim().isEmpty ? payee.name : name,
              iconKey: category.iconKey,
              color: category.color,
              payeeId: 0,
              currencyCode: account!.currencyCode,
              initialPending: iOwe ? initialPending ?? movement.amount : 0,
              pillarId: pillarId,
              createdOn: movement.date,
            ),
          );
          if (DebtRules.validate(debt, hasPayee: true).isNotEmpty) {
            return const Err(ValidationFailure('Invalid new debt.'));
          }
          switch (await _debts.saveDebt(debt, payee: payee)) {
            case Ok(:final value):
              createdDebt = value;
            case Err(:final failure):
              return Err(failure);
          }
          toSave = toSave.copyWith(debtId: createdDebt);
        case _:
          return const Err(ValidationFailure('This category needs its debt.'));
      }
    }
    final saved = await _movements.save(toSave, payee: savePayee);
    if (saved is Err<int> && createdDebt != null) {
      await _debts.deleteDebt(createdDebt);
    }
    final templateId = movement.recurringTemplateId;
    if (saved is Ok<int> &&
        templateId != null &&
        original?.isPending == true &&
        !movement.isPending) {
      final updated = await _recurring.updateAmount(
        templateId,
        movement.amount,
        movement.toAmount,
      );
      if (updated case Err(:final failure)) return Err(failure);
    }
    return saved;
  }
}
