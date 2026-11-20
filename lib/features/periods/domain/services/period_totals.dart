import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/account.dart';
import 'package:saisho_kakeibo/features/accounts/domain/entities/accounts_x.dart';
import 'package:saisho_kakeibo/features/movements/domain/entities/movement.dart';
import 'package:saisho_kakeibo/features/movements/domain/rules/transfer_rules.dart';

part 'period_totals.freezed.dart';

/// The three totals of a period in one currency, in its minor unit (RF-14).
@freezed
abstract class CurrencyTotals with _$CurrencyTotals {
  const factory({
    @Default(0) int income,
    @Default(0) int expenses,
    @Default(0) int transfers,
  }) = _CurrencyTotals;
}

/// Totals of a period's movements by currency code (RF-14).
abstract final class PeriodTotals {
  /// - Pending incomes wait for their confirmation; pending expenses and
  ///   transfers count, as they move the balance.
  /// - A transfer adds what left in the sender's currency and, between
  ///   currencies, what arrived in the receiver's. One inside an account
  ///   (with its pockets) adds nothing.
  /// - Adjustments add to no total.
  static Map<String, CurrencyTotals> of(
    Iterable<Movement> movements,
    List<Account> accounts,
  ) {
    final totals = <String, CurrencyTotals>{};
    void add(Account? account, CurrencyTotals Function(CurrencyTotals) change) {
      if (account == null) return;
      final code = account.currencyCode;
      totals[code] = change(totals[code] ?? const CurrencyTotals());
    }

    for (final m in movements) {
      final account = accounts.byId(m.accountId);
      switch (m.type) {
        case MovementType.income when !m.isPending:
          add(account, (t) => t.copyWith(income: t.income + m.amount));
        case MovementType.expense:
          add(account, (t) => t.copyWith(expenses: t.expenses + m.amount));
        case MovementType.transfer:
          final to = accounts.byId(m.toAccountId);
          if (account == null || to == null) continue;
          if (TransferRules.isInternal(account, to)) continue;
          add(account, (t) => t.copyWith(transfers: t.transfers + m.amount));
          if (to.currencyCode != account.currencyCode) {
            final received = m.toAmount ?? m.amount;
            add(to, (t) => t.copyWith(transfers: t.transfers + received));
          }
        case MovementType.income || MovementType.adjustment:
          break;
      }
    }
    return totals;
  }
}
