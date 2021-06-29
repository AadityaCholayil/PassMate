import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class SignUpState extends Equatable {
  final String message;

  SignUpState(this.message, [List props = const []]) : super();
}

class SignUpSuccessful extends SignUpState{
  SignUpSuccessful({String message = 'Sign up successful'}) : super(message);

  @override
  List<Object?> get props => [message];
}

class SignUpError extends SignUpState{
  SignUpError(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class SignUpLoading extends SignUpState{

  SignUpLoading({String message = 'Loading'}) : super(message);

  @override
  List<Object?> get props => [message];
}