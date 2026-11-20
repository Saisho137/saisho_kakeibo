import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    testWidgets('shows the app title', (tester) async {
      await tester.pumpApp(const HomePage());

      expect(find.text('Saisho Kakeibo'), findsOneWidget);
    });
  });
}
