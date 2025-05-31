import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/usecases/advice_usecase.dart';
import 'package:advicer/presentation/pages/cubit/advice_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String generalFailureMessage =
    'Oops, something went wrong. please try again';

const String cacheFailureMessage = 'Oops, cache failed. please try again';

const String serverFailureMessage = 'Oops, API Error. please try again';

class AdviceCubit extends Cubit<AdviceCubitState> {
  AdviceCubit({required this.adviceUseCases}) : super(AdviceInitial());

  final AdviceUseCases adviceUseCases;

  Future<void> adviceRequested() async {
    emit(AdviceStateLoading());

    final failureOrAdvice = await adviceUseCases.getAdvice();
    failureOrAdvice.fold(
      (failure) =>
          emit(AdviceStateError(message: _mapFailureToMessage(failure))),
      (advice) => emit(AdviceStateLoaded(advice: advice.advice)),
    );
  }

  String _mapFailureToMessage(Failures failures) {
    switch (failures.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CacheFailure):
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
