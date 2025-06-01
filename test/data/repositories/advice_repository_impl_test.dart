import 'dart:io';

import 'package:advicer/data/datasources/advice_datasource_remote.dart';
import 'package:advicer/data/exceptions/exceptions.dart';
import 'package:advicer/data/models/advice_model.dart';
import 'package:advicer/data/repositories/advice_repository_impl.dart';
import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceDatasourceRemoteImpl>()])
void main() {
  group('AdviceRepositoryImpl', () {
    group('should return AdviceEntity', () {
      test('when AdviceDatasourceRemote returns a AdviceModel', () async {
        final mockAdviceDatasourceRemote = MockAdviceDatasourceRemoteImpl();
        final adviceRepositoryImplUnderTest = AdviceRepositoryImpl(
          adviceDatasourceRemote: mockAdviceDatasourceRemote,
        );

        when(mockAdviceDatasourceRemote.getRandomAdviceFromApi()).thenAnswer(
          (realInvocation) => Future.value(AdviceModel(advice: 'test', id: 42)),
        );

        final result =
            await adviceRepositoryImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
          result,
          const Right<Failures, AdviceEntity>(
            AdviceEntity(advice: 'test', id: 42),
          ),
        );
        verify(mockAdviceDatasourceRemote.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceDatasourceRemote);
      });
    });

    group('should return left with', () {
      test('a ServerFailure when a ServerException occurs', () async {
        final mockAdviceDatasourceRemote = MockAdviceDatasourceRemoteImpl();
        final adviceRepositoryImplUnderTest = AdviceRepositoryImpl(
          adviceDatasourceRemote: mockAdviceDatasourceRemote,
        );

        when(
          mockAdviceDatasourceRemote.getRandomAdviceFromApi(),
        ).thenThrow(ServerException());

        final result =
            await adviceRepositoryImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failures, AdviceEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exceptions', () async {
        final mockAdviceDatasourceRemote = MockAdviceDatasourceRemoteImpl();
        final adviceRepositoryImplUnderTest = AdviceRepositoryImpl(
          adviceDatasourceRemote: mockAdviceDatasourceRemote,
        );

        when(
          mockAdviceDatasourceRemote.getRandomAdviceFromApi(),
        ).thenThrow(const SocketException('test'));

        final result =
            await adviceRepositoryImplUnderTest.getAdviceFromDatasource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failures, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
