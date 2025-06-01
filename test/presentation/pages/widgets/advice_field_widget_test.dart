import 'package:advicer/presentation/pages/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String adviceText}) {
    return MaterialApp(home: AdviceField(advice: adviceText));
  }

  group('AdviceField', () {
    group('should be displayed correctly', () {
      testWidgets('when a short text is given', (widgetTester) async {
        const text = 'a';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.textContaining('a');

        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('when a long text is given', (widgetTester) async {
        const text =
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.byType(AdviceField);

        expect(adviceFieldFinder, findsOneWidget);
      });

      testWidgets('when a no text is given', (widgetTester) async {
        const text = '';

        await widgetTester.pumpWidget(widgetUnderTest(adviceText: text));
        await widgetTester.pumpAndSettle();

        final adviceFieldFinder = find.text(AdviceField.emptyAdvice);
        final adviceText =
            widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

        expect(adviceFieldFinder, findsOneWidget);
        expect(adviceText, '');
      });
    });
  });
}
