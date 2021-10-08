import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/auth_credentials.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent([List props = const []]) : super();
}

class AppStarted extends AppEvent{
  @override
  String toString() => 'AppStarted';

  @override
  List<Object?> get props => [toString()];
}

class AuthenticateUser extends AppEvent{

  // final UserData userData;
  //
  // AuthenticateUser({required this.userData});

  @override
  String toString() => 'AuthenticateUser';

  @override
  List<Object?> get props => [toString()];
}

class UpdateUserData extends AppEvent{
  final String firstName;
  final String lastName;
  final String photoUrl;

  const UpdateUserData(this.firstName, this.lastName, this.photoUrl);

  @override
  String toString() => 'UpdateUserData';

  @override
  List<Object?> get props => [toString()];
}

class LoggedOut extends AppEvent{
  @override
  String toString() => 'LoggedOut';

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