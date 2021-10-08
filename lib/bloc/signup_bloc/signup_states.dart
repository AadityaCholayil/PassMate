import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String message;

  const SignupState({required this.message});

  static SignupState loading = const SignupState(message: 'Loading');

  static SignupState success = const SignupState(message: 'Successful');

  static SignupState invalidEmailFormat =
      const SignupState(message: 'Invalid email format');

  static SignupState userAlreadyExists =
      const SignupState(message: 'Email is already in use');

  static SignupState somethingWentWrong =
      const SignupState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}
