import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

extension AccountTypeName on AccountType {
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      AccountType.cash => l10n.accountTypeCash,
      AccountType.bank => l10n.accountTypeBank,
      AccountType.creditCard => l10n.accountTypeCreditCard,
      AccountType.investment => l10n.accountTypeInvestment,
      AccountType.pocket => l10n.accountTypePocket,
    };
  }
}

extension AccountGroupName on AccountGroup {
  String label(BuildContext context) {
    final l10n = context.l10n;
    return switch (this) {
      AccountGroup.cashAndBank => l10n.accountGroupCashAndBank,
      AccountGroup.creditCards => l10n.accountGroupCreditCards,
      AccountGroup.investments => l10n.accountGroupInvestments,
    };
  }
}
