import 'package:advicer/data/datasources/advice_datasource_remote.dart';
import 'package:advicer/data/exceptions/exceptions.dart';
import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceDatasourceRemote adviceDatasourceRemote =
      AdviceDatasourceRemoteImpl();

  @override
  Future<Either<Failures, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceDatasourceRemote.getRandomAdviceFromApi();
      final entity = AdviceEntity(advice: result.advice, id: result.id);
      return right(entity);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      // handle the exception
      return left(GeneralFailure());
    }
  }
}
