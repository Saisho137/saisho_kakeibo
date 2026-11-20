import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:saisho_kakeibo/core/time/local_date.dart';
import 'package:saisho_kakeibo/features/periods/domain/entities/period.dart';
import 'package:saisho_kakeibo/features/periods/presentation/widgets/period_label.dart';

import '../../../helpers/helpers.dart';

void main() {
  final year = LocalDate.today().year;

  Future<String> label(WidgetTester tester, Period period) async {
    late String text;
    await tester.pumpApp(
      Builder(
        builder: (context) {
          text = periodLabel(context, period);
          return const SizedBox();
        },
      ),
    );
    return text;
  }

  group('periodLabel', () {
    testWidgets('shows a range, an open period and a year', (tester) async {
      expect(
        await label(
          tester,
          Period(start: LocalDate(year, 3, 23), end: LocalDate(year, 4, 22)),
        ),
        'Mar 23 – Apr 22',
      );
      expect(
        await label(tester, Period(start: LocalDate(year, 3, 23))),
        'Since Mar 23',
      );
      expect(
        await label(
          tester,
          Period(start: LocalDate(2025, 1, 1), end: LocalDate(2025, 12, 31)),
        ),
        '2025',
      );
    });

    testWidgets('adds the year outside the current one', (tester) async {
      expect(
        await label(
          tester,
          Period(start: LocalDate(2024, 12, 27), end: LocalDate(2025, 1, 26)),
        ),
        'Dec 27, 2024 – Jan 26, 2025',
      );
    });
  });
}
