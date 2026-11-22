import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/core/database/app_database.dart';
import 'package:saisho_kakeibo/core/error/result.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/accounts/data/repositories/account_repository_impl.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/categories/data/repositories/category_repository_impl.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/movements/data/repositories/movement_repository_impl.dart';
import 'package:saisho_kakeibo/features/payees/domain/rules/payee_rules.dart';
import 'package:saisho_kakeibo/features/recurring/data/repositories/recurring_repository_impl.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_occurrence.dart';
import 'package:saisho_kakeibo/features/recurring/domain/entities/recurring_template.dart';
import 'package:saisho_kakeibo/features/recurring/domain/services/recurring_planner.dart';

import '../../../helpers/account_fixtures.dart';
import '../../../helpers/recurring_fixtures.dart';

void main() {
  late AppDatabase db;
  late RecurringRepositoryImpl repository;
  late MovementRepositoryImpl movements;
  late AccountRepositoryImpl accounts;
  late CategoryRepositoryImpl categories;
  late int bank;
  late int food;
  late int car;

  final start = LocalDate(2026, 3, 23);

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = RecurringRepositoryImpl(db.recurringDao);
    movements = MovementRepositoryImpl(db.movementDao);
    accounts = AccountRepositoryImpl(db.accountDao);
    categories = CategoryRepositoryImpl(db.categoryDao);
    final stored = (await accounts.getAccounts() as Ok<List<Account>>).value;
    bank = stored.firstWhere((a) => a.isMain).id;
    final all = (await categories.getCategories() as Ok<List<Category>>).value;
    food = all.firstWhere((c) => c.name == 'Eating out').id;
    car = all.firstWhere((c) => c.name == 'Car').id;
  });

  tearDown(() => db.close());

  Future<RecurringTemplate> stored({String? payee}) async {
    final id = (await repository.saveTemplate(
      template(id: 0, accountId: bank, categoryId: food),
      payee: PayeeName.parse(payee),
    ) as Ok<int>).value;
    return (await repository.findTemplate(id) as Ok<RecurringTemplate?>).value!;
  }

  PlannedOccurrence occurrence(RecurringTemplate t) => PlannedOccurrence(
    templateId: t.id,
    periodStart: start,
    movement: t.toMovement(start),
  );

  group('RecurringRepositoryImpl', () {
    test('saves, finds, watches and updates a template', () async {
      final t = await stored(payee: 'netflix');

      expect(t.accountId, bank);
      expect(t.payeeId, isNotNull);
      expect(repository.watchTemplates(), emits([t]));
      expect((await repository.getTemplates() as Ok).value, [t]);

      await repository.saveTemplate(t.copyWith(amount: 2000, isActive: false));
      await repository.updateAmount(t.id, 3000, null);
      final updated = (await repository.findTemplate(
        t.id,
      ) as Ok<RecurringTemplate?>).value!;
      expect(updated.amount, 3000);
      expect(updated.isActive, isFalse);
    });

    test('materializes once per period, even after a cancel', () async {
      final t = await stored();

      expect((await repository.materialize([occurrence(t)]) as Ok).value, 1);
      final occurrences =
          (await repository.getOccurrences() as Ok<List<RecurringOccurrence>>)
              .value;
      expect(occurrences.single.periodStart, start);
      expect(occurrences.single.isPending, isTrue);
      final created = (await movements.watchAll().first).single;
      expect(created.isPending, isTrue);
      expect(created.recurringTemplateId, t.id);

      await movements.delete(created.id);
      final cancelled =
          (await repository.getOccurrences() as Ok<List<RecurringOccurrence>>)
              .value
              .single;
      expect(cancelled.movementId, isNull);
      expect(cancelled.isPending, isFalse);
      expect((await repository.materialize([occurrence(t)]) as Ok).value, 0);
      expect(await movements.watchAll().first, isEmpty);
    });

    test('deleting a template keeps its movements', () async {
      final t = await stored();
      await repository.materialize([occurrence(t)]);

      await repository.deleteTemplate(t.id);

      expect(await repository.watchTemplates().first, isEmpty);
      expect((await repository.getOccurrences() as Ok).value, isEmpty);
      final movement = (await movements.watchAll().first).single;
      expect(movement.recurringTemplateId, isNull);
    });

    test('deleting its account deletes the template', () async {
      final id = (await accounts.create(
        account(id: 0, name: 'Lulo'),
      ) as Ok<int>).value;
      await repository.saveTemplate(
        template(id: 0, accountId: id, categoryId: food),
      );

      await accounts.delete([id]);

      expect(await repository.watchTemplates().first, isEmpty);
    });

    test('a category counts its templates and hands them over', () async {
      final t = await stored();

      expect((await categories.countMovements(food) as Ok).value, 1);
      await categories.delete(food, reassignTo: car);

      final moved = (await repository.findTemplate(
        t.id,
      ) as Ok<RecurringTemplate?>).value!;
      expect(moved.categoryId, car);
    });

    test('keeps the cadence and the due day', () async {
      final id = (await repository.saveTemplate(
        template(
          id: 0,
          accountId: bank,
          categoryId: food,
          cadence: RecurringCadence.monthly,
          dueDay: 12,
          remind: true,
        ),
      ) as Ok<int>).value;
      final t =
          (await repository.findTemplate(id) as Ok<RecurringTemplate?>).value!;
      expect(t.cadence, RecurringCadence.monthly);
      expect(t.dueDay, 12);
      expect(t.remind, isTrue);
    });

    test('repairs move and drop occurrences with their movements', () async {
      final t = await stored();
      final other = start.addDays(-30);
      await repository.materialize([
        occurrence(t),
        PlannedOccurrence(
          templateId: t.id,
          periodStart: other,
          movement: t.toMovement(other),
        ),
      ]);
      final occurrences =
          (await repository.getOccurrences() as Ok<List<RecurringOccurrence>>)
              .value;
      final current = occurrences.firstWhere((o) => o.periodStart == start);
      final old = occurrences.firstWhere((o) => o.periodStart == other);
      final moved = start.addDays(-2);

      await repository.repair([
        MoveOccurrence(
          current.id,
          periodStart: moved,
          movementId: current.movementId,
          date: moved,
        ),
        DropOccurrence(old.id, pendingMovementId: old.movementId),
      ]);

      final left =
          (await repository.getOccurrences() as Ok<List<RecurringOccurrence>>)
              .value;
      expect(left.single.periodStart, moved);
      expect((await movements.watchAll().first).single.date, moved);
    });
  });
}
