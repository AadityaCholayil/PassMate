import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/model/user.dart';
import 'auth_bloc_files.dart';

enum AuthType{SignUp, LogIn}

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({required authenticationRepository}):
    _authenticationRepository=authenticationRepository, super(Uninitialized(userData: UserData.empty));

  AuthenticationState get initialState => Uninitialized(userData: UserData.empty);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LogIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = _authenticationRepository.isSignedIn();
      if(isSignedIn){
        UserData userData = _authenticationRepository.getUserData();
        yield Authenticated(userData: userData);
      } else {
        yield Unauthenticated(userData: UserData.empty);
      }
    } on Exception catch (_) {
      print('error');
      yield Unauthenticated(userData: UserData.empty);
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(userData: _authenticationRepository.getUserData());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _authenticationRepository.signOut();
    yield Unauthenticated(userData: UserData.empty);
  }
}