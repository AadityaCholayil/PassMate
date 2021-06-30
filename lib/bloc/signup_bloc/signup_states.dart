import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final String message;

  SignupState({required this.message});

  static SignupState loading = SignupState(message: 'Loading');

  static SignupState success = SignupState(message: 'Successful');

  static SignupState invalidEmailFormat =
      SignupState(message: 'Invalid email format');

  static SignupState userAlreadyExists =
      SignupState(message: 'Email is already in use');

  static SignupState somethingWentWrong =
      SignupState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}
