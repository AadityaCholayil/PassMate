import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SignUpEvents extends Equatable {
  SignUpEvents([List props = const []]) : super();
}

class SignUpUsingCredentials extends SignUpEvents{

  final String email;
  final String password;

  SignUpUsingCredentials({String email = '', String password = ''})
      :email=email, password = password;

  @override
  String toString() => 'LogInUsingCredentials';

  @override
  List<Object?> get props => [this.toString()];

}


class LogInUsingGoogle extends SignUpEvents{

  @override
  String toString() => 'LogInUsingGoogle';

  @override
  List<Object?> get props => [this.toString()];

}