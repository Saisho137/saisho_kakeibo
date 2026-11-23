import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/extensions/build_context_x.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/money.dart';
import 'package:saisho_kakeibo/core/money/money_formatter.dart';
import 'package:saisho_kakeibo/features/payees/domain/services/payee_stats.dart';

/// How an entity's price evolved (RF-08): one point per movement, oldest
/// on the left. Touching a point shows its amount and day.
///
/// `fl_chart`'s line chart imports `package:flutter/material.dart` but
/// reads no legacy theme nor localizations, so it needs no
/// compatibility bridge: its colors and styles come from here.
class PriceChart extends StatelessWidget {
  const new({required this.prices, required this.currency, super.key});

  final List<PayeePrice> prices;
  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final day = DateFormat.yMMMd(locale);
    String money(int amount) =>
        MoneyFormatter.format(Money(amount, currency.code), currency.format);
    final amounts = prices.map((p) => p.amount);
    final top = amounts.reduce((a, b) => a > b ? a : b);
    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: top == 0 ? 1 : top * 1.15,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => colors.inverseSurface,
              fitInsideHorizontally: true,
              fitInsideVertically: true,
              getTooltipItems: (spots) => [
                for (final spot in spots)
                  LineTooltipItem(
                    '${money(prices[spot.x.toInt()].amount)}\n'
                    '${day.format(prices[spot.x.toInt()].date.toDateTime())}',
                    context.textTheme.labelMedium!.copyWith(
                      color: colors.onInverseSurface,
                    ),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (final (index, price) in prices.indexed)
                  FlSpot(index.toDouble(), price.amount.toDouble()),
              ],
              color: colors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                getDotPainter: (_, _, _, _) => FlDotCirclePainter(
                  radius: 3,
                  color: colors.primary,
                  strokeWidth: 0,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                color: colors.primary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
