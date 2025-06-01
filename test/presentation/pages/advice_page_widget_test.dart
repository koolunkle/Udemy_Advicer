import 'package:advicer/presentation/core/services/theme_service.dart';
import 'package:advicer/presentation/pages/advice_page.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit_state.dart';
import 'package:advicer/presentation/pages/widgets/advice_field.dart';
import 'package:advicer/presentation/pages/widgets/error_message.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockAdviceCubit extends MockCubit<AdviceCubitState>
    implements AdviceCubit {}

void main() {
  Widget widgetUnderTest({required AdviceCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => ThemeService(),
        child: BlocProvider<AdviceCubit>(
          create: (context) => cubit,
          child: const AdvicePage(),
        ),
      ),
    );
  }

  group('AdvicePage', () {
    group('should be displayed in ViewState', () {
      late AdviceCubit mockAdviceCubit;

      setUp(() {
        mockAdviceCubit = MockAdviceCubit();
      });

      testWidgets('Initial when cubit emits AdviceInitial()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdviceCubit,
          Stream.fromIterable([const AdviceInitial()]),
          initialState: const AdviceInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdviceCubit));

        final adviceInitialTextFinder = find.text(
          'Your Advice is waiting for you',
        );

        expect(adviceInitialTextFinder, findsOneWidget);
      });

      testWidgets('Loading when cubit emits AdviceStateLoading()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdviceCubit,
          Stream.fromIterable([const AdviceStateLoading()]),
          initialState: const AdviceInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdviceCubit));
        await widgetTester.pump();

        final adviceStateLoadingFinder = find.byType(CircularProgressIndicator);

        expect(adviceStateLoadingFinder, findsOneWidget);
      });

      testWidgets('Loaded when cubit emits AdviceStateLoaded()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdviceCubit,
          Stream.fromIterable([const AdviceStateLoaded(advice: '42')]),
          initialState: const AdviceInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdviceCubit));
        await widgetTester.pump();

        final adviceStateLoadedFinder = find.byType(AdviceField);
        final adviceText =
            widgetTester.widget<AdviceField>(find.byType(AdviceField)).advice;

        expect(adviceStateLoadedFinder, findsOneWidget);
        expect(adviceText, '42');
      });

      testWidgets('Error when cubit emits AdviceStateError()', (
        widgetTester,
      ) async {
        whenListen(
          mockAdviceCubit,
          Stream.fromIterable([const AdviceStateError(message: 'error')]),
          initialState: const AdviceInitial(),
        );

        await widgetTester.pumpWidget(widgetUnderTest(cubit: mockAdviceCubit));
        await widgetTester.pump();

        final adviceStateErrorFinder = find.byType(ErrorMessage);

        expect(adviceStateErrorFinder, findsOneWidget);
      });
    });
  });
}
