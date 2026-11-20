import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_seed.dart';
import 'package:saisho_kakeibo/features/accounts/data/models/account_row_mapper.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';

void main() {
  group('AccountsSeed', () {
    test('creates Cash and a main Bank account in the Balance', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      final accounts = (await db.accountDao.getAll()).map((r) => r.toEntity());

      expect(accounts.map((a) => (a.name, a.type, a.isMain)), [
        ('Cash', AccountType.cash, false),
        ('Bank', AccountType.bank, true),
      ]);
      for (final account in accounts) {
        expect(account.currencyCode, 'COP');
        expect(account.includeInBalance, isTrue);
        expect(account.openingBalance, 0);
        expect(account.openingDate, LocalDate.today());
      }
    });

    test('suggests the icon of each type', () {
      final accounts = AccountsSeed.accounts(LocalDate(2026, 1, 1));

      expect(accounts.map((a) => a.iconKey), ['payments', 'account_balance']);
      expect(accounts.map((a) => a.sortOrder), [0, 1]);
    });
  });
}
