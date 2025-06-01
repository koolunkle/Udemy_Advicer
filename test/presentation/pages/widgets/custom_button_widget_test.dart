import 'package:advicer/presentation/pages/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

mixin OnCustomButtonTap {
  void call();
}

class MockOnCustomButtonTap extends Mock with OnCustomButtonTap {}

void main() {
  Widget widgetUnderMethod({void Function()? callback}) {
    return MaterialApp(home: Scaffold(body: CustomButton(onTap: callback)));
  }

  group('Custom Button', () {
    group('is button rendered correctly?', () {
      testWidgets('and has all parts that he needs', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderMethod());

        final buttonLabelFinder = find.text('Get Advice');

        expect(buttonLabelFinder, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      testWidgets('when someone has pressed the button', (widgetTester) async {
        final mockOnCustomButtonTap = MockOnCustomButtonTap();
        await widgetTester.pumpWidget(
          widgetUnderMethod(callback: mockOnCustomButtonTap.call),
        );

        final customButtonFinder = find.byType(CustomButton);

        await widgetTester.tap(customButtonFinder);

        verify(mockOnCustomButtonTap()).called(1);
      });
    });
  });
}
