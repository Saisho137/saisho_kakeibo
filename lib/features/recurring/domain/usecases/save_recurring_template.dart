import 'package:saisho_kakeibo/core/error/failure.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/usecase/usecase.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/accounts/domain/repositories/account_repository.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/repositories/category_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/repositories/debt_repository.dart';
import 'package:saisho_kakeibo/features/debts/domain/rules/debt_rules.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/repositories/recurring_repository.dart';
import 'package:saisho_kakeibo/features/recurring/domain/rules/recurring_rules.dart';

final class SaveRecurringTemplateParams {
  const new(this.template, {this.payeeName});

  /// A template with id `0` is created; any other id is replaced.
  final RecurringTemplate template;

  /// Payee as typed; it is reused if one with the same key exists (RF-08).
  final String? payeeName;
}

/// Creates or edits a recurring template (RF-06). Its accounts must be
/// active, as it keeps creating movements in them. Loans never repeat; a
/// Debt payment or Loan repaid template pays or collects a debt of its type
/// and currency, and takes the debt's payee (RF-09).
class SaveRecurringTemplate
    implements UseCase<Future<Result<int>>, SaveRecurringTemplateParams> {
  const new({
    required this._recurring,
    required this._accounts,
    required this._categories,
    required this._debts,
  });

  final RecurringRepository _recurring;
  final AccountRepository _accounts;
  final CategoryRepository _categories;
  final DebtRepository _debts;

  @override
  Future<Result<int>> call(SaveRecurringTemplateParams params) async {
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
    final payee = params.template.type == MovementType.transfer
        ? null
        : PayeeName.parse(params.payeeName);
    final template = RecurringRules.normalize(params.template);
    final account = accounts.byId(template.accountId);
    final toAccount = accounts.byId(template.toAccountId);
    final errors = RecurringRules.validate(
      template,
      account: account,
      toAccount: toAccount,
      category: categories.byId(template.categoryId),
      hasPayee: payee != null,
    );
    if (errors.isNotEmpty || !RecurringRules.isValidDueDay(template.dueDay)) {
      return Err(ValidationFailure('Invalid template: $errors'));
    }
    if ((account?.isArchived ?? false) || (toAccount?.isArchived ?? false)) {
      return const Err(ValidationFailure('Archived accounts take no more.'));
    }
    final role = categories.byId(template.categoryId)!.role;
    if (!RecurringRules.allows(role)) {
      return const Err(ValidationFailure('Loans do not repeat.'));
    }
    final debtType = DebtRules.typeFor(role);
    if (debtType == null) {
      return await _recurring.saveTemplate(
        template.copyWith(payeeId: null, debtId: null),
        payee: payee,
      );
    }
    final id = template.debtId;
    if (id == null) {
      return const Err(ValidationFailure('This category needs its debt.'));
    }
    switch (await _debts.findDebt(id)) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: final debt?)
          when debt.type == debtType &&
              debt.currencyCode == account?.currencyCode:
        return await _recurring.saveTemplate(
          template.copyWith(payeeId: debt.payeeId),
        );
      case Ok():
        return const Err(ValidationFailure('Pick a debt that fits.'));
    }
  }
}
