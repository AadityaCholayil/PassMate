import 'package:equatable/equatable.dart';
import 'package:passmate/model/credentials.dart';

class LoginState extends Equatable {
  final String message;
  final Credentials credentials;

  LoginState(this.credentials, {required this.message});

  static LoginState loading(Credentials credentials) =>
      LoginState(credentials, message: 'Loading');

  static LoginState success(Credentials credentials) =>
      LoginState(credentials, message: 'Successful');

  static LoginState invalidEmailFormat(Credentials credentials) =>
      LoginState(credentials, message: 'Invalid Email Format');

  static LoginState noUserFound(Credentials credentials) =>
      LoginState(credentials, message: 'No user found for that email');

  static LoginState wrongPassword(Credentials credentials) =>
      LoginState(credentials, message: 'Wrong Password provided for that user');

  static LoginState somethingWentWrong(Credentials credentials) =>
      LoginState(credentials,
          message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}
