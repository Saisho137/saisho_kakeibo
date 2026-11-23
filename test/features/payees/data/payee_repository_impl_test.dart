import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/data/repositories/debt_repository_impl.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/data/repositories/payee_repository_impl.dart';
import 'package:saisho_kakeibo/features/payees/domain/entities/payee.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  late AppDatabase db;
  late PayeeRepositoryImpl repository;
  late MovementRepositoryImpl movements;
  late RecurringRepositoryImpl recurring;
  late DebtRepositoryImpl debts;
  late int accountId;
  late int categoryId;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = PayeeRepositoryImpl(db.payeeDao);
    movements = MovementRepositoryImpl(db.movementDao);
    recurring = RecurringRepositoryImpl(db.recurringDao);
    debts = DebtRepositoryImpl(db.debtDao);
    accountId =
        (await AccountRepositoryImpl(db.accountDao).getAccounts()
                as Ok<List<Account>>)
            .value
            .first
            .id;
    categoryId =
        (await CategoryRepositoryImpl(db.categoryDao).getCategories()
                as Ok<List<Category>>)
            .value
            .firstWhere((c) => c.type == CategoryType.expense)
            .id;
  });

  tearDown(() => db.close());

  /// Saves a movement and a template with the payee [name]; returns its id.
  Future<int> used(String name) async {
    await movements.save(
      movement(accountId: accountId, categoryId: categoryId),
      payee: PayeeName.parse(name),
    );
    final payee = (await movements.getPayees() as Ok<List<Payee>>).value
        .firstWhere((p) => p.name == name);
    await recurring.saveTemplate(
      template(
        id: 0,
        accountId: accountId,
        categoryId: categoryId,
        payeeId: payee.id,
      ),
    );
    return payee.id;
  }

  Future<List<Payee>> payees() async =>
      (await movements.getPayees() as Ok<List<Payee>>).value;

  Future<List<Movement>> all() async =>
      (await movements.getAll() as Ok<List<Movement>>).value;

  Future<List<RecurringTemplate>> templates() async =>
      (await recurring.getTemplates() as Ok<List<RecurringTemplate>>).value;

  group('PayeeRepositoryImpl', () {
    test('renames an entity and the debt that is it', () async {
      await debts.saveDebt(
        debt(id: 0, payeeId: 0),
        payee: PayeeName.parse('Mortgage'),
      );
      final id = (await payees()).single.id;

      await repository.rename(id, PayeeName.parse('Mortgage Bancolombia')!);
      expect((await payees()).single.key, 'mortgagebancolombia');
      final renamed = (await debts.getDebts() as Ok<List<Debt>>).value.single;
      expect(renamed.name, 'Mortgage Bancolombia');
    });

    test('merges movements, templates and debts into another', () async {
      final from = await used('Peaje Las Palmas');
      final into = await used('Peaje Palmas');
      await debts.saveDebt(
        debt(id: 0, payeeId: 0, name: 'Peaje Las Palmas'),
        payee: PayeeName.parse('Peaje Las Palmas'),
      );

      await repository.merge(from: from, into: into);
      expect((await payees()).map((p) => p.id), [into]);
      expect((await all()).map((m) => m.payeeId), [into, into]);
      expect((await templates()).map((t) => t.payeeId), [into, into]);
      final moved = (await debts.getDebts() as Ok<List<Debt>>).value.single;
      expect((moved.payeeId, moved.name), (into, 'Peaje Palmas'));
    });

    test('deletes an entity, keeping its movements without one', () async {
      final id = await used('Uber');
      await repository.delete(id);
      expect(await payees(), isEmpty);
      expect((await all()).single.payeeId, isNull);
      expect((await templates()).single.payeeId, isNull);
    });
  });
}
