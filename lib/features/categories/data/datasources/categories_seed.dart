import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/icons/color_variants.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/features/categories/data/models/category_row_mapper.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';

/// The four pillars (RF-02) and the default categories (RF-13): core ones
/// with their role, and custom ones the user can delete. Names are the ones
/// of "Nombres en la app" in the vault.
abstract final class CategoriesSeed {
  /// Pillar names and colors, in display order.
  static const List<(String, Color)> pillars = [
    ('Survival', Color(0xFF1E88E5)),
    ('Leisure', Color(0xFFD81B60)),
    ('Culture', Color(0xFF5E35B1)),
    ('Extras', Color(0xFFFFB300)),
  ];

  /// Index in [pillars] of each default custom expense.
  static const int _survival = 0;
  static const int _leisure = 1;
  static const int _extras = 3;

  static const List<_Seed> _categories = [
    // Income
    _Seed(CategoryType.income, 'Salary', 'work', CategoryRole.salary),
    _Seed(CategoryType.income, 'Bonus', 'redeem'),
    _Seed(CategoryType.income, 'Returns', 'trending_up'),
    _Seed(CategoryType.income, 'Extra income', 'attach_money'),
    _Seed(
      CategoryType.income,
      'Loan received',
      'request_quote',
      CategoryRole.loanReceived,
    ),
    _Seed(
      CategoryType.income,
      'Loan repaid',
      'price_check',
      CategoryRole.loanRepaid,
    ),
    // Expense
    _Seed(CategoryType.expense, 'Eating out', 'restaurant', null, _leisure),
    _Seed(CategoryType.expense, 'Car', 'directions_car', null, _survival),
    _Seed(CategoryType.expense, 'Clothes', 'checkroom', null, _leisure),
    _Seed(CategoryType.expense, 'Interest & fees', 'percent', null, _extras),
    _Seed(
      CategoryType.expense,
      'Debt payment',
      'receipt_long',
      CategoryRole.debtPayment,
    ),
    _Seed(
      CategoryType.expense,
      'Loan given',
      'handshake',
      CategoryRole.loanGiven,
    ),
    _Seed(
      CategoryType.expense,
      'Uncategorized',
      IconCatalog.fallbackKey,
      CategoryRole.uncategorized,
    ),
    // Transfer
    _Seed(CategoryType.transfer, 'Savings', 'savings', CategoryRole.savings),
    _Seed(
      CategoryType.transfer,
      'Savings withdrawal',
      'account_balance_wallet',
      CategoryRole.savingsWithdrawal,
    ),
    _Seed(
      CategoryType.transfer,
      'Investing',
      'trending_up',
      CategoryRole.investing,
    ),
    _Seed(
      CategoryType.transfer,
      'Investment withdrawal',
      'trending_down',
      CategoryRole.investmentWithdrawal,
    ),
    _Seed(
      CategoryType.transfer,
      'Card payment',
      'credit_card',
      CategoryRole.cardPayment,
    ),
    _Seed(
      CategoryType.transfer,
      'Cash advance',
      'local_atm',
      CategoryRole.cashAdvance,
    ),
    _Seed(
      CategoryType.transfer,
      'Cash withdrawal',
      'payments',
      CategoryRole.cashWithdrawal,
    ),
    _Seed(
      CategoryType.transfer,
      'Currency exchange',
      'currency_exchange',
      CategoryRole.currencyExchange,
    ),
    _Seed(
      CategoryType.transfer,
      'Between accounts',
      'swap_horiz',
      CategoryRole.betweenAccounts,
    ),
  ];

  /// Default categories, given the ids of [pillars] in order. Colors are
  /// the icon's suggested one, or a close free variant inside each type.
  static List<Category> categories(List<int> pillarIds) {
    final result = <Category>[];
    for (final seed in _categories) {
      final role = seed.role ?? CategoryRole.custom;
      final suggested = IconCatalog.resolve(seed.iconKey).color;
      final inUse = result.colorsInUse(seed.type).map(Color.new);
      result.add(
        Category(
          type: seed.type,
          role: role,
          name: seed.name,
          iconKey: seed.iconKey,
          color: ColorVariants.closestFree(suggested, inUse).toARGB32(),
          pillarId: switch (seed.pillar) {
            final index? => pillarIds[index],
            null => null,
          },
          defaultName: role.isCore ? seed.name : null,
          defaultIconKey: role.isCore ? seed.iconKey : null,
          sortOrder: result.nextSortOrder(seed.type),
        ),
      );
    }
    return result;
  }

  static Future<void> insert(AppDatabase db) async {
    final dao = db.categoryDao;
    final pillarIds = [
      for (final (index, (name, color)) in pillars.indexed)
        await dao.createPillar(
          PillarsCompanion.insert(
            name: name,
            color: color.toARGB32(),
            sortOrder: index,
          ),
        ),
    ];
    for (final category in categories(pillarIds)) {
      await dao.create(category.toInsertCompanion());
    }
  }
}

final class _Seed {
  const new(this.type, this.name, this.iconKey, [this.role, this.pillar]);

  final CategoryType type;
  final String name;
  final String iconKey;
  final CategoryRole? role;
  final int? pillar;
}
