import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/categories_x.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/category.dart';
import 'package:saisho_kakeibo/features/categories/domain/entities/pillar.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// An expense category of the donut with its share of the period.
@immutable
final class DonutCategory {
  const new({
    required this.category,
    required this.amount,
    required this.share,
  });

  final Category category;
  final int amount;

  /// Fraction of the period's Expenses, from 0 to 1.
  final double share;
}

/// A pillar's border of the donut and the categories it holds. [pillar] is
/// `null` for the gray *No pillar* group (Loan given, Uncategorized).
@immutable
final class DonutPillar {
  const new({
    required this.pillar,
    required this.amount,
    required this.share,
    required this.categories,
  });

  final Pillar? pillar;
  final int amount;
  final double share;
  final List<DonutCategory> categories;
}

/// The Home donut of a period in one currency (RF-02, RF-14).
@immutable
final class DonutData {
  const new({required this.total, required this.pillars});

  /// Groups the expenses in [currencyCode] of [movements] by pillar and
  /// category. Pillars follow their order, *No pillar* last, and leave out
  /// those without expenses; categories go from the largest amount down.
  /// The pillar of a category is resolved now, so a category that changed
  /// pillar moves its whole history (RF-02).
  factory of({
    required Iterable<Movement> movements,
    required List<Account> accounts,
    required List<Category> categories,
    required List<Pillar> pillars,
    required String currencyCode,
  }) {
    final byCategory = <int, int>{};
    var total = 0;
    for (final m in movements) {
      if (m.type != MovementType.expense) continue;
      if (accounts.byId(m.accountId)?.currencyCode != currencyCode) continue;
      final id = m.categoryId;
      if (id == null || categories.byId(id) == null) continue;
      byCategory[id] = (byCategory[id] ?? 0) + m.amount;
      total += m.amount;
    }
    if (total == 0) return const DonutData(total: 0, pillars: []);

    double share(int amount) => amount / total;
    final pillarIds = {for (final p in pillars) p.id};
    final groups = <int?, List<DonutCategory>>{};
    for (final MapEntry(key: id, value: amount) in byCategory.entries) {
      final category = categories.byId(id)!;
      final pillarId = pillarIds.contains(category.pillarId)
          ? category.pillarId
          : null;
      (groups[pillarId] ??= []).add(
        DonutCategory(category: category, amount: amount, share: share(amount)),
      );
    }

    DonutPillar group(Pillar? pillar, List<DonutCategory> list) {
      list.sort((a, b) {
        final byAmount = b.amount.compareTo(a.amount);
        return byAmount != 0
            ? byAmount
            : a.category.sortOrder.compareTo(b.category.sortOrder);
      });
      final amount = list.fold(0, (sum, c) => sum + c.amount);
      return DonutPillar(
        pillar: pillar,
        amount: amount,
        share: share(amount),
        categories: list,
      );
    }

    final ordered = [...pillars]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return DonutData(
      total: total,
      pillars: [
        for (final pillar in ordered)
          if (groups[pillar.id] case final list?) group(pillar, list),
        if (groups[null] case final list?) group(null, list),
      ],
    );
  }

  /// The period's Expenses, which the shares divide.
  final int total;
  final List<DonutPillar> pillars;

  /// No expenses: the donut is an empty gray ring.
  bool get isEmpty => total == 0;
}
