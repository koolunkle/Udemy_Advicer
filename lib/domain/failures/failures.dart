import 'package:equatable/equatable.dart';

abstract class Failures {}

final class ServerFailure extends Failures with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class CacheFailure extends Failures with EquatableMixin {
  @override
  List<Object?> get props => [];
}

final class GeneralFailure extends Failures with EquatableMixin {
  @override
  List<Object?> get props => [];
}
