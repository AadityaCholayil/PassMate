import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent{

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [this.toString()];

}


class LogIn extends AuthenticationEvent{

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [this.toString()];

}


class LoggedOut extends AuthenticationEvent{

  @override
  String toString() => 'Authenticated';

  @override
  List<Object?> get props => [this.toString()];

}