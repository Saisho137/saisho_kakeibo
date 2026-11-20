import 'package:material_ui/material_ui.dart';

/// Theme of an icon, used to group the icon picker.
enum IconGroup {
  food,
  transport,
  home,
  health,
  shopping,
  leisure,
  education,
  finance,
  people,
  other,
}

/// An icon of the catalog with the color suggested when it is picked.
@immutable
final class CatalogIcon {
  const new({
    required this.key,
    required this.icon,
    required this.color,
    required this.group,
  });

  /// Stable key stored in the database, such as `restaurant`.
  final String key;
  final IconData icon;
  final Color color;
  final IconGroup group;
}

/// Closed catalog of the icons that categories, accounts and debts can use
/// (RT-13). The database stores the [CatalogIcon.key]; every [IconData] here
/// is constant so release builds keep these glyphs after icon tree-shaking.
abstract final class IconCatalog {
  /// Icon used for unknown keys and for Uncategorized.
  static const String fallbackKey = 'help';

  static const List<CatalogIcon> all = [
    // Food
    CatalogIcon(
      key: 'restaurant',
      icon: Icons.restaurant_rounded,
      color: _orange,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'local_pizza',
      icon: Icons.local_pizza_rounded,
      color: _deepOrange,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'fastfood',
      icon: Icons.fastfood_rounded,
      color: _amber,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'local_cafe',
      icon: Icons.local_cafe_rounded,
      color: _brown,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'local_bar',
      icon: Icons.local_bar_rounded,
      color: _purple,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'lunch_dining',
      icon: Icons.lunch_dining_rounded,
      color: _orange,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'shopping_cart',
      icon: Icons.shopping_cart_rounded,
      color: _green,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'bakery_dining',
      icon: Icons.bakery_dining_rounded,
      color: _brown,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'icecream',
      icon: Icons.icecream_rounded,
      color: _pink,
      group: IconGroup.food,
    ),
    CatalogIcon(
      key: 'delivery_dining',
      icon: Icons.delivery_dining_rounded,
      color: _red,
      group: IconGroup.food,
    ),
    // Transport
    CatalogIcon(
      key: 'directions_car',
      icon: Icons.directions_car_rounded,
      color: _blue,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'local_gas_station',
      icon: Icons.local_gas_station_rounded,
      color: _red,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'local_parking',
      icon: Icons.local_parking_rounded,
      color: _indigo,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'toll',
      icon: Icons.toll_rounded,
      color: _blueGrey,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'directions_bus',
      icon: Icons.directions_bus_rounded,
      color: _teal,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'local_taxi',
      icon: Icons.local_taxi_rounded,
      color: _amber,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'two_wheeler',
      icon: Icons.two_wheeler_rounded,
      color: _deepOrange,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'flight',
      icon: Icons.flight_rounded,
      color: _lightBlue,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'train',
      icon: Icons.train_rounded,
      color: _indigo,
      group: IconGroup.transport,
    ),
    CatalogIcon(
      key: 'car_repair',
      icon: Icons.car_repair_rounded,
      color: _blueGrey,
      group: IconGroup.transport,
    ),
    // Home
    CatalogIcon(
      key: 'home',
      icon: Icons.home_rounded,
      color: _teal,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'apartment',
      icon: Icons.apartment_rounded,
      color: _indigo,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'bolt',
      icon: Icons.bolt_rounded,
      color: _amber,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'water_drop',
      icon: Icons.water_drop_rounded,
      color: _lightBlue,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'wifi',
      icon: Icons.wifi_rounded,
      color: _blue,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'phone_android',
      icon: Icons.phone_android_rounded,
      color: _blueGrey,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'local_laundry_service',
      icon: Icons.local_laundry_service_rounded,
      color: _cyan,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'chair',
      icon: Icons.chair_rounded,
      color: _brown,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'cleaning_services',
      icon: Icons.cleaning_services_rounded,
      color: _cyan,
      group: IconGroup.home,
    ),
    CatalogIcon(
      key: 'build',
      icon: Icons.build_rounded,
      color: _grey,
      group: IconGroup.home,
    ),
    // Health
    CatalogIcon(
      key: 'medical_services',
      icon: Icons.medical_services_rounded,
      color: _red,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'local_pharmacy',
      icon: Icons.local_pharmacy_rounded,
      color: _green,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'fitness_center',
      icon: Icons.fitness_center_rounded,
      color: _deepOrange,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'spa',
      icon: Icons.spa_rounded,
      color: _pink,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'content_cut',
      icon: Icons.content_cut_rounded,
      color: _purple,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'favorite',
      icon: Icons.favorite_rounded,
      color: _red,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'psychology',
      icon: Icons.psychology_rounded,
      color: _deepPurple,
      group: IconGroup.health,
    ),
    CatalogIcon(
      key: 'pets',
      icon: Icons.pets_rounded,
      color: _brown,
      group: IconGroup.health,
    ),
    // Shopping
    CatalogIcon(
      key: 'checkroom',
      icon: Icons.checkroom_rounded,
      color: _pink,
      group: IconGroup.shopping,
    ),
    CatalogIcon(
      key: 'shopping_bag',
      icon: Icons.shopping_bag_rounded,
      color: _deepPurple,
      group: IconGroup.shopping,
    ),
    CatalogIcon(
      key: 'devices',
      icon: Icons.devices_rounded,
      color: _blueGrey,
      group: IconGroup.shopping,
    ),
    CatalogIcon(
      key: 'card_giftcard',
      icon: Icons.card_giftcard_rounded,
      color: _red,
      group: IconGroup.shopping,
    ),
    CatalogIcon(
      key: 'diamond',
      icon: Icons.diamond_rounded,
      color: _cyan,
      group: IconGroup.shopping,
    ),
    CatalogIcon(
      key: 'local_mall',
      icon: Icons.local_mall_rounded,
      color: _purple,
      group: IconGroup.shopping,
    ),
    // Leisure
    CatalogIcon(
      key: 'movie',
      icon: Icons.movie_rounded,
      color: _deepPurple,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'sports_esports',
      icon: Icons.sports_esports_rounded,
      color: _indigo,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'music_note',
      icon: Icons.music_note_rounded,
      color: _pink,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'theaters',
      icon: Icons.theaters_rounded,
      color: _purple,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'celebration',
      icon: Icons.celebration_rounded,
      color: _orange,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'beach_access',
      icon: Icons.beach_access_rounded,
      color: _lightBlue,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'sports_soccer',
      icon: Icons.sports_soccer_rounded,
      color: _green,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'live_tv',
      icon: Icons.live_tv_rounded,
      color: _red,
      group: IconGroup.leisure,
    ),
    CatalogIcon(
      key: 'hiking',
      icon: Icons.hiking_rounded,
      color: _lightGreen,
      group: IconGroup.leisure,
    ),
    // Education
    CatalogIcon(
      key: 'school',
      icon: Icons.school_rounded,
      color: _indigo,
      group: IconGroup.education,
    ),
    CatalogIcon(
      key: 'menu_book',
      icon: Icons.menu_book_rounded,
      color: _brown,
      group: IconGroup.education,
    ),
    CatalogIcon(
      key: 'laptop',
      icon: Icons.laptop_rounded,
      color: _blueGrey,
      group: IconGroup.education,
    ),
    CatalogIcon(
      key: 'museum',
      icon: Icons.museum_rounded,
      color: _deepPurple,
      group: IconGroup.education,
    ),
    CatalogIcon(
      key: 'palette',
      icon: Icons.palette_rounded,
      color: _pink,
      group: IconGroup.education,
    ),
    CatalogIcon(
      key: 'language',
      icon: Icons.language_rounded,
      color: _teal,
      group: IconGroup.education,
    ),
    // Finance
    CatalogIcon(
      key: 'payments',
      icon: Icons.payments_rounded,
      color: _green,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'work',
      icon: Icons.work_rounded,
      color: _brown,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'attach_money',
      icon: Icons.attach_money_rounded,
      color: _green,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'monetization_on',
      icon: Icons.monetization_on_rounded,
      color: _amber,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'savings',
      icon: Icons.savings_rounded,
      color: _pink,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'account_balance',
      icon: Icons.account_balance_rounded,
      color: _indigo,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'account_balance_wallet',
      icon: Icons.account_balance_wallet_rounded,
      color: _green,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'credit_card',
      icon: Icons.credit_card_rounded,
      color: _blue,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'trending_up',
      icon: Icons.trending_up_rounded,
      color: _teal,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'trending_down',
      icon: Icons.trending_down_rounded,
      color: _red,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'currency_exchange',
      icon: Icons.currency_exchange_rounded,
      color: _cyan,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'swap_horiz',
      icon: Icons.swap_horiz_rounded,
      color: _blueGrey,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'local_atm',
      icon: Icons.local_atm_rounded,
      color: _lightGreen,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'request_quote',
      icon: Icons.request_quote_rounded,
      color: _deepOrange,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'handshake',
      icon: Icons.handshake_rounded,
      color: _orange,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'percent',
      icon: Icons.percent_rounded,
      color: _red,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'receipt_long',
      icon: Icons.receipt_long_rounded,
      color: _blueGrey,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'redeem',
      icon: Icons.redeem_rounded,
      color: _purple,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'price_check',
      icon: Icons.price_check_rounded,
      color: _teal,
      group: IconGroup.finance,
    ),
    CatalogIcon(
      key: 'money_off',
      icon: Icons.money_off_rounded,
      color: _grey,
      group: IconGroup.finance,
    ),
    // People
    CatalogIcon(
      key: 'child_care',
      icon: Icons.child_care_rounded,
      color: _pink,
      group: IconGroup.people,
    ),
    CatalogIcon(
      key: 'family_restroom',
      icon: Icons.family_restroom_rounded,
      color: _orange,
      group: IconGroup.people,
    ),
    CatalogIcon(
      key: 'volunteer_activism',
      icon: Icons.volunteer_activism_rounded,
      color: _red,
      group: IconGroup.people,
    ),
    CatalogIcon(
      key: 'people',
      icon: Icons.people_rounded,
      color: _blue,
      group: IconGroup.people,
    ),
    // Other
    CatalogIcon(
      key: 'help',
      icon: Icons.help_rounded,
      color: _grey,
      group: IconGroup.other,
    ),
    CatalogIcon(
      key: 'more_horiz',
      icon: Icons.more_horiz_rounded,
      color: _grey,
      group: IconGroup.other,
    ),
    CatalogIcon(
      key: 'label',
      icon: Icons.label_rounded,
      color: _blueGrey,
      group: IconGroup.other,
    ),
    CatalogIcon(
      key: 'star',
      icon: Icons.star_rounded,
      color: _amber,
      group: IconGroup.other,
    ),
  ];

  static final Map<String, CatalogIcon> _byKey = {
    for (final icon in all) icon.key: icon,
  };

  /// The icon for [key], or the fallback when the key is unknown.
  static CatalogIcon resolve(String key) => _byKey[key] ?? _byKey[fallbackKey]!;

  static bool contains(String key) => _byKey.containsKey(key);

  /// Icons of [group], in catalog order.
  static List<CatalogIcon> inGroup(IconGroup group) => [
    for (final icon in all)
      if (icon.group == group) icon,
  ];

  // Suggested colors: Material 600 shades, readable under a white glyph.
  static const Color _red = Color(0xFFE53935);
  static const Color _pink = Color(0xFFD81B60);
  static const Color _purple = Color(0xFF8E24AA);
  static const Color _deepPurple = Color(0xFF5E35B1);
  static const Color _indigo = Color(0xFF3949AB);
  static const Color _blue = Color(0xFF1E88E5);
  static const Color _lightBlue = Color(0xFF039BE5);
  static const Color _cyan = Color(0xFF00ACC1);
  static const Color _teal = Color(0xFF00897B);
  static const Color _green = Color(0xFF43A047);
  static const Color _lightGreen = Color(0xFF7CB342);
  static const Color _amber = Color(0xFFFFB300);
  static const Color _orange = Color(0xFFFB8C00);
  static const Color _deepOrange = Color(0xFFF4511E);
  static const Color _brown = Color(0xFF6D4C41);
  static const Color _blueGrey = Color(0xFF546E7A);
  static const Color _grey = Color(0xFF757575);
}
