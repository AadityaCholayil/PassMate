import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/bloc/app_bloc_new/app_bloc.dart';
import 'package:passmate/model/page_state.dart';
import 'package:passmate/model/user/sort_methods.dart';
import 'package:passmate/model/user/user.dart';
import 'package:passmate/repositories/cloud_storage_repository.dart';
import 'package:passmate/repositories/user_repository.dart';
import 'package:passmate/shared/my_default_assets.dart';

part 'signup_state.dart';
part 'signup_cubit.freezed.dart';

class SignupCubit extends Cubit<SignupState> {
  AppBloc appBloc;

  SignupCubit({required this.appBloc}) : super(const SignupState());

  void signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required File? image,
  }) async {
    emit(const SignupState(pageState: PageState.loading));
    try {
      User? user =
          await appBloc.authRepository.logInWithCredentials(email, password);
      if (user != null) {
        CloudStorageRepository cloudStorageRepository =
            CloudStorageRepository(user: user);
        // Upload Profile Pic
        String photoUrl = MyDefaultAssets.profileUrl;
        if (image != null) {
          // Upload new image to Firebase storage
          String? res = await cloudStorageRepository.uploadFile(image);
          if (res != null) {
            photoUrl = res;
          }
        }
        // Create new user
        user = user.copyWith(
          email: email,
          firstName: firstName,
          lastName: lastName,
          photoUrl: photoUrl,
          pinSet: false,
          sortMethod: SortMethod.recentlyAdded,
          folderList: ['root/default'],
        );
        // Create UserRepository
        UserRepository userRepository = UserRepository(user: user);
        // Add user to db
        await userRepository.updateUser(user);
        // Emit success
        emit(const SignupState(pageState: PageState.success));
        // Redirect after some delay
        await Future.delayed(const Duration(milliseconds: 1500));
        appBloc.add(AppEvent.authenticateUser(user, password));
      } else {
        emit(const SignupState(pageState: PageState.error));
      }
    } catch (_) {
      emit(const SignupState(pageState: PageState.error));
    }
  }
}
