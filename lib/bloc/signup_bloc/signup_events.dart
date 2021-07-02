import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/auth_credentials.dart';

@immutable
abstract class SignupEvent extends Equatable {
  SignupEvent([List props = const []]) : super();
}

class SignupUsingCredentials extends SignupEvent {
  final AuthEmail email;
  final AuthPassword password;

  SignupUsingCredentials({required this.email, required this.password});

  @override
  String toString() => 'LogInUsingCredentials';

  @override
  List<Object?> get props => [this.toString()];
}

class SignupUsingGoogle extends SignupEvent {
  @override
  String toString() => 'LogInUsingGoogle';

  @override
  List<Object?> get props => [this.toString()];
}