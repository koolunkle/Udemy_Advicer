import 'package:advicer/data/repositories/advice_repository_impl.dart';
import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advice_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepositoryImpl>()])
void main() {
  group(
    'AdviceUsecases',
    () {
      group(
        'should return AdviceEntity',
        () {
          test(
            'when AdviceRepositoryImpl returns a AdviceModel',
            () async {
              final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
              final adviceUseCaseUnderTest = AdviceUseCases(
                adviceRepository: mockAdviceRepositoryImpl,
              );

              when(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  const Right(
                    AdviceEntity(advice: 'test', id: 42),
                  ),
                ),
              );

              final result = await adviceUseCaseUnderTest.getAdvice();

              expect(result.isLeft(), false);
              expect(result.isRight(), true);
              expect(
                result,
                const Right<Failures, AdviceEntity>(
                  AdviceEntity(advice: 'test', id: 42),
                ),
              );
              // when we want to check if a method was not call,
              // use verifyNever(mock.methodCall) instead .called(0)
              verify(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).called(1);
              verifyNoMoreInteractions(
                mockAdviceRepositoryImpl,
              );
            },
          );
        },
      );

      group(
        'should return left with',
        () {
          test(
            'a ServiceFailure',
            () async {
              final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
              final adviceUseCaseUnderTest = AdviceUseCases(
                adviceRepository: mockAdviceRepositoryImpl,
              );

              when(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Left(
                    ServerFailure(),
                  ),
                ),
              );

              final result = await adviceUseCaseUnderTest.getAdvice();

              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(
                result,
                Left<Failures, AdviceEntity>(
                  ServerFailure(),
                ),
              );
              verify(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).called(1);
              verifyNoMoreInteractions(
                mockAdviceRepositoryImpl,
              );
            },
          );

          test(
            'a GeneralFailure',
            () async {
              final mockAdviceRepositoryImpl = MockAdviceRepositoryImpl();
              final adviceUseCaseUnderTest = AdviceUseCases(
                adviceRepository: mockAdviceRepositoryImpl,
              );

              when(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).thenAnswer(
                (realInvocation) => Future.value(
                  Left(
                    GeneralFailure(),
                  ),
                ),
              );

              final result = await adviceUseCaseUnderTest.getAdvice();

              expect(result.isLeft(), true);
              expect(result.isRight(), false);
              expect(
                result,
                Left<Failures, AdviceEntity>(
                  GeneralFailure(),
                ),
              );
              verify(
                mockAdviceRepositoryImpl.getAdviceFromDatasource(),
              ).called(1);
              verifyNoMoreInteractions(
                mockAdviceRepositoryImpl,
              );
            },
          );
        },
      );
    },
  );
}
