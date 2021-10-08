import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/auth_credentials.dart';

@immutable
abstract class SignupEvent extends Equatable {
  const SignupEvent([List props = const []]) : super();
}

class SignupUsingCredentials extends SignupEvent {
  final AuthEmail email;
  final AuthPassword password;

  const SignupUsingCredentials({required this.email, required this.password});

  @override
  String toString() => 'LogInUsingCredentials';

  @override
  List<Object?> get props => [toString()];
}

class SignupUsingGoogle extends SignupEvent {
  @override
  String toString() => 'LogInUsingGoogle';

  @override
  List<Object?> get props => [toString()];
}