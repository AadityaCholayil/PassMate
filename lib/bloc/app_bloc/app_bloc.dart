import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:passmate/bloc/database_bloc/database_barrel.dart';
import 'package:passmate/model/custom_exceptions.dart';
import 'package:passmate/model/user/sort_methods.dart';
import 'package:passmate/repositories/old_authentication_repository.dart';
import 'package:passmate/model/old_user.dart';
import 'package:passmate/repositories/old_database_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'app_bloc_files.dart';

class OldAppBloc extends Bloc<OldAppEvent, OldAppState> {
  final OldAuthRepository _authRepository;
  late OldDatabaseRepository databaseRepository;
  EncryptionRepository encryptionRepository = EncryptionRepository();
  late OldUserData userData;
  late DatabaseBloc databaseBloc;

  OldAppBloc({required authRepository})
      : _authRepository = authRepository,
        super(Uninitialized(userData: OldUserData.empty)) {
    userData = _authRepository.getUserData();
    databaseRepository = OldDatabaseRepository(uid: userData.uid);
    databaseBloc = DatabaseBloc(
      userData: userData,
      databaseRepository: databaseRepository,
      encryptionRepository: encryptionRepository,
    );
    on<AppStarted>(_onAppStarted);
    on<LoginUser>(_onLoginUser);
    on<CheckEmailStatus>(_onCheckEmailStatus);
    on<SignupUser>(_onSignupUser);
    on<UpdateUserData>(_onUpdateUserData);
    on<LoggedOut>(_onLoggedOut);
    on<DeleteUser>(_onDeleteUser);
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

  OldAppState get initialState => Uninitialized(userData: OldUserData.empty);

  FutureOr<void> _onAppStarted(
      AppStarted event, Emitter<OldAppState> emit) async {
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
        if (userData != OldUserData.empty) {
          // Update databaseRepo
          databaseRepository = OldDatabaseRepository(uid: userData.uid);
          // Fetch user data from db
          OldUserData completeUserData =
              await databaseRepository.completeUserData;
          // Get key from secure storage
          const storage = FlutterSecureStorage();
          String key = await storage.read(key: 'key') ?? 'KeyNotFound';
          // Update key in encryption repo
          encryptionRepository.updateKey(key);
          if (completeUserData != OldUserData.empty) {
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
        emit(Unauthenticated(userData: OldUserData.empty));
      }
    }
  }

  // When the User Logs in
  FutureOr<void> _onLoginUser(
      LoginUser event, Emitter<OldAppState> emit) async {
    emit(LoginPageState.loading);
    try {
      // Login using email and password
      userData = await _authRepository.logInWithCredentials(
          event.email, event.password);
      // Update DatabaseRepository
      databaseRepository = OldDatabaseRepository(uid: userData.uid);
      // After login fetch rest of the user details from database
      OldUserData completeUserData = await databaseRepository.completeUserData;
      if (completeUserData != OldUserData.empty) {
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
        emit(LoginPageState.noUserFound);
      } else if (e is WrongPasswordException) {
        emit(LoginPageState.wrongPassword);
      } else {
        emit(LoginPageState.somethingWentWrong);
      }
      emit(Unauthenticated(userData: userData));
    }
  }

  Future<void> _onCheckEmailStatus(
      CheckEmailStatus event, Emitter<OldAppState> emit) async {
    // emit loading
    emit(const EmailInputPageState(emailStatus: EmailStatus.loading));
    try {
      // Try to login with the email provided with null as password
      // This will throw an exception
      await _authRepository.logInWithCredentials(event.email, 'null');
    } on Exception catch (e) {
      if (e is UserNotFoundException) {
        // This means there was no existing user found for that email
        // Hence, the email is valid
        emit(const EmailInputPageState(emailStatus: EmailStatus.valid));
      } else {
        emit(const EmailInputPageState(emailStatus: EmailStatus.invalid));
      }
    }
  }

  // When the User Signs up
  FutureOr<void> _onSignupUser(
      SignupUser event, Emitter<OldAppState> emit) async {
    emit(SignupPageState.loading);
    try {
      // Signup using email and password
      userData = await _authRepository.signUpUsingCredentials(
          event.email, event.password);
      // Update DatabaseRepository
      databaseRepository = OldDatabaseRepository(uid: userData.uid);
      // Upload Profile Pic
      String photoUrl = '';
      if (event.image != null) {
        // Upload new image to Firebase storage
        String? res = await databaseRepository.uploadFile(event.image!);
        if (res != null) {
          photoUrl = res;
        } else {
          photoUrl =
              'https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg';
        }
      } else {
        // Default profile pic
        photoUrl =
            'https://icon-library.com/images/default-user-icon/default-user-icon-13.jpg';
      }
      // Add User details to db
      OldUserData newUserData = OldUserData(
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
        emit(SignupPageState.userAlreadyExists);
      } else {
        emit(SignupPageState.somethingWentWrong);
      }
      emit(Unauthenticated(userData: userData));
    }
  }

  FutureOr<void> _onUpdateUserData(
      UpdateUserData event, Emitter<OldAppState> emit) async {
    emit(EditProfilePageState.loading);
    try {
      // Get userData for uid and email
      OldUserData userDataTemp = _authRepository.getUserData();
      // Update databaseRepository
      databaseRepository = OldDatabaseRepository(uid: userDataTemp.uid);
      String photoUrl = '';
      if (event.image != null) {
        // Upload new image to Firebase storage
        String? res = await databaseRepository.uploadFile(event.image!);
        if (res != null) {
          photoUrl = res;
        } else {
          emit(EditProfilePageState.somethingWentWrong);
        }
      } else {
        // Keep the same photoUrl
        photoUrl = userData.photoUrl!;
      }
      // Create new userData object
      OldUserData newUserData = OldUserData(
          uid: userDataTemp.uid,
          email: userDataTemp.email,
          firstName: event.firstName,
          lastName: event.lastName,
          photoUrl: photoUrl,
          pinSet: false,
          sortMethod: SortMethod.recentlyAdded);
      // Update userData
      await databaseRepository.updateUserData(newUserData);
      userData = newUserData;
      emit(EditProfilePageState.success);
    } on Exception catch (_) {
      emit(EditProfilePageState.somethingWentWrong);
    }
  }

  FutureOr<void> _onLoggedOut(
      LoggedOut event, Emitter<OldAppState> emit) async {
    userData = OldUserData.empty;
    databaseRepository = OldDatabaseRepository(uid: userData.uid);
    encryptionRepository.updateKey('');
    updateDatabaseBloc();
    await _authRepository.signOut();
    emit(Unauthenticated(userData: userData));
  }

  FutureOr<void> _onDeleteUser(
      DeleteUser event, Emitter<OldAppState> emit) async {
    emit(DeleteAccountPageState.loading);
    if (event.email == userData.email) {
      try {
        await _authRepository.logInWithCredentials(event.email, event.password);
        try {
          await databaseRepository.deleteUserData();
          await databaseRepository.deleteProfilePicFromStorage();
          await _authRepository.deleteUser();
          userData = OldUserData.empty;
          databaseRepository = OldDatabaseRepository(uid: userData.uid);
          encryptionRepository.updateKey('');
          if (!kIsWeb) {
            const storage = FlutterSecureStorage();
            storage.write(key: 'key', value: '');
          }
          updateDatabaseBloc();
          emit(Unauthenticated(userData: userData));
        } on Exception catch (_) {
          emit(const ErrorOccurred(
              error: 'Unable to delete your account, Please try again!'));
        }
      } on Exception catch (_) {
        emit(DeleteAccountPageState.invalidCredentials);
      }
    } else {
      emit(DeleteAccountPageState.invalidCredentials);
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
