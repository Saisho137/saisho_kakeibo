import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// A price an entity was paid (or paid me) on a day, for its chart.
typedef PayeePrice = ({LocalDate date, int amount});

/// What the incomes and expenses of one entity add up to (RF-08). The
/// movements are expected of that entity and one currency; transfers,
/// adjustments and pending incomes (which wait to be confirmed) are left
/// out.
@immutable
final class PayeeStats {
  const new _({
    required this.count,
    required this.income,
    required this.expense,
    required this.lastCategoryId,
    required this.prices,
  });

  factory of(Iterable<Movement> movements) {
    final counted = [
      for (final m in movements)
        if (m.type == MovementType.expense ||
            (m.type == MovementType.income && !m.isPending))
          m,
    ]..sort(_byDate);
    var income = 0;
    var expense = 0;
    for (final m in counted) {
      if (m.type == MovementType.income) {
        income += m.amount;
      } else {
        expense += m.amount;
      }
    }
    // Its prices are what it is paid; only an entity that just pays me,
    // such as an employer, charts its incomes.
    final priced = expense > 0 || income == 0
        ? MovementType.expense
        : MovementType.income;
    return PayeeStats._(
      count: counted.length,
      income: income,
      expense: expense,
      lastCategoryId: counted.lastOrNull?.categoryId,
      prices: [
        for (final m in counted)
          if (m.type == priced) (date: m.date, amount: m.amount),
      ],
    );
  }

  static const PayeeStats empty = PayeeStats._(
    count: 0,
    income: 0,
    expense: 0,
    lastCategoryId: null,
    prices: [],
  );

  /// Movements counted.
  final int count;
  final int income;
  final int expense;

  /// Category of the latest movement, for the entity's icon.
  final int? lastCategoryId;

  /// Prices from the oldest to the newest.
  final List<PayeePrice> prices;

  /// Incomes less expenses: positive when the entity pays me more.
  int get net => income - expense;

  /// Mean of [prices], rounded; `null` without prices.
  int? get averagePrice => prices.isEmpty
      ? null
      : (prices.fold(0, (sum, p) => sum + p.amount) / prices.length).round();

  int? get lastPrice => prices.lastOrNull?.amount;

  static int _byDate(Movement a, Movement b) {
    final byDate = a.date.compareTo(b.date);
    return byDate != 0 ? byDate : a.id.compareTo(b.id);
  }
}
