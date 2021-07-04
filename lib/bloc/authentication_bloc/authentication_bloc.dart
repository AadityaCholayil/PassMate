import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'auth_bloc_files.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserData> _userSubscription;
  late final DatabaseRepository databaseRepository;

  AuthenticationBloc({required authenticationRepository}):
    _authenticationRepository=authenticationRepository, super(Uninitialized(userData: UserData.empty)){
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  void _onUserChanged(UserData userData) {
    if(userData!=UserData.empty) {
      add(AuthenticateUser(userData: userData));
      databaseRepository = DatabaseRepository(uid: userData.uid);
    }
  }

  AuthenticationState get initialState => Uninitialized(userData: UserData.empty);

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AuthenticateUser) {
      yield* _mapAuthenticateUserToState();
    } else if (event is UpdateUserData) {
      yield* _mapUpdateUserDataToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = _authenticationRepository.isSignedIn();
      if(isSignedIn){
        UserData userData = await databaseRepository.completeUserData;
        if(userData==UserData.empty){
          yield PartiallyAuthenticated(userData: _authenticationRepository.getUserData());
        } else {
          yield FullyAuthenticated(userData: _authenticationRepository.getUserData());
        }
      } else {
        yield Unauthenticated(userData: UserData.empty);
      }
    } on Exception catch (_) {
      print('error');
      yield Unauthenticated(userData: UserData.empty);
    }
  }

  Stream<AuthenticationState> _mapAuthenticateUserToState() async* {
    UserData userData = await databaseRepository.completeUserData;
    if(userData==UserData.empty){
      yield PartiallyAuthenticated(userData: _authenticationRepository.getUserData());
    } else {
      yield FullyAuthenticated(userData: _authenticationRepository.getUserData());
    }
  }

  Stream<AuthenticationState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield Uninitialized(userData: UserData.empty);
    UserData userData = _authenticationRepository.getUserData();
    UserData newUserData = UserData(
      uid: userData.uid,
      email: userData.email,
      firstName: event.firstName,
      lastName: event.lastName,
      photoUrl: event.photoUrl,
      pinSet: false
    );
    try{
      databaseRepository.updateUserData(newUserData);
    } on Exception catch (e){
      print('Something Went Wrong');
    }
    add(AuthenticateUser(userData: userData));
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