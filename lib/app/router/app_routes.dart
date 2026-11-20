import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';

/// Route paths and names, so navigation never relies on string literals.
abstract final class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String newCurrency = '/settings/currencies/new';
  static const String accounts = '/accounts';
  static const String newAccount = '/accounts/new';
  static const String categories = '/categories';

  static String editCurrency(String code) => '/settings/currencies/$code';

  static String editAccount(int id) => '/accounts/$id';

  static String newCategory(CategoryType type) =>
      '/categories/new?type=${type.name}';

  static String editCategory(int id) => '/categories/$id';
}
