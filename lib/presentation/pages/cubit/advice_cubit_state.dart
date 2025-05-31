import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AdviceCubitState extends Equatable {
  const AdviceCubitState();

  @override
  List<Object> get props => [];
}

final class AdviceInitial extends AdviceCubitState {
  const AdviceInitial();
}

final class AdviceStateLoading extends AdviceCubitState {
  const AdviceStateLoading();
}

final class AdviceStateLoaded extends AdviceCubitState {
  const AdviceStateLoaded({required this.advice});

  final String advice;

  @override
  List<Object> get props => [advice];
}

final class AdviceStateError extends AdviceCubitState {
  const AdviceStateError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
