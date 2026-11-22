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

/// What one movement adds to a total: an amount of a type in a currency.
typedef TotalShare = ({String currencyCode, MovementType type, int amount});

/// Totals of a period's movements by currency code (RF-14).
abstract final class PeriodTotals {
  static Map<String, CurrencyTotals> of(
    Iterable<Movement> movements,
    List<Account> accounts,
  ) {
    final totals = <String, CurrencyTotals>{};
    for (final m in movements) {
      for (final (:currencyCode, :type, :amount) in shares(m, accounts)) {
        final t = totals[currencyCode] ?? const CurrencyTotals();
        totals[currencyCode] = switch (type) {
          MovementType.income => t.copyWith(income: t.income + amount),
          MovementType.expense => t.copyWith(expenses: t.expenses + amount),
          _ => t.copyWith(transfers: t.transfers + amount),
        };
      }
    }
    return totals;
  }

  /// Amount of each category among the movements of [type] in
  /// [currencyCode], largest first: the history's view by category.
  static List<({int categoryId, int amount})> byCategory(
    Iterable<Movement> movements,
    List<Account> accounts, {
    required String currencyCode,
    required MovementType type,
  }) {
    final amounts = <int, int>{};
    for (final m in movements) {
      final id = m.categoryId;
      if (m.type != type || id == null) continue;
      for (final share in shares(m, accounts)) {
        if (share.currencyCode != currencyCode) continue;
        amounts[id] = (amounts[id] ?? 0) + share.amount;
      }
    }
    return [
      for (final MapEntry(:key, :value) in amounts.entries)
        (categoryId: key, amount: value),
    ]..sort((a, b) => b.amount.compareTo(a.amount));
  }

  /// What [m] adds to the totals:
  /// - Pending incomes wait for their confirmation; pending expenses and
  ///   transfers count, as they move the balance.
  /// - A transfer adds what left in the sender's currency and, between
  ///   currencies, what arrived in the receiver's. One inside an account
  ///   (with its pockets) adds nothing.
  /// - Adjustments add to no total.
  static List<TotalShare> shares(Movement m, List<Account> accounts) {
    final account = accounts.byId(m.accountId);
    if (account == null) return const [];
    switch (m.type) {
      case MovementType.income when m.isPending:
      case MovementType.adjustment:
        return const [];
      case MovementType.income || MovementType.expense:
        return [
          (currencyCode: account.currencyCode, type: m.type, amount: m.amount),
        ];
      case MovementType.transfer:
        final to = accounts.byId(m.toAccountId);
        if (to == null || TransferRules.isInternal(account, to)) {
          return const [];
        }
        return [
          (currencyCode: account.currencyCode, type: m.type, amount: m.amount),
          if (to.currencyCode != account.currencyCode)
            (
              currencyCode: to.currencyCode,
              type: m.type,
              amount: m.toAmount ?? m.amount,
            ),
        ];
    }
  }
}
