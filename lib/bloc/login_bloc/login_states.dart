import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String message;

  LoginState({required this.message});

  static LoginState loading = LoginState(message: 'Loading');

  static LoginState success = LoginState(message: 'Successful');

  static LoginState invalidEmailFormat =
      LoginState(message: 'Invalid Email Format');

  static LoginState noUserFound =
      LoginState(message: 'No user found for that email');

  static LoginState wrongPassword =
      LoginState(message: 'Wrong Password provided for that user');

  static LoginState somethingWentWrong =
      LoginState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}
