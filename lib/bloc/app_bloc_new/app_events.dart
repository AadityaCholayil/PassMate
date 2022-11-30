part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.appStarted() = AppStarted;

  const factory AppEvent.authenticateUser(User user, String password) =
      AuthenticateUser;

  const factory AppEvent.webAuthenticateUser(User user, String password) =
      WebAuthenticateUser;

  const factory AppEvent.signoutUser() = SignoutUser;
  
  const factory AppEvent.updateUser(User user) = UpdateUser;
}
