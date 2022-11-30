import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/bloc/app_bloc_new/app_bloc.dart';
import 'package:passmate/model/page_state.dart';
import 'package:passmate/model/user/user.dart';
import 'package:passmate/repositories/user_repository.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  AppBloc appBloc;

  LoginCubit({required this.appBloc}) : super(const LoginState());

  void login(String email, String password) async {
    emit(const LoginState(pageState: PageState.loading));
    try {
      User? user =
          await appBloc.authRepository.logInWithCredentials(email, password);
      if (user != null) {
        UserRepository userRepository = UserRepository(user: user);
        user = await userRepository.completeUser;
        if (user != null) {
          emit(const LoginState(pageState: PageState.success));
          await Future.delayed(const Duration(milliseconds: 1500));
          appBloc.add(AppEvent.authenticateUser(user, password));
        } else {
          emit(const LoginState(pageState: PageState.error));
        }
      } else {
        emit(const LoginState(pageState: PageState.error));
      }
    } catch (_) {
      emit(const LoginState(pageState: PageState.error));
    }
  }
}
