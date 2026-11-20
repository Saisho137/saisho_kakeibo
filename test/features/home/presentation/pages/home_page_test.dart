import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saisho_kakeibo/features/home/presentation/pages/home_page.dart';

import '../../../../helpers/helpers.dart';

void main() {
  group('HomePage', () {
    testWidgets('shows the app title', (tester) async {
      await tester.pumpApp(const HomePage());

      expect(find.text('Saisho Kakeibo'), findsOneWidget);
    });

    testWidgets('opens Settings', (tester) async {
      final router = MockGoRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);

      await tester.pumpApp(const HomePage(), router: router);
      await tester.tap(find.byTooltip('Settings'));

      verify(() => router.push<Object?>('/settings')).called(1);
    });

    testWidgets('opens Accounts', (tester) async {
      final router = MockGoRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);

      await tester.pumpApp(const HomePage(), router: router);
      await tester.tap(find.byTooltip('Accounts'));

      verify(() => router.push<Object?>('/accounts')).called(1);
    });
  });
}
