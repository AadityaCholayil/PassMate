import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvents extends Equatable {
  LoginEvents([List props = const []]) : super();
}

class AppStarted extends LoginEvents{

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [this.toString()];

}


class LogIn extends LoginEvents{

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [this.toString()];

}