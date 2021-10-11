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
  late DatabaseRepository databaseRepository;
  EncryptionRepository encryptionRepository = EncryptionRepository();
  late UserData userData;
  late DatabaseBloc databaseBloc;

  AppBloc({required authRepository})
      : _authRepository = authRepository,
        super(Uninitialized(userData: UserData.empty)) {
    userData = _authRepository.getUserData();
    databaseRepository = DatabaseRepository(uid: userData.uid);
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: databaseRepository,
      encryptionRepository: encryptionRepository,
    );
    on<AppStarted>(_onAppStarted);
    on<LoginUser>(_onLoginUser);
    on<SignupUser>(_onSignupUser);
    on<UpdateUserData>(_onUpdateUserData);
    on<LoggedOut>(_onLoggedOut);
  }

  void updateDatabaseBloc() {
    print('isSame?');
    print(databaseBloc ==
        DatabaseBloc(
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

  AppState get initialState => Uninitialized(userData: UserData.empty);

  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    if (kIsWeb) {
      // Web Logic
      final isSignedIn = _authRepository.isSignedIn();
      if (isSignedIn) {
        // As passwordHash is not saved on web, but the auth credentials are,
        // if the User is Signed in, sign out them.
        await _authRepository.signOut();
      }
      emit(Unauthenticated(userData: userData));
    } else {
      try {
        userData = _authRepository.getUserData();
        if (userData != UserData.empty) {
          // Update databaseRepo
          databaseRepository = DatabaseRepository(uid: userData.uid);
          // Fetch user data from db
          UserData completeUserData = await databaseRepository.completeUserData;
          // Get key from secure storage
          const storage = FlutterSecureStorage();
          String key = await storage.read(key: 'key') ?? 'KeyNotFound';
          // Update key in encryption repo
          encryptionRepository.updateKey(key);
          if (completeUserData != UserData.empty) {
            userData = completeUserData;
            // Update Database bloc
            updateDatabaseBloc();
            emit(Authenticated(userData: userData));
          } else {
            emit(const ErrorOccurred(error: 'Failed to fetch from db'));
          }
        } else {
          // Not logged in, So route to welcome page
          emit(Unauthenticated(userData: userData));
        }
      } on Exception catch (_) {
        print('error');
        emit(Unauthenticated(userData: UserData.empty));
      }
    }
  }

  // When the User Logs in
  FutureOr<void> _onLoginUser(LoginUser event, Emitter<AppState> emit) async {
    emit(LoginNewState.loading);
    try {
      // Login using email and password
      userData = await _authRepository.logInWithCredentials(
          event.email, event.password);

      // Update DatabaseRepository
      databaseRepository = DatabaseRepository(uid: userData.uid);
      // After login fetch rest of the user details from database
      UserData completeUserData = await databaseRepository.completeUserData;

      if (completeUserData != UserData.empty) {
        // if db fetch is successful
        userData = completeUserData;
        // Compute Password Hash
        await compute(EncryptionRepository.scryptHash, event.password)
            .then((passwordHash) {
          // Update key in encryption repo
          encryptionRepository.updateKey(passwordHash);
          // Storing password hash in Android
          if (!kIsWeb) {
            const storage = FlutterSecureStorage();
            storage.write(key: 'key', value: passwordHash);
          }
        });
        // Update DatabaseBloc after updating DatabaseRepository
        // and EncryptionRepository
        updateDatabaseBloc();
        emit(Authenticated(userData: userData));
      } else {
        // if db fetch fails
        emit(const ErrorOccurred(error: 'Failed to fetch details!'));
      }
    } on Exception catch (e) {
      if (e is UserNotFoundException) {
        emit(LoginNewState.noUserFound);
      } else if (e is WrongPasswordException) {
        emit(LoginNewState.wrongPassword);
      } else {
        emit(LoginNewState.somethingWentWrong);
      }
    }
  }

  // When the User Signs up
  FutureOr<void> _onSignupUser(SignupUser event, Emitter<AppState> emit) async {
    emit(SignupNewState.loading);
    try {
      // Signup using email and password
      userData = await _authRepository.signUpUsingCredentials(
          event.email, event.password);

      // Update DatabaseRepository
      databaseRepository = DatabaseRepository(uid: userData.uid);

      // Upload Profile Pic
      String photoUrl = '';
      if (event.photoUrl != null) {
        // TODO upload profilePic

      } else {
        // Default profile pic
        photoUrl = 'https://www.mgretails.com/assets/img/default.png';
      }
      // Add User details to db
      UserData newUserData = UserData(
        uid: userData.uid,
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        photoUrl: photoUrl,
        pinSet: false,
        sortMethod: SortMethod.recentlyAdded,
      );
      databaseRepository.updateUserData(newUserData);
      userData = newUserData;
      // Add default folder
      databaseRepository.addFolder(folderName: 'root/default');
      // Compute Password Hash
      await compute(EncryptionRepository.scryptHash, event.password)
          .then((passwordHash) {
        // Update key in encryption repo
        encryptionRepository.updateKey(passwordHash);
        // Storing password hash in Android
        if (!kIsWeb) {
          const storage = FlutterSecureStorage();
          storage.write(key: 'key', value: passwordHash);
        }
      });
      // Update DatabaseBloc after updating DatabaseRepository
      // and EncryptionRepository
      updateDatabaseBloc();
      emit(Authenticated(userData: userData));
    } on Exception catch (e) {
      if (e is EmailAlreadyInUseException) {
        emit(SignupNewState.userAlreadyExists);
      } else {
        emit(SignupNewState.somethingWentWrong);
      }
    }
  }

  FutureOr<void> _onUpdateUserData(
      UpdateUserData event, Emitter<AppState> emit) async {
    emit(Uninitialized(userData: UserData.empty));
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
      databaseRepository = DatabaseRepository(uid: userData.uid);
      databaseRepository.updateUserData(newUserData);
      databaseRepository.addFolder(folderName: 'root/default');
      userData = newUserData;
      // TODO change UpdateUserData

    } on Exception catch (_) {
      // TODO add exception
      print('Something Went Wrong');
    }
  }

  FutureOr<void> _onLoggedOut(LoggedOut event, Emitter<AppState> emit) async {
    userData = UserData.empty;
    databaseRepository = DatabaseRepository(uid: userData.uid);
    updateDatabaseBloc();
    await _authRepository.signOut();
    emit(Unauthenticated(userData: userData));
  }

  FutureOr<void> _onDeleteUser(LoggedOut event, Emitter<AppState> emit) async {
    userData = UserData.empty;
    databaseRepository = DatabaseRepository(uid: userData.uid);
    updateDatabaseBloc();
    await _authRepository.signOut();
    emit(Unauthenticated(userData: userData));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
