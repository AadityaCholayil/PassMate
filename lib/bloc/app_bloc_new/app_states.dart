// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'package:passmate/model/old_user.dart';

part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.uninitialised() = _Uninitialised;
  const factory AppState.unauthenticated() = _Unauthenticated;
  const factory AppState.authenticated(User user) = _Authenticated;
  const factory AppState.partiallyWebAuthenticated(User user) = _PartiallyWebAuthenticated;
  const factory AppState.errorOccurred() = _ErrorOccurred;
}

