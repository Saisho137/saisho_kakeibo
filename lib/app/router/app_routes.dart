/// Route paths and names, so navigation never relies on string literals.
abstract final class AppRoutes {
  static const String home = '/';
  static const String settings = '/settings';
  static const String newCurrency = '/settings/currencies/new';

  static String editCurrency(String code) => '/settings/currencies/$code';
}
