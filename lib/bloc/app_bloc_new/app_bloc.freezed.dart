// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppEventCopyWith<$Res> {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) then) =
      _$AppEventCopyWithImpl<$Res, AppEvent>;
}

/// @nodoc
class _$AppEventCopyWithImpl<$Res, $Val extends AppEvent>
    implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppStartedCopyWith<$Res> {
  factory _$$AppStartedCopyWith(
          _$AppStarted value, $Res Function(_$AppStarted) then) =
      __$$AppStartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppStartedCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$AppStarted>
    implements _$$AppStartedCopyWith<$Res> {
  __$$AppStartedCopyWithImpl(
      _$AppStarted _value, $Res Function(_$AppStarted) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AppStarted with DiagnosticableTreeMixin implements AppStarted {
  const _$AppStarted();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvent.appStarted()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AppEvent.appStarted'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppStarted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) {
    return appStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) {
    return appStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) {
    return appStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) {
    return appStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) {
    if (appStarted != null) {
      return appStarted(this);
    }
    return orElse();
  }
}

abstract class AppStarted implements AppEvent {
  const factory AppStarted() = _$AppStarted;
}

/// @nodoc
abstract class _$$AuthenticateUserCopyWith<$Res> {
  factory _$$AuthenticateUserCopyWith(
          _$AuthenticateUser value, $Res Function(_$AuthenticateUser) then) =
      __$$AuthenticateUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User user, String password});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticateUserCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$AuthenticateUser>
    implements _$$AuthenticateUserCopyWith<$Res> {
  __$$AuthenticateUserCopyWithImpl(
      _$AuthenticateUser _value, $Res Function(_$AuthenticateUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? password = null,
  }) {
    return _then(_$AuthenticateUser(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthenticateUser
    with DiagnosticableTreeMixin
    implements AuthenticateUser {
  const _$AuthenticateUser(this.user, this.password);

  @override
  final User user;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvent.authenticateUser(user: $user, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppEvent.authenticateUser'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticateUser &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticateUserCopyWith<_$AuthenticateUser> get copyWith =>
      __$$AuthenticateUserCopyWithImpl<_$AuthenticateUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) {
    return authenticateUser(user, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) {
    return authenticateUser?.call(user, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) {
    if (authenticateUser != null) {
      return authenticateUser(user, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) {
    return authenticateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) {
    return authenticateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) {
    if (authenticateUser != null) {
      return authenticateUser(this);
    }
    return orElse();
  }
}

abstract class AuthenticateUser implements AppEvent {
  const factory AuthenticateUser(final User user, final String password) =
      _$AuthenticateUser;

  User get user;
  String get password;
  @JsonKey(ignore: true)
  _$$AuthenticateUserCopyWith<_$AuthenticateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WebAuthenticateUserCopyWith<$Res> {
  factory _$$WebAuthenticateUserCopyWith(_$WebAuthenticateUser value,
          $Res Function(_$WebAuthenticateUser) then) =
      __$$WebAuthenticateUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User user, String password});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$WebAuthenticateUserCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$WebAuthenticateUser>
    implements _$$WebAuthenticateUserCopyWith<$Res> {
  __$$WebAuthenticateUserCopyWithImpl(
      _$WebAuthenticateUser _value, $Res Function(_$WebAuthenticateUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? password = null,
  }) {
    return _then(_$WebAuthenticateUser(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$WebAuthenticateUser
    with DiagnosticableTreeMixin
    implements WebAuthenticateUser {
  const _$WebAuthenticateUser(this.user, this.password);

  @override
  final User user;
  @override
  final String password;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvent.webAuthenticateUser(user: $user, password: $password)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppEvent.webAuthenticateUser'))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('password', password));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebAuthenticateUser &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebAuthenticateUserCopyWith<_$WebAuthenticateUser> get copyWith =>
      __$$WebAuthenticateUserCopyWithImpl<_$WebAuthenticateUser>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) {
    return webAuthenticateUser(user, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) {
    return webAuthenticateUser?.call(user, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) {
    if (webAuthenticateUser != null) {
      return webAuthenticateUser(user, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) {
    return webAuthenticateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) {
    return webAuthenticateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) {
    if (webAuthenticateUser != null) {
      return webAuthenticateUser(this);
    }
    return orElse();
  }
}

abstract class WebAuthenticateUser implements AppEvent {
  const factory WebAuthenticateUser(final User user, final String password) =
      _$WebAuthenticateUser;

  User get user;
  String get password;
  @JsonKey(ignore: true)
  _$$WebAuthenticateUserCopyWith<_$WebAuthenticateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignoutUserCopyWith<$Res> {
  factory _$$SignoutUserCopyWith(
          _$SignoutUser value, $Res Function(_$SignoutUser) then) =
      __$$SignoutUserCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignoutUserCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$SignoutUser>
    implements _$$SignoutUserCopyWith<$Res> {
  __$$SignoutUserCopyWithImpl(
      _$SignoutUser _value, $Res Function(_$SignoutUser) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SignoutUser with DiagnosticableTreeMixin implements SignoutUser {
  const _$SignoutUser();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvent.signoutUser()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AppEvent.signoutUser'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignoutUser);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) {
    return signoutUser();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) {
    return signoutUser?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) {
    if (signoutUser != null) {
      return signoutUser();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) {
    return signoutUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) {
    return signoutUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) {
    if (signoutUser != null) {
      return signoutUser(this);
    }
    return orElse();
  }
}

abstract class SignoutUser implements AppEvent {
  const factory SignoutUser() = _$SignoutUser;
}

/// @nodoc
abstract class _$$UpdateUserCopyWith<$Res> {
  factory _$$UpdateUserCopyWith(
          _$UpdateUser value, $Res Function(_$UpdateUser) then) =
      __$$UpdateUserCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$UpdateUserCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res, _$UpdateUser>
    implements _$$UpdateUserCopyWith<$Res> {
  __$$UpdateUserCopyWithImpl(
      _$UpdateUser _value, $Res Function(_$UpdateUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$UpdateUser(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$UpdateUser with DiagnosticableTreeMixin implements UpdateUser {
  const _$UpdateUser(this.user);

  @override
  final User user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppEvent.updateUser(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppEvent.updateUser'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateUser &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateUserCopyWith<_$UpdateUser> get copyWith =>
      __$$UpdateUserCopyWithImpl<_$UpdateUser>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() appStarted,
    required TResult Function(User user, String password) authenticateUser,
    required TResult Function(User user, String password) webAuthenticateUser,
    required TResult Function() signoutUser,
    required TResult Function(User user) updateUser,
  }) {
    return updateUser(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? appStarted,
    TResult? Function(User user, String password)? authenticateUser,
    TResult? Function(User user, String password)? webAuthenticateUser,
    TResult? Function()? signoutUser,
    TResult? Function(User user)? updateUser,
  }) {
    return updateUser?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? appStarted,
    TResult Function(User user, String password)? authenticateUser,
    TResult Function(User user, String password)? webAuthenticateUser,
    TResult Function()? signoutUser,
    TResult Function(User user)? updateUser,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AppStarted value) appStarted,
    required TResult Function(AuthenticateUser value) authenticateUser,
    required TResult Function(WebAuthenticateUser value) webAuthenticateUser,
    required TResult Function(SignoutUser value) signoutUser,
    required TResult Function(UpdateUser value) updateUser,
  }) {
    return updateUser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AppStarted value)? appStarted,
    TResult? Function(AuthenticateUser value)? authenticateUser,
    TResult? Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult? Function(SignoutUser value)? signoutUser,
    TResult? Function(UpdateUser value)? updateUser,
  }) {
    return updateUser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AppStarted value)? appStarted,
    TResult Function(AuthenticateUser value)? authenticateUser,
    TResult Function(WebAuthenticateUser value)? webAuthenticateUser,
    TResult Function(SignoutUser value)? signoutUser,
    TResult Function(UpdateUser value)? updateUser,
    required TResult orElse(),
  }) {
    if (updateUser != null) {
      return updateUser(this);
    }
    return orElse();
  }
}

abstract class UpdateUser implements AppEvent {
  const factory UpdateUser(final User user) = _$UpdateUser;

  User get user;
  @JsonKey(ignore: true)
  _$$UpdateUserCopyWith<_$UpdateUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_UninitialisedCopyWith<$Res> {
  factory _$$_UninitialisedCopyWith(
          _$_Uninitialised value, $Res Function(_$_Uninitialised) then) =
      __$$_UninitialisedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UninitialisedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_Uninitialised>
    implements _$$_UninitialisedCopyWith<$Res> {
  __$$_UninitialisedCopyWithImpl(
      _$_Uninitialised _value, $Res Function(_$_Uninitialised) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Uninitialised with DiagnosticableTreeMixin implements _Uninitialised {
  const _$_Uninitialised();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState.uninitialised()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AppState.uninitialised'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Uninitialised);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) {
    return uninitialised();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) {
    return uninitialised?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) {
    if (uninitialised != null) {
      return uninitialised();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return uninitialised(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return uninitialised?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (uninitialised != null) {
      return uninitialised(this);
    }
    return orElse();
  }
}

abstract class _Uninitialised implements AppState {
  const factory _Uninitialised() = _$_Uninitialised;
}

/// @nodoc
abstract class _$$_UnauthenticatedCopyWith<$Res> {
  factory _$$_UnauthenticatedCopyWith(
          _$_Unauthenticated value, $Res Function(_$_Unauthenticated) then) =
      __$$_UnauthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_UnauthenticatedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_Unauthenticated>
    implements _$$_UnauthenticatedCopyWith<$Res> {
  __$$_UnauthenticatedCopyWithImpl(
      _$_Unauthenticated _value, $Res Function(_$_Unauthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Unauthenticated
    with DiagnosticableTreeMixin
    implements _Unauthenticated {
  const _$_Unauthenticated();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState.unauthenticated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AppState.unauthenticated'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Unauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AppState {
  const factory _Unauthenticated() = _$_Unauthenticated;
}

/// @nodoc
abstract class _$$_AuthenticatedCopyWith<$Res> {
  factory _$$_AuthenticatedCopyWith(
          _$_Authenticated value, $Res Function(_$_Authenticated) then) =
      __$$_AuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_AuthenticatedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_Authenticated>
    implements _$$_AuthenticatedCopyWith<$Res> {
  __$$_AuthenticatedCopyWithImpl(
      _$_Authenticated _value, $Res Function(_$_Authenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$_Authenticated(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$_Authenticated with DiagnosticableTreeMixin implements _Authenticated {
  const _$_Authenticated(this.user);

  @override
  final User user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState.authenticated(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState.authenticated'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Authenticated &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthenticatedCopyWith<_$_Authenticated> get copyWith =>
      __$$_AuthenticatedCopyWithImpl<_$_Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AppState {
  const factory _Authenticated(final User user) = _$_Authenticated;

  User get user;
  @JsonKey(ignore: true)
  _$$_AuthenticatedCopyWith<_$_Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_PartiallyWebAuthenticatedCopyWith<$Res> {
  factory _$$_PartiallyWebAuthenticatedCopyWith(
          _$_PartiallyWebAuthenticated value,
          $Res Function(_$_PartiallyWebAuthenticated) then) =
      __$$_PartiallyWebAuthenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_PartiallyWebAuthenticatedCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_PartiallyWebAuthenticated>
    implements _$$_PartiallyWebAuthenticatedCopyWith<$Res> {
  __$$_PartiallyWebAuthenticatedCopyWithImpl(
      _$_PartiallyWebAuthenticated _value,
      $Res Function(_$_PartiallyWebAuthenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$_PartiallyWebAuthenticated(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$_PartiallyWebAuthenticated
    with DiagnosticableTreeMixin
    implements _PartiallyWebAuthenticated {
  const _$_PartiallyWebAuthenticated(this.user);

  @override
  final User user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState.partiallyWebAuthenticated(user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppState.partiallyWebAuthenticated'))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PartiallyWebAuthenticated &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PartiallyWebAuthenticatedCopyWith<_$_PartiallyWebAuthenticated>
      get copyWith => __$$_PartiallyWebAuthenticatedCopyWithImpl<
          _$_PartiallyWebAuthenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) {
    return partiallyWebAuthenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) {
    return partiallyWebAuthenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) {
    if (partiallyWebAuthenticated != null) {
      return partiallyWebAuthenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return partiallyWebAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return partiallyWebAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (partiallyWebAuthenticated != null) {
      return partiallyWebAuthenticated(this);
    }
    return orElse();
  }
}

abstract class _PartiallyWebAuthenticated implements AppState {
  const factory _PartiallyWebAuthenticated(final User user) =
      _$_PartiallyWebAuthenticated;

  User get user;
  @JsonKey(ignore: true)
  _$$_PartiallyWebAuthenticatedCopyWith<_$_PartiallyWebAuthenticated>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ErrorOccurredCopyWith<$Res> {
  factory _$$_ErrorOccurredCopyWith(
          _$_ErrorOccurred value, $Res Function(_$_ErrorOccurred) then) =
      __$$_ErrorOccurredCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ErrorOccurredCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_ErrorOccurred>
    implements _$$_ErrorOccurredCopyWith<$Res> {
  __$$_ErrorOccurredCopyWithImpl(
      _$_ErrorOccurred _value, $Res Function(_$_ErrorOccurred) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_ErrorOccurred with DiagnosticableTreeMixin implements _ErrorOccurred {
  const _$_ErrorOccurred();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppState.errorOccurred()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'AppState.errorOccurred'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_ErrorOccurred);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() uninitialised,
    required TResult Function() unauthenticated,
    required TResult Function(User user) authenticated,
    required TResult Function(User user) partiallyWebAuthenticated,
    required TResult Function() errorOccurred,
  }) {
    return errorOccurred();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? uninitialised,
    TResult? Function()? unauthenticated,
    TResult? Function(User user)? authenticated,
    TResult? Function(User user)? partiallyWebAuthenticated,
    TResult? Function()? errorOccurred,
  }) {
    return errorOccurred?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? uninitialised,
    TResult Function()? unauthenticated,
    TResult Function(User user)? authenticated,
    TResult Function(User user)? partiallyWebAuthenticated,
    TResult Function()? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Uninitialised value) uninitialised,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_PartiallyWebAuthenticated value)
        partiallyWebAuthenticated,
    required TResult Function(_ErrorOccurred value) errorOccurred,
  }) {
    return errorOccurred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Uninitialised value)? uninitialised,
    TResult? Function(_Unauthenticated value)? unauthenticated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult? Function(_ErrorOccurred value)? errorOccurred,
  }) {
    return errorOccurred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Uninitialised value)? uninitialised,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_PartiallyWebAuthenticated value)?
        partiallyWebAuthenticated,
    TResult Function(_ErrorOccurred value)? errorOccurred,
    required TResult orElse(),
  }) {
    if (errorOccurred != null) {
      return errorOccurred(this);
    }
    return orElse();
  }
}

abstract class _ErrorOccurred implements AppState {
  const factory _ErrorOccurred() = _$_ErrorOccurred;
}
