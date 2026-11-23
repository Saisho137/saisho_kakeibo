import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:saisho_kakeibo/core/database/converters/local_date_converter.dart';
import 'package:saisho_kakeibo/core/settings/app_settings.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/account_dao.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_seed.dart';
import 'package:saisho_kakeibo/features/accounts/data/datasources/accounts_table.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_seed.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/categories_table.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/category_dao.dart';
import 'package:saisho_kakeibo/features/categories/data/datasources/pillars_table.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debt_dao.dart';
import 'package:saisho_kakeibo/features/debts/data/datasources/debts_table.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movement_dao.dart';
import 'package:saisho_kakeibo/features/movements/data/datasources/movements_table.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payee_dao.dart';
import 'package:saisho_kakeibo/features/payees/data/datasources/payees_table.dart';
import 'package:saisho_kakeibo/features/periods/data/datasources/period_dao.dart';
import 'package:saisho_kakeibo/features/periods/data/datasources/period_starts_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_dao.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_occurrences_table.dart';
import 'package:saisho_kakeibo/features/recurring/data/datasources/recurring_templates_table.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currencies_table.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/currency_dao.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/settings_dao.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/settings_seed.dart';
import 'package:saisho_kakeibo/features/settings/data/datasources/settings_table.dart';

part 'app_database.g.dart';

/// Local SQLite database. Each feature declares its tables and DAOs in its
/// `data/datasources` folder and registers them here. Every schema change
/// bumps [schemaVersion] and adds a migration step.
@DriftDatabase(
  tables: [
    Currencies,
    SettingsTable,
    Accounts,
    Pillars,
    Categories,
    Payees,
    RecurringTemplates,
    Debts,
    Movements,
    PeriodStarts,
    RecurringOccurrences,
  ],
  daos: [
    CurrencyDao,
    SettingsDao,
    AccountDao,
    CategoryDao,
    MovementDao,
    PeriodDao,
    RecurringDao,
    DebtDao,
    PayeeDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  new([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const String databaseName = 'saisho_kakeibo';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await SettingsSeed.insert(this);
      await AccountsSeed.insert(this);
      await CategoriesSeed.insert(this);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  static QueryExecutor _openConnection() => driftDatabase(name: databaseName);
}
