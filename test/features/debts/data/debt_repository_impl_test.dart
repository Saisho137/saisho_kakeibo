import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/debts/data/repositories/debt_repository_impl.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';

import '../../../helpers/debt_fixtures.dart';
import '../../../helpers/movement_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  late AppDatabase db;
  late DebtRepositoryImpl repository;
  late MovementRepositoryImpl movements;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DebtRepositoryImpl(db.debtDao);
    movements = MovementRepositoryImpl(db.movementDao);
  });

  tearDown(() => db.close());

  Future<Debt> stored() async {
    final id = (await repository.saveDebt(
      debt(id: 0, payeeId: 0, dueDate: LocalDate(2026, 6, 1)),
      payee: PayeeName.parse('Bancolombia'),
    ) as Ok<int>).value;
    return (await repository.findDebt(id) as Ok<Debt?>).value!;
  }

  group('DebtRepositoryImpl', () {
    test('saves, finds, watches and updates a debt', () async {
      final d = await stored();

      expect(d.payeeId, isNot(0));
      expect(d.pillarId, 1);
      expect(d.dueDate, LocalDate(2026, 6, 1));
      expect(repository.watchDebts(), emits([d]));
      expect((await repository.getDebts() as Ok).value, [d]);

      await repository.saveDebt(d.copyWith(adjustment: -5));
      expect(
        ((await repository.findDebt(d.id)) as Ok<Debt?>).value!.adjustment,
        -5,
      );
    });

    test('lists its movements and blocks deleting a used debt', () async {
      final d = await stored();
      final accounts =
          (await AccountRepositoryImpl(db.accountDao).getAccounts()
                  as Ok<List<Account>>)
              .value;
      final categories =
          (await CategoryRepositoryImpl(db.categoryDao).getCategories()
                  as Ok<List<Category>>)
              .value;
      await movements.save(
        movement(
          accountId: accounts.first.id,
          categoryId: categories
              .firstWhere((c) => c.role == CategoryRole.debtPayment)
              .id,
        ).copyWith(debtId: d.id),
      );

      expect((await repository.getMovements(d.id) as Ok).value, hasLength(1));
      expect(await repository.deleteDebt(d.id), isA<Err<void>>());
    });

    test('a renamed debt moves its movements and templates along', () async {
      final d = await stored();
      final accounts =
          (await AccountRepositoryImpl(db.accountDao).getAccounts()
                  as Ok<List<Account>>)
              .value;
      final categories =
          (await CategoryRepositoryImpl(db.categoryDao).getCategories()
                  as Ok<List<Category>>)
              .value;
      final paymentId = categories
          .firstWhere((c) => c.role == CategoryRole.debtPayment)
          .id;
      await movements.save(
        movement(
          accountId: accounts.first.id,
          categoryId: paymentId,
        ).copyWith(debtId: d.id, payeeId: d.payeeId),
      );
      final recurring = RecurringRepositoryImpl(db.recurringDao);
      await recurring.saveTemplate(
        template(
          id: 0,
          categoryId: paymentId,
          accountId: accounts.first.id,
          payeeId: d.payeeId,
        ).copyWith(debtId: d.id),
      );

      await repository.saveDebt(
        d.copyWith(name: 'Mortgage Bancolombia'),
        payee: PayeeName.parse('Mortgage Bancolombia'),
      );
      final renamed = (await repository.findDebt(d.id) as Ok<Debt?>).value!;
      expect(renamed.payeeId, isNot(d.payeeId));
      final paid = (await repository.getMovements(
        d.id,
      ) as Ok<List<Movement>>).value.single;
      expect(paid.payeeId, renamed.payeeId);
      final templates =
          (await recurring.getTemplates() as Ok<List<RecurringTemplate>>).value;
      expect(templates.single.payeeId, renamed.payeeId);
    });

    test('deletes an unused debt', () async {
      final d = await stored();
      await repository.deleteDebt(d.id);
      expect(await repository.watchDebts().first, isEmpty);
    });
  });
}
