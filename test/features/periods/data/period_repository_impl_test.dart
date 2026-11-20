import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/periods/data/repositories/period_repository_impl.dart';

import '../../../helpers/movement_fixtures.dart';

void main() {
  late AppDatabase db;
  late PeriodRepositoryImpl repository;
  late MovementRepositoryImpl movements;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = PeriodRepositoryImpl(db.periodDao);
    movements = MovementRepositoryImpl(db.movementDao);
    final accounts =
        (await AccountRepositoryImpl(db.accountDao).getAccounts()
                as Ok<List<Account>>)
            .value;
    final categories =
        (await CategoryRepositoryImpl(db.categoryDao).getCategories()
                as Ok<List<Category>>)
            .value;
    final salary = categories.firstWhere((c) => c.role == CategoryRole.salary);
    for (final (days, starts) in [(0, true), (5, false), (30, true)]) {
      await movements.save(
        movement(
          type: MovementType.income,
          accountId: accounts.first.id,
          categoryId: salary.id,
          date: movementDay.addDays(days),
        ).copyWith(startsPeriod: starts),
      );
    }
  });

  tearDown(() => db.close());

  group('PeriodRepositoryImpl', () {
    test('joins salary and manual starts, sorted and once', () async {
      await repository.addStart(movementDay.addDays(10));
      await repository.addStart(movementDay.addDays(30));

      expect((await repository.getStarts() as Ok).value, [
        movementDay,
        movementDay.addDays(10),
        movementDay.addDays(30),
      ]);
      expect(repository.watchStarts(), emits(hasLength(3)));
      expect(
        repository.watchManualStarts(),
        emits([movementDay.addDays(30), movementDay.addDays(10)]),
      );
    });

    test('removes a manual start; the salary one stays', () async {
      await repository.addStart(movementDay.addDays(30));
      await repository.removeStart(movementDay.addDays(30));

      expect(repository.watchManualStarts(), emits(isEmpty));
      expect((await repository.getStarts() as Ok).value, [
        movementDay,
        movementDay.addDays(30),
      ]);
    });

    test('rejects a repeated manual start', () async {
      await repository.addStart(movementDay);
      expect(await repository.addStart(movementDay), isA<Err<void>>());
    });
  });
}
