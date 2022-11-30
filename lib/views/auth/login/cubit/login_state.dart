part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(PageState.loading) PageState pageState,
  }) = _LoginState;
}
