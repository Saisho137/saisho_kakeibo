import 'package:flutter_test/flutter_test.dart';
import 'package:saisho_kakeibo/app/app.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage as the initial route', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
