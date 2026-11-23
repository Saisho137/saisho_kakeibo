import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// Route paths and names, so navigation never relies on string literals.
abstract final class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String newCurrency = '/settings/currencies/new';
  static const String accounts = '/accounts';
  static const String newAccount = '/accounts/new';
  static const String categories = '/categories';
  static const String recurring = '/recurring';
  static const String debts = '/debts';
  static const String payees = '/payees';

  static String editCurrency(String code) => '/settings/currencies/$code';

  static String accountDetail(int id) => '/accounts/$id';

  static String editAccount(int id) => '/accounts/$id/edit';

  /// Quick entry: the category grid of an income or expense.
  static String entry(MovementType type) => '/entry/${type.name}';

  static String newMovement(
    MovementType type, {
    int? categoryId,
    int? payeeId,
    int? debtId,
  }) => Uri(
    path: '/movements/new',
    queryParameters: {
      'type': type.name,
      'category': ?categoryId?.toString(),
      'payee': ?payeeId?.toString(),
      'debt': ?debtId?.toString(),
    },
  ).toString();

  static String editMovement(int id) => '/movements/$id';

  static String newTransfer({int? fromAccountId}) => fromAccountId == null
      ? '/transfers/new'
      : '/transfers/new?from=$fromAccountId';

  static String editTransfer(int id) => '/transfers/$id';

  static String newCategory(CategoryType type) =>
      '/categories/new?type=${type.name}';

  static String editCategory(int id) => '/categories/$id';

  /// A new template, or one started from the movement [fromMovementId].
  static String newRecurring({int? fromMovementId}) => fromMovementId == null
      ? '/recurring/new'
      : '/recurring/new?from=$fromMovementId';

  static String editRecurring(int id) => '/recurring/$id';

  static String newDebt(DebtType type) => '/debts/new?type=${type.name}';

  static String debtDetail(int id) => '/debts/$id';

  static String editDebt(int id) => '/debts/$id/edit';

  static String payeeDetail(int id) => '/payees/$id';
}
