import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String message;

  const LoginState({required this.message});

  static LoginState loading = const LoginState(message: 'Loading');

  static LoginState success = const LoginState(message: 'Successful');

  static LoginState invalidEmailFormat =
      const LoginState(message: 'Invalid Email Format');

  static LoginState noUserFound =
      const LoginState(message: 'No user found for that email');

  static LoginState wrongPassword =
      const LoginState(message: 'Wrong Password provided for that user');

  static LoginState somethingWentWrong =
      const LoginState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}
