import 'package:meta/meta.dart';
import 'package:saisho_kakeibo/features/debts/domain/entities/debt.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';

/// What is pending on a debt, from the movements that reference it
/// (RF-09). The app computes no interest: the pending amount is the one
/// registered, less the payments, plus what was lent again, plus the
/// manual corrections.
///
/// - **I owe:** expenses (Debt payment) pay it. The income that created
///   it (Loan received) is already in its initial pending.
/// - **Owed to me:** incomes (Loan repaid) collect it; expenses (Loan
///   given) lend more. A debt created by a loan starts at 0 and the loan
///   itself adds its amount.
///
/// Pending incomes wait for their confirmation; pending expenses count, as
/// they move the balance.
@immutable
final class DebtStatus {
  const new({
    required this.pending,
    required this.paid,
    required this.payments,
  });

  factory of(Debt debt, Iterable<Movement> movements) {
    var lent = 0;
    var paid = 0;
    final payments = <Movement>[];
    for (final m in movements) {
      if (m.debtId != debt.id) continue;
      final isPayment = debt.iOwe
          ? m.type == MovementType.expense
          : m.type == MovementType.income && !m.isPending;
      if (isPayment) {
        paid += m.amount;
        payments.add(m);
      } else if (!debt.iOwe && m.type == MovementType.expense) {
        lent += m.amount;
        payments.add(m);
      }
    }
    return DebtStatus(
      pending: debt.initialPending + debt.adjustment + lent - paid,
      paid: paid,
      payments: payments,
    );
  }

  /// Can go below 0 when more was paid than pending.
  final int pending;

  /// Payments made, or collected for a debt owed to me.
  final int paid;

  /// The movements that changed it, in the order given.
  final List<Movement> payments;

  /// Paid off when nothing is left (RF-09).
  bool get isPaidOff => pending <= 0;

  /// Fraction paid of what was paid plus what is left, from 0 to 1.
  double get progress {
    final total = paid + (pending > 0 ? pending : 0);
    return total == 0 ? 1 : paid / total;
  }

  /// The adjustment that makes the pending amount [target], keeping the
  /// payments (RF-09: "Edit pending" moves no money).
  int adjustmentFor(Debt debt, int target) =>
      debt.adjustment + target - pending;
}
