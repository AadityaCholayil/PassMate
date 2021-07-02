import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'signup_barrel.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{
  final AuthenticationRepository _authenticationRepository;

  SignupBloc({required authenticationRepository}):
        _authenticationRepository=authenticationRepository, super(SignupState.loading);

  SignupState get initialState => SignupState.loading;

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupUsingCredentials) {
      yield* _mapSignupUsingCredentialsToState(event);
    } else if (event is SignupUsingGoogle) {
      yield* _mapLoginUsingGoogleToState();
    }
  }

  Stream<SignupState> _mapSignupUsingCredentialsToState(SignupUsingCredentials event) async* {
    yield SignupState.loading;
    if(event.email.isValid){
      try {
        await _authenticationRepository.signUpUsingCredentials(
            event.email.email, event.password.password);
        //TODO on signup
        yield SignupState.success;


      } on Exception catch (e) {
        if (e is EmailAlreadyInUseException) {
          yield SignupState.userAlreadyExists;
        } else {
          yield SignupState.somethingWentWrong;
        }
      }
    } else {
      yield SignupState.invalidEmailFormat;
    }
  }

  Stream<SignupState> _mapLoginUsingGoogleToState() async* {
    yield SignupState.loading;
  }

}