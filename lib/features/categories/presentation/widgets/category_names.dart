import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

extension CategoryTypeName on CategoryType {
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      CategoryType.expense => l10n.categoryTypeExpense,
      CategoryType.income => l10n.categoryTypeIncome,
      CategoryType.transfer => l10n.categoryTypeTransfer,
    };
  }
}

/// Tabs of the Categories screen, in display order.
const List<CategoryType> categoryTabs = [
  CategoryType.expense,
  CategoryType.income,
  CategoryType.transfer,
];
