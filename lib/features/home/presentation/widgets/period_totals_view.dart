import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/features/periods/domain/services/period_totals.dart';
import 'package:saisho_kakeibo/l10n/l10n.dart';

/// Income in green, Expenses in red and Transfers in gray: the center of
/// the donut (RF-14).
class PeriodTotalsView extends StatelessWidget {
  const new({required this.totals, required this.currency, super.key});

  final CurrencyTotals totals;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tokens = context.tokens;
    Widget line(String label, int amount, Color color, TextStyle? style) =>
        Semantics(
          label: label,
          child: Text(
            MoneyFormatter.format(
              Money(amount, currency.code),
              currency.format,
            ),
            style: style?.copyWith(color: color),
          ),
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        line(
          l10n.homeIncome,
          totals.income,
          tokens.income,
          context.textTheme.titleLarge,
        ),
        line(
          l10n.homeExpenses,
          totals.expenses,
          tokens.expense,
          context.textTheme.headlineSmall,
        ),
        line(
          l10n.homeTransfers,
          totals.transfers,
          tokens.transfer,
          context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
