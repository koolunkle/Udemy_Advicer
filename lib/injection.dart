import 'package:advicer/data/datasources/advice_datasource_remote.dart';
import 'package:advicer/data/repositories/advice_repository_impl.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:advicer/domain/usecases/advice_usecase.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.I;

Future<void> init() async {
  serviceLocator
    // presentation layer
    ..registerFactory(() => AdviceCubit(adviceUseCases: serviceLocator()))
    // domain layer
    ..registerFactory(() => AdviceUseCases(adviceRepository: serviceLocator()))
    // data layer
    ..registerFactory<AdviceRepository>(
      () => AdviceRepositoryImpl(adviceDatasourceRemote: serviceLocator()),
    )
    // data layer
    ..registerFactory<AdviceDatasourceRemote>(
      () => AdviceDatasourceRemoteImpl(client: serviceLocator()),
    )
    // externs
    ..registerFactory(http.Client.new);
}
