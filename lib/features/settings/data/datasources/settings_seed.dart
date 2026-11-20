import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/data/models/currency_row_mapper.dart';
import 'package:saisho_kakeibo/features/settings/data/models/settings_row_mapper.dart';

/// Initial data: COP (main) and USD, plus the default settings row (RF-16).
abstract final class SettingsSeed {
  static const List<Currency> currencies = [
    Currency(
      code: 'COP',
      symbol: r'$',
      format: CurrencyFormat.cop,
      isBuiltIn: true,
    ),
    Currency(
      code: 'USD',
      symbol: r'US$',
      format: CurrencyFormat.usd,
      isBuiltIn: true,
    ),
  ];

  static Future<void> insert(AppDatabase db) async {
    for (final currency in currencies) {
      await db.currencyDao.insertCurrency(currency.toCompanion());
    }
    await db.settingsDao.write(const AppSettings().toCompanion());
  }
}
