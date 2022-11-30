import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/bloc/app_bloc_new/app_bloc.dart';
import 'package:passmate/model/page_state.dart';

part 'email_input_state.dart';
part 'email_input_cubit.freezed.dart';

class EmailInputCubit extends Cubit<EmailInputState> {
  AppBloc authBloc;

  EmailInputCubit({required this.authBloc}) : super(const EmailInputState());

  void checkEmail(String email) async {
    emit(const EmailInputState(pageState: PageState.loading));
    try {
      bool? valid = await authBloc.authRepository.checkEmail(email);
      if (valid != null) {
        emit(EmailInputState(emailValid: valid, pageState: PageState.success));
      } else {
        emit(const EmailInputState(pageState: PageState.error));
      }
    } catch (_) {
      emit(const EmailInputState(pageState: PageState.error));
    }
  }
}
