import 'package:advicer/main.dart' as app;
import 'package:advicer/presentation/pages/widgets/advice_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on custom button, verify advice will be loaded', (
      widgetTester,
    ) async {
      app.main();
      await widgetTester.pumpAndSettle();

      // Verify that no advice has been loaded
      expect(find.text('Your Advice is waiting for you'), findsOneWidget);

      // Find custom buton
      final customButtonFinder = find.text('Get Advice');

      // emulate a tap on the cutom button
      await widgetTester.tap(customButtonFinder);

      // Trigger a frame and wait until its settled
      await widgetTester.pumpAndSettle();

      // Verify that a advice was loaded
      expect(find.byType(AdviceField), findsOneWidget);
      expect(find.textContaining('" '), findsOneWidget);
      expect(find.textContaining(' "'), findsOneWidget);
    });
  });
}
