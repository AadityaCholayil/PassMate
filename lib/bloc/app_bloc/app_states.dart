import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:passmate/model/old_user.dart';

@immutable
abstract class OldAppState extends Equatable {
  const OldAppState([List props = const []]) : super();
}

class Uninitialized extends OldAppState {
  final OldUserData userData;

  const Uninitialized({required this.userData});

  @override
  String toString() => 'Uninitialized';

  @override
  List<Object?> get props => [toString()];
}

class Unauthenticated extends OldAppState {
  final OldUserData userData;

  const Unauthenticated({required this.userData});

  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object?> get props => [toString()];
}

class Authenticated extends OldAppState {
  final OldUserData userData;

  const Authenticated({required this.userData});

  @override
  String toString() => 'Authenticated';

  @override
  List<Object?> get props => [toString()];
}

class LoginPageState extends OldAppState {
  final String message;

  const LoginPageState({required this.message});

  static LoginPageState loading = const LoginPageState(message: 'Loading');

  static LoginPageState noUserFound =
      const LoginPageState(message: 'No user found for that email');

  static LoginPageState wrongPassword =
      const LoginPageState(message: 'Wrong Password provided for that user');

  static LoginPageState somethingWentWrong =
      const LoginPageState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}

class EmailInputPageState extends OldAppState {
  final EmailStatus emailStatus;

  const EmailInputPageState({required this.emailStatus});

  @override
  List<Object?> get props => [emailStatus];
}

enum EmailStatus {
  loading,
  valid,
  invalid,
}

class SignupPageState extends OldAppState {
  final String message;

  const SignupPageState({required this.message});

  static SignupPageState loading = const SignupPageState(message: 'Loading');

  static SignupPageState userAlreadyExists =
      const SignupPageState(message: 'Email is already in use');

  static SignupPageState somethingWentWrong =
      const SignupPageState(message: 'Something went wrong, Please try again');

  @override
  List<Object?> get props => [message];
}

class EditProfilePageState extends OldAppState {
  final String message;

  const EditProfilePageState({required this.message});

  static EditProfilePageState loading =
      const EditProfilePageState(message: 'Loading');

  static EditProfilePageState somethingWentWrong = const EditProfilePageState(
      message: 'Something went wrong, Please try again');

  static EditProfilePageState success =
      const EditProfilePageState(message: 'Success!');

  @override
  String toString() => 'EditProfilePageState.' + message;

  @override
  List<Object?> get props => [toString()];
}

class DeleteAccountPageState extends OldAppState {
  final String message;

  const DeleteAccountPageState({required this.message});

  static DeleteAccountPageState loading =
      const DeleteAccountPageState(message: 'Loading');

  static DeleteAccountPageState invalidCredentials =
      const DeleteAccountPageState(message: 'Invalid Credentials!');

  static DeleteAccountPageState somethingWentWrong =
      const DeleteAccountPageState(
          message: 'Something went wrong, Please try again');

  static DeleteAccountPageState success =
      const DeleteAccountPageState(message: 'Success!');

  @override
  String toString() => 'DeleteAccountPageState.' + message;

  @override
  List<Object?> get props => [toString()];
}

class ErrorOccurred extends OldAppState {
  final String error;

  const ErrorOccurred({required this.error});

  @override
  String toString() => 'ErrorOccurred';

  @override
  List<Object?> get props => [error];
}
