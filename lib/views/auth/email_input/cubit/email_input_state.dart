part of 'email_input_cubit.dart';

@freezed
class EmailInputState with _$EmailInputState {
  const factory EmailInputState({
    @Default(true) bool emailValid,
    @Default(PageState.init) PageState pageState,
  }) = _EmailInputState;
}
