import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/user/user.dart';
import 'package:passmate/repositories/auth_repository.dart';
import 'package:passmate/repositories/encryption_repository.dart';
import 'package:passmate/repositories/storage_repository.dart';
import 'package:passmate/repositories/user_repository.dart';

part 'app_bloc.freezed.dart';
part 'app_events.dart';
part 'app_states.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AuthRepository authRepository = AuthRepository();
  late UserRepository userRepository;
  EncryptionRepository encryptionRepository = EncryptionRepository();
  User user = const User();
  StorageRepository storageRepository = StorageRepository();

  AppBloc() : super(const AppState.uninitialised()) {
    user = authRepository.currentUser ?? const User();
    userRepository = UserRepository(user: user);
    on<AppStarted>(_onAppStarted);
    on<AuthenticateUser>(_onAuthenticateUser);
    on<UpdateUser>(_onUpdateUser);
    on<SignoutUser>(_onSignoutUser);
    on<WebAuthenticateUser>(_onWebAuthenticateUser);
  }

  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    try {
      emit(const AppState.uninitialised());
      if (authRepository.isSignedIn) {
        // Get current User from Firebase User
        User currentUser = authRepository.currentUser!;
        // Update UserRepository
        userRepository = UserRepository(user: currentUser);
        // Get User from Database
        User? completeUser = await userRepository.completeUser;
        if (completeUser != null) {
          // Update user in Bloc
          user = completeUser;
          if (kIsWeb) {
            emit(AppState.partiallyWebAuthenticated(user));
          } else {
            // Get key from secure storage
            String key =
                await storageRepository.readFromSecureStorage('key') ?? '';
            // Update key in encryption repo
            encryptionRepository.updateKey(key);
            emit(AppState.authenticated(user));
          }
        } else {
          emit(const AppState.errorOccurred());
        }
      } else {
        // User is Unauthenticated
        emit(const AppState.unauthenticated());
      }
    } catch (_) {
      emit(const AppState.errorOccurred());
    }
  }

  FutureOr<void> _onAuthenticateUser(
      AuthenticateUser event, Emitter<AppState> emit) async {
    try {
      // Update User
      user = event.user;
      // Update UserRepository
      userRepository = UserRepository(user: user);
      // Compute Password Hash
      await compute(EncryptionRepository.scryptHash, event.password)
          .then((passwordHash) {
        // Update key in encryption repo
        encryptionRepository.updateKey(passwordHash);
        // Storing password hash in Android
        if (!kIsWeb) {
          storageRepository.writeInSecureStorage(
              key: 'key', value: passwordHash);
        }
      });
      emit(AppState.authenticated(user));
    } catch (_) {
      emit(const AppState.errorOccurred());
    }
  }

  FutureOr<void> _onWebAuthenticateUser(
      WebAuthenticateUser event, Emitter<AppState> emit) async {
    try {
      // Update User
      user = event.user;
      // Update UserRepository
      userRepository = UserRepository(user: user);
      // Compute Password Hash
      await compute(EncryptionRepository.scryptHash, event.password)
          .then((passwordHash) {
        // Update key in encryption repo
        encryptionRepository.updateKey(passwordHash);
        // Storing password hash in Android
        if (!kIsWeb) {
          storageRepository.writeInSecureStorage(
              key: 'key', value: passwordHash);
        }
      });
      emit(AppState.authenticated(user));
    } catch (_) {
      emit(const AppState.errorOccurred());
    }
  }

  FutureOr<void> _onUpdateUser(UpdateUser event, Emitter<AppState> emit) async {
    // Update User
    user = event.user;
    emit(AppState.authenticated(user));
  }

  FutureOr<void> _onSignoutUser(
      SignoutUser event, Emitter<AppState> emit) async {
    // Update user
    user = const User();
    // Update UserRepository
    userRepository = UserRepository(user: user);
    // Update EncryptionRepository
    encryptionRepository.updateKey('');
    // Sign out user
    await authRepository.signOut();
    emit(const AppState.unauthenticated());
  }

  // FutureOr<void> _on(event, Emitter<AppState> emit) async {}
}
