import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/model/credentials.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'login_barrel.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthenticationRepository _authenticationRepository;

  LoginBloc({required authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LoginState.loading(Credentials(email: '', password: '')));

  LoginState get initialState => LoginState.loading(state.credentials);

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
    yield LoginState.loading(state.credentials);
    if(event.credentials.emailIsValid){
      try {
        await _authenticationRepository.logInWithCredentials(
            event.credentials.email, event.credentials.password);
        //TODO on login
        yield LoginState.success(state.credentials);


      } on Exception catch (e) {
        if (e is UserNotFoundException) {
          yield LoginState.noUserFound(state.credentials);
        } else if (e is WrongPasswordException) {
          yield LoginState.wrongPassword(state.credentials);
        } else {
          yield LoginState.somethingWentWrong(state.credentials);
        }
      }
    } else {
      yield LoginState.invalidEmailFormat(state.credentials);
    }
  }
  Stream<LoginState> _mapLoginUsingGoogleToState() async* {
    yield LoginState.loading(state.credentials);
  }
  Stream<LoginState> _mapForgotPasswordToState() async* {
    yield LoginState.loading(state.credentials);
  }

}