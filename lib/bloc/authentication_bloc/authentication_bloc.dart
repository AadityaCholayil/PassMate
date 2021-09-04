import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'auth_bloc_files.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{

  final AuthenticationRepository _authenticationRepository;
  late DatabaseRepository databaseRepository;
  EncryptionRepository encryptionRepository = EncryptionRepository();
  late UserData userData;
  late DatabaseBloc databaseBloc;

  AuthenticationBloc({required authenticationRepository}):
    _authenticationRepository=authenticationRepository, super(Uninitialized(userData: UserData.empty)){
    userData = _authenticationRepository.getUserData();
    databaseRepository = DatabaseRepository(uid: userData.uid);
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: databaseRepository,
      encryptionRepository: encryptionRepository,
    );
  }

  void updateBloc(){
    print('isSame?');
    print(databaseBloc == DatabaseBloc(
      userData: userData,
      databaseRepository: databaseRepository,
      encryptionRepository: encryptionRepository,
    ));
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: databaseRepository,
      encryptionRepository: encryptionRepository,
    );
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
    if(kIsWeb){
      final isSignedIn = _authenticationRepository.isSignedIn();
      if(isSignedIn){
        await _authenticationRepository.signOut();
      }
      yield Unauthenticated(userData: userData);
    } else {
      try {
        userData = _authenticationRepository.getUserData();
        if(userData!=UserData.empty){
          databaseRepository = DatabaseRepository(uid: userData.uid);
          UserData userData2 = await databaseRepository.completeUserData;
          final storage = FlutterSecureStorage();
          String key = await storage.read(key: 'key')??'KeyNotFound';
          encryptionRepository.updateKey(key);
          if(userData2==UserData.empty){
            yield PartiallyAuthenticated(userData: userData);
          } else {
            userData=userData2;
            yield FullyAuthenticated(userData: userData);
          }
        } else {
          yield Unauthenticated(userData: userData);
        }
      } on Exception catch (_) {
        print('error');
        yield Unauthenticated(userData: UserData.empty);
      }
    }
  }

  Stream<AuthenticationState> _mapAuthenticateUserToState() async* {
    yield Uninitialized(userData: userData);
    userData = _authenticationRepository.getUserData();
    databaseRepository = DatabaseRepository(uid: userData.uid);
    UserData userData2 = await databaseRepository.completeUserData;
    updateBloc();
    if (!kIsWeb) {
      final storage = FlutterSecureStorage();
      String key = await storage.read(key: 'key')??'KeyNotFound';
      encryptionRepository.updateKey(key);
    }
    if(userData2==UserData.empty){
      yield PartiallyAuthenticated(userData: userData);
    } else {
      userData = userData2;
      yield FullyAuthenticated(userData: userData);
    }
  }

  Stream<AuthenticationState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield Uninitialized(userData: UserData.empty);
    userData = _authenticationRepository.getUserData();
    UserData newUserData = UserData(
      uid: userData.uid,
      email: userData.email,
      firstName: event.firstName,
      lastName: event.lastName,
      photoUrl: event.photoUrl,
      pinSet: false,
      sortMethod: SortMethod.recentlyAdded
    );
    try{
      databaseRepository = DatabaseRepository(uid: userData.uid);
      databaseRepository.updateUserData(newUserData);
      databaseRepository.addFolder(folderName: 'root/default');
      userData = newUserData;
      add(AuthenticateUser());
    } on Exception catch (_){
      //TODO add exception
      print('Something Went Wrong');
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    userData = UserData.empty;
    databaseRepository = DatabaseRepository(uid: userData.uid);
    updateBloc();
    await _authenticationRepository.signOut();
    yield Unauthenticated(userData: userData);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}