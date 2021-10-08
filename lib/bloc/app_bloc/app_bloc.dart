import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'package:passmate/model/sort_methods.dart';
import 'package:passmate/repositories/authentication_repository.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/repositories/database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'app_bloc_files.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  late DatabaseRepository _databaseRepository;
  EncryptionRepository encryptionRepository = EncryptionRepository();
  late UserData userData;
  late DatabaseBloc databaseBloc;

  AppBloc({required authRepository})
      : _authRepository = authRepository,
        super(Uninitialized(userData: UserData.empty)) {
    userData = _authRepository.getUserData();
    _databaseRepository = DatabaseRepository(uid: userData.uid);
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: _databaseRepository,
      encryptionRepository: encryptionRepository,
    );
  }

  void updateBloc() {
    print('isSame?');
    print(databaseBloc ==
        DatabaseBloc(
          userData: userData,
          databaseRepository: _databaseRepository,
          encryptionRepository: encryptionRepository,
        ));
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: _databaseRepository,
      encryptionRepository: encryptionRepository,
    );
  }

  AppState get initialState => Uninitialized(userData: UserData.empty);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
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

  Stream<AppState> _mapAppStartedToState() async* {
    if (kIsWeb) {
      final isSignedIn = _authRepository.isSignedIn();
      if (isSignedIn) {
        await _authRepository.signOut();
      }
      yield Unauthenticated(userData: userData);
    } else {
      try {
        userData = _authRepository.getUserData();
        if (userData != UserData.empty) {
          _databaseRepository = DatabaseRepository(uid: userData.uid);
          UserData userData2 = await _databaseRepository.completeUserData;
          const storage = FlutterSecureStorage();
          String key = await storage.read(key: 'key') ?? 'KeyNotFound';
          encryptionRepository.updateKey(key);
          if (userData2 == UserData.empty) {
            yield PartiallyAuthenticated(userData: userData);
          } else {
            userData = userData2;
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

  // // When the User Logs in
  // FutureOr<void> _onLoginUser(LoginUser event, Emitter<AppState> emit) async {
  //   emit(LoginNewState.loading);
  //   try {
  //     // Login using email and password
  //     userData = await _authRepository.logInWithCredentials(
  //         event.email, event.password);
  //     // Update DatabaseRepository
  //     _databaseRepository = DatabaseRepository(uid: userData.uid);
  //     // After login fetch rest of the user details from database
  //     UserData completeUserData = await _databaseRepository.completeUserData;
  //     if (completeUserData != UserData.empty) {
  //       // if db fetch is successful
  //       userData = completeUserData;
  //       emit(Authenticated(userData: userData));
  //     } else {
  //       // if db fetch fails
  //       emit(const ErrorOccurred(error: 'Failed to fetch details!'));
  //     }
  //   } on Exception catch (e) {
  //     if (e is UserNotFoundException) {
  //       emit(LoginNewState.noUserFound);
  //     } else if (e is WrongPasswordException) {
  //       emit(LoginNewState.wrongPassword);
  //     } else {
  //       emit(LoginNewState.somethingWentWrong);
  //     }
  //   }
  // }
  //
  // // When the User Signs up
  // FutureOr<void> _onSignupUser(SignupUser event, Emitter<AppState> emit) async {
  //   emit(SignupNewState.loading);
  //   try {
  //     // Signup using email and password
  //     userData = await _authRepository.signUpUsingCredentials(
  //         event.email, event.password);
  //     // Update DatabaseRepository
  //     _databaseRepository = DatabaseRepository(uid: userData.uid);
  //     // Add User details to db
  //     UserData newUserData = UserData(
  //         uid: userData.uid,
  //         email: event.email,
  //         name: event.name,
  //         age: event.age);
  //     _databaseRepository.updateUserData(newUserData);
  //     userData = newUserData;
  //     emit(Authenticated(userData: userData));
  //   } on Exception catch (e) {
  //     if (e is EmailAlreadyInUseException) {
  //       emit(SignupNewState.userAlreadyExists);
  //     } else {
  //       emit(SignupNewState.somethingWentWrong);
  //     }
  //   }
  // }


  Stream<AppState> _mapAuthenticateUserToState() async* {
    yield Uninitialized(userData: userData);
    userData = _authRepository.getUserData();
    _databaseRepository = DatabaseRepository(uid: userData.uid);
    UserData userData2 = await _databaseRepository.completeUserData;
    updateBloc();
    if (!kIsWeb) {
      const storage = FlutterSecureStorage();
      String key = await storage.read(key: 'key') ?? 'KeyNotFound';
      encryptionRepository.updateKey(key);
    }
    if (userData2 == UserData.empty) {
      yield PartiallyAuthenticated(userData: userData);
    } else {
      userData = userData2;
      yield FullyAuthenticated(userData: userData);
    }
  }

  Stream<AppState> _mapUpdateUserDataToState(UpdateUserData event) async* {
    yield Uninitialized(userData: UserData.empty);
    userData = _authRepository.getUserData();
    UserData newUserData = UserData(
        uid: userData.uid,
        email: userData.email,
        firstName: event.firstName,
        lastName: event.lastName,
        photoUrl: event.photoUrl,
        pinSet: false,
        sortMethod: SortMethod.recentlyAdded);
    try {
      _databaseRepository = DatabaseRepository(uid: userData.uid);
      _databaseRepository.updateUserData(newUserData);
      _databaseRepository.addFolder(folderName: 'root/default');
      userData = newUserData;
      add(AuthenticateUser());
    } on Exception catch (_) {
      //TODO add exception
      print('Something Went Wrong');
    }
  }

  Stream<AppState> _mapLoggedOutToState() async* {
    userData = UserData.empty;
    _databaseRepository = DatabaseRepository(uid: userData.uid);
    updateBloc();
    await _authRepository.signOut();
    yield Unauthenticated(userData: userData);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
