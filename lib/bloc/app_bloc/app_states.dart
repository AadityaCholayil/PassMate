import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/user.dart';

@immutable
abstract class AppState extends Equatable {
  const AppState([List props = const []]) : super();
}

class Uninitialized extends AppState {
  final UserData userData;

  const Uninitialized({required this.userData});

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [toString()];
}

class Unauthenticated extends AppState {
  final UserData userData;

  const Unauthenticated({required this.userData});

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [toString()];
}

class PartiallyAuthenticated extends AppState {
  final UserData userData;

  const PartiallyAuthenticated({required this.userData});

  @override
  String toString() => 'PartiallyAuthenticated';

  @override
  List<Object?> get props => [toString()];
}

class FullyAuthenticated extends AppState {
  final UserData userData;

  const FullyAuthenticated({required this.userData});

  @override
  String toString() => 'FullyAuthenticated';

  @override
  List<Object?> get props => [toString()];
}

class Authenticated extends AppState {
  final UserData userData;

  const Authenticated({required this.userData});

  @override
  String toString() => 'Authenticated';

  @override
  List<Object?> get props => [toString()];
}

class LoginNewState extends AppState {
  final String message;

  const LoginNewState({required this.message});

  static LoginNewState loading = const LoginNewState(message: 'Loading');

  static LoginNewState success = const LoginNewState(message: 'Successful');

  static LoginNewState noUserFound =
      const LoginNewState(message: 'No user found for that email');

  static LoginNewState wrongPassword =
      const LoginNewState(message: 'Wrong Password provided for that user');

  static LoginNewState somethingWentWrong =
      const LoginNewState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}

class SignupNewState extends AppState {
  final String message;

  const SignupNewState({required this.message});

  static SignupNewState loading = const SignupNewState(message: 'Loading');

  static SignupNewState success = const SignupNewState(message: 'Successful');

  static SignupNewState userAlreadyExists =
      const SignupNewState(message: 'Email is already in use');

  static SignupNewState somethingWentWrong =
      const SignupNewState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}

class ErrorOccurred extends AppState {
  final String error;

  const ErrorOccurred({required this.error});

  @override
  String toString() => 'ErrorOccurred';

  @override
  List<Object?> get props => [toString()];
}
