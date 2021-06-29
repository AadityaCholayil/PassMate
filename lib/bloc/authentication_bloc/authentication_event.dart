import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  @override
  String toString() => 'AuthenticateUser';

  @override
  List<Object?> get props => [this.toString()];
}

class LoggedOut extends AuthenticationEvent{
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object?> get props => [this.toString()];
}