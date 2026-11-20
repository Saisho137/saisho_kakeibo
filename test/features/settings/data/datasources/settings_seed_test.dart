import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/features/settings/data/models/currency_row_mapper.dart';
import 'package:saisho_kakeibo/features/settings/data/models/settings_row_mapper.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));

  tearDown(() => db.close());

  group('SettingsSeed', () {
    test('creates COP and USD as built-in currencies', () async {
      final currencies = (await db.currencyDao.watchAll().first)
          .map((row) => row.toEntity())
          .toList();

      expect(currencies.map((c) => c.code), ['COP', 'USD']);
      expect(currencies.every((c) => c.isBuiltIn), isTrue);
      expect(currencies[0].format, CurrencyFormat.cop);
      expect(currencies[1].format, CurrencyFormat.usd);
    });

    test('creates the default settings with COP as main currency', () async {
      final settings = (await db.settingsDao.get()).toEntity();

      expect(settings, const AppSettings());
      expect(settings.mainCurrencyCode, 'COP');
    });
  });
}
