import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/money/currency.dart';
import 'package:saisho_kakeibo/core/money/currency_format.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/payees/presentation/widgets/price_chart.dart';

import '../../../helpers/helpers.dart';

void main() {
  const cop = Currency(code: 'COP', symbol: r'$', format: CurrencyFormat.cop);

  testWidgets('charts the prices and shows a touched one', (tester) async {
    await tester.pumpApp(
      Scaffold(
        body: SizedBox(
          width: 360,
          child: PriceChart(
            currency: cop,
            prices: [
              (date: LocalDate(2026, 3, 1), amount: 10000),
              (date: LocalDate(2026, 3, 5), amount: 12000),
            ],
          ),
        ),
      ),
    );

    final chart = tester.widget<LineChart>(find.byType(LineChart));
    expect(chart.data.lineBarsData.single.spots, const [
      FlSpot(0, 10000),
      FlSpot(1, 12000),
    ]);
    final items = chart.data.lineTouchData.touchTooltipData.getTooltipItems([
      LineBarSpot(chart.data.lineBarsData.single, 0, const FlSpot(1, 12000)),
    ]);
    expect(items.single?.text, '12.000\nMar 5, 2026');
    expect(
      chart.data.lineTouchData.touchTooltipData.getTooltipColor(
        LineBarSpot(chart.data.lineBarsData.single, 0, const FlSpot(1, 12000)),
      ),
      isNotNull,
    );
    final dot = chart.data.lineBarsData.single.dotData.getDotPainter(
      const FlSpot(1, 12000),
      0,
      chart.data.lineBarsData.single,
      1,
    );
    expect(dot, isA<FlDotCirclePainter>());
  });

  testWidgets('prices of zero still chart', (tester) async {
    await tester.pumpApp(
      Scaffold(
        body: PriceChart(
          currency: cop,
          prices: [
            (date: LocalDate(2026, 3, 1), amount: 0),
            (date: LocalDate(2026, 3, 2), amount: 0),
          ],
        ),
      ),
    );
    expect(tester.widget<LineChart>(find.byType(LineChart)).data.maxY, 1);
  });
}
