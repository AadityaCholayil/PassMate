import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/credentials.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class LoginUsingCredentials extends LoginEvent {
  final Credentials credentials;

  LoginUsingCredentials({required this.credentials});

  @override
  String toString() => 'LogInUsingCredentials';

  @override
  List<Object?> get props => [this.toString()];
}

class LoginUsingGoogle extends LoginEvent {
  @override
  String toString() => 'LogInUsingGoogle';

  @override
  List<Object?> get props => [this.toString()];
}

class ForgotPassword extends LoginEvent {
  @override
  String toString() => 'ForgotPassword';

  @override
  List<Object?> get props => [this.toString()];
}
