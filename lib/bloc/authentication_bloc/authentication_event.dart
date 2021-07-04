import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/user.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent{
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [this.toString()];
}

class AuthenticateUser extends AuthenticationEvent{

  final UserData userData;

  AuthenticateUser({required this.userData});

  @override
  String toString() => 'AuthenticateUser';

  @override
  List<Object?> get props => [this.toString()];
}

class UpdateUserData extends AuthenticationEvent{
  final String firstName;
  final String lastName;
  final String photoUrl;

  UpdateUserData(this.firstName, this.lastName, this.photoUrl);

  @override
  String toString() => 'UpdateUserData';

  @override
  List<Object?> get props => [this.toString()];
}

class LoggedOut extends AuthenticationEvent{
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [this.toString()];
}