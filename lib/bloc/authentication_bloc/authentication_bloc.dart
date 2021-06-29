import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/authentication_repository/authentication_repository.dart';
import 'package:passmate/model/user.dart';
import 'auth_bloc_files.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserData> _userSubscription;

  AuthenticationBloc({required authenticationRepository}):
    _authenticationRepository=authenticationRepository, super(Uninitialized(userData: UserData.empty)){
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  void _onUserChanged(UserData userData) {
    if(userData!=UserData.empty) {
      add(AuthenticateUser());
    }
  }

  AuthenticationState get initialState => Uninitialized(userData: UserData.empty);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AuthenticateUser) {
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

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}