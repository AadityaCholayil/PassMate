import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'login_barrel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthRepository _authenticationRepository;

  LoginBloc({required authenticationRepository}):
        _authenticationRepository=authenticationRepository, super(LoginState.loading);

  LoginState get initialState => LoginState.loading;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsingCredentials) {
      yield* _mapLoginUsingCredentialsToState(event);
    } else if (event is LoginUsingGoogle) {
      yield* _mapLoginUsingGoogleToState();
    } else if (event is ForgotPassword) {
      yield* _mapForgotPasswordToState();
    }
  }

  Stream<LoginState> _mapLoginUsingCredentialsToState(LoginUsingCredentials event) async* {
    yield LoginState.loading;
    if(event.email.isValid){
      try {
        await _authenticationRepository.logInWithCredentials(
            event.email.email, event.password.password);
        //TODO on login
        yield LoginState.success;


      } on Exception catch (e) {
        if (e is UserNotFoundException) {
          yield LoginState.noUserFound;
        } else if (e is WrongPasswordException) {
          yield LoginState.wrongPassword;
        } else {
          yield LoginState.somethingWentWrong;
        }
      }
    } else {
      yield LoginState.invalidEmailFormat;
    }
  }
  Stream<LoginState> _mapLoginUsingGoogleToState() async* {
    yield LoginState.loading;
  }
  Stream<LoginState> _mapForgotPasswordToState() async* {
    yield LoginState.loading;
  }

}