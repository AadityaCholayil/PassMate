import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class OldAppEvent extends Equatable {
  const OldAppEvent([List props = const []]) : super();
}

class AppStarted extends OldAppEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [toString()];
}

class LoginUser extends OldAppEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});

  @override
  String toString() => 'LoginUser';

  @override
  List<Object?> get props => [toString()];
}

class CheckEmailStatus extends OldAppEvent {
  final String email;

  const CheckEmailStatus({required this.email});

  @override
  String toString() => 'CheckEmailStatus';

  @override
  List<Object?> get props => [toString()];
}

class SignupUser extends OldAppEvent {
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

class UpdateUserData extends OldAppEvent {
  final String firstName;
  final String lastName;
  final File? image;

  const UpdateUserData(this.firstName, this.lastName, this.image);

  @override
  String toString() => 'UpdateUserData';

  @override
  List<Object?> get props => [toString()];
}

class LoggedOut extends OldAppEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [toString()];
}

class DeleteUser extends OldAppEvent {
  final String email;
  final String password;

  const DeleteUser({required this.email, required this.password});

  @override
  String toString() => 'DeleteUser';

  @override
  List<Object?> get props => [toString()];
}
