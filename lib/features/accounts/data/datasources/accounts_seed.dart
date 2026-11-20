import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/icons/icon_catalog.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/models/account_row_mapper.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

/// Initial accounts: Cash and a main Bank account, both in the Balance and
/// in the main currency, opening at zero today.
abstract final class AccountsSeed {
  static List<Account> accounts(LocalDate today) => [
    for (final (index, (name, type)) in const [
      ('Cash', AccountType.cash),
      ('Bank', AccountType.bank),
    ].indexed)
      Account(
        name: name,
        iconKey: type.defaultIconKey,
        color: IconCatalog.resolve(type.defaultIconKey).color.toARGB32(),
        type: type,
        currencyCode: const AppSettings().mainCurrencyCode,
        openingBalance: 0,
        openingDate: today,
        includeInBalance: true,
        isMain: type == AccountType.bank,
        sortOrder: index,
      ),
  ];

  static Future<void> insert(AppDatabase db) async {
    for (final account in accounts(LocalDate.today())) {
      await db.accountDao.create(account.toInsertCompanion());
    }
  }
}
