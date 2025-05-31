import 'package:equatable/equatable.dart';

class AdviceEntity extends Equatable {
  const AdviceEntity({required this.advice, required this.id});

  final String advice;
  final int id;

  @override
  List<Object?> get props => [advice, id];
}
