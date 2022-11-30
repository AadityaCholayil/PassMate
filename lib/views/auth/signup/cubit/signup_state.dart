part of 'signup_cubit.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    @Default(PageState.loading) PageState pageState,
  }) = _SignupState;
}
