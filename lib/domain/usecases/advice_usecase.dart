import 'package:advicer/domain/entities/advice_entity.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  AdviceUseCases({required this.adviceRepository});

  final AdviceRepository adviceRepository;

  Future<Either<Failures, AdviceEntity>> getAdvice() async {
    return adviceRepository.getAdviceFromDatasource();
  }
}
