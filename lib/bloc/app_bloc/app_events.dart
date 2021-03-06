import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent([List props = const []]) : super();
}

class AppStarted extends AppEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [toString()];
}

class LoginUser extends AppEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});

  @override
  String toString() => 'LoginUser';

  @override
  List<Object?> get props => [toString()];
}

class CheckEmailStatus extends AppEvent {
  final String email;

  const CheckEmailStatus({required this.email});

  @override
  String toString() => 'CheckEmailStatus';

  @override
  List<Object?> get props => [toString()];
}

class SignupUser extends AppEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final File? image;

  const SignupUser({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  @override
  String toString() => 'SignupUser';

  @override
  List<Object?> get props => [toString()];
}

class UpdateUserData extends AppEvent {
  final String firstName;
  final String lastName;
  final File? image ;

  const UpdateUserData(this.firstName, this.lastName, this.image);

  @override
  String toString() => 'UpdateUserData';

  @override
  List<Object?> get props => [toString()];
}

class LoggedOut extends AppEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [toString()];
}

class DeleteUser extends AppEvent {
  final String email;
  final String password;

  const DeleteUser({required this.email, required this.password});

  @override
  String toString() => 'DeleteUser';

  @override
  List<Object?> get props => [toString()];
}


