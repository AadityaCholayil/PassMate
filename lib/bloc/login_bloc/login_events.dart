import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/auth_credentials.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent([List props = const []]) : super();
}

class LoginUsingCredentials extends LoginEvent {
  final AuthEmail email;
  final AuthPassword password;

  const LoginUsingCredentials({required this.email, required this.password});

  @override
  String toString() => 'LogInUsingCredentials';

  @override
  List<Object?> get props => [toString()];
}

class LoginUsingGoogle extends LoginEvent {
  @override
  String toString() => 'LogInUsingGoogle';

  @override
  List<Object?> get props => [toString()];
}

class ForgotPassword extends LoginEvent {
  @override
  String toString() => 'ForgotPassword';

  @override
  List<Object?> get props => [toString()];
}
