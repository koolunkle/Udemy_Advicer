import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advice_usecase.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceUseCases>()])
void main() {
  group('AdviceCubit', () {
    group('should emit', () {
      final mockAdviceUseCases = MockAdviceUseCases();
      blocTest<AdviceCubit, AdviceCubitState>(
        'nothing when no method is called',
        build: () => AdviceCubit(adviceUseCases: mockAdviceUseCases),
        expect: () => const <AdviceCubitState>[],
      );

      blocTest<AdviceCubit, AdviceCubitState>(
        '[AdviceStateLoading, AdviceStateLoaded] when Requested is called',
        setUp:
            () => when(mockAdviceUseCases.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                const Right<Failures, AdviceEntity>(
                  AdviceEntity(advice: 'advice', id: 1),
                ),
              ),
            ),
        build: () => AdviceCubit(adviceUseCases: mockAdviceUseCases),
        act: (cubit) => cubit.adviceRequested(),
        expect:
            () => <AdviceCubitState>[
              const AdviceStateLoading(),
              const AdviceStateLoaded(advice: 'advice'),
            ],
      );

      group(
        '[AdviceStateLoading, AdviceStateError] when Requested is called',
        () {
          blocTest<AdviceCubit, AdviceCubitState>(
            'and a ServerFailure occurs',
            setUp:
                () => when(mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failures, AdviceEntity>(ServerFailure()),
                  ),
                ),
            build: () => AdviceCubit(adviceUseCases: mockAdviceUseCases),
            act: (cubit) => cubit.adviceRequested(),
            expect:
                () => const <AdviceCubitState>[
                  AdviceStateLoading(),
                  AdviceStateError(message: serverFailureMessage),
                ],
          );

          blocTest<AdviceCubit, AdviceCubitState>(
            'and a CacheFailure occurs',
            setUp:
                () => when(mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failures, AdviceEntity>(CacheFailure()),
                  ),
                ),
            build: () => AdviceCubit(adviceUseCases: mockAdviceUseCases),
            act: (cubit) => cubit.adviceRequested(),
            expect:
                () => const <AdviceCubitState>[
                  AdviceStateLoading(),
                  AdviceStateError(message: cacheFailureMessage),
                ],
          );

          blocTest<AdviceCubit, AdviceCubitState>(
            'and a GeneralFailure occurs',
            setUp:
                () => when(mockAdviceUseCases.getAdvice()).thenAnswer(
                  (invocation) => Future.value(
                    Left<Failures, AdviceEntity>(GeneralFailure()),
                  ),
                ),
            build: () => AdviceCubit(adviceUseCases: mockAdviceUseCases),
            act: (cubit) => cubit.adviceRequested(),
            expect:
                () => const <AdviceCubitState>[
                  AdviceStateLoading(),
                  AdviceStateError(message: generalFailureMessage),
                ],
          );
        },
      );
    });
  });
}
