// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'email_input_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EmailInputState {
  bool get emailValid => throw _privateConstructorUsedError;
  PageState get pageState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EmailInputStateCopyWith<EmailInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailInputStateCopyWith<$Res> {
  factory $EmailInputStateCopyWith(
          EmailInputState value, $Res Function(EmailInputState) then) =
      _$EmailInputStateCopyWithImpl<$Res, EmailInputState>;
  @useResult
  $Res call({bool emailValid, PageState pageState});
}

/// @nodoc
class _$EmailInputStateCopyWithImpl<$Res, $Val extends EmailInputState>
    implements $EmailInputStateCopyWith<$Res> {
  _$EmailInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailValid = null,
    Object? pageState = null,
  }) {
    return _then(_value.copyWith(
      emailValid: null == emailValid
          ? _value.emailValid
          : emailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as PageState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EmailInputStateCopyWith<$Res>
    implements $EmailInputStateCopyWith<$Res> {
  factory _$$_EmailInputStateCopyWith(
          _$_EmailInputState value, $Res Function(_$_EmailInputState) then) =
      __$$_EmailInputStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool emailValid, PageState pageState});
}

/// @nodoc
class __$$_EmailInputStateCopyWithImpl<$Res>
    extends _$EmailInputStateCopyWithImpl<$Res, _$_EmailInputState>
    implements _$$_EmailInputStateCopyWith<$Res> {
  __$$_EmailInputStateCopyWithImpl(
      _$_EmailInputState _value, $Res Function(_$_EmailInputState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailValid = null,
    Object? pageState = null,
  }) {
    return _then(_$_EmailInputState(
      emailValid: null == emailValid
          ? _value.emailValid
          : emailValid // ignore: cast_nullable_to_non_nullable
              as bool,
      pageState: null == pageState
          ? _value.pageState
          : pageState // ignore: cast_nullable_to_non_nullable
              as PageState,
    ));
  }
}

/// @nodoc

class _$_EmailInputState implements _EmailInputState {
  const _$_EmailInputState(
      {this.emailValid = true, this.pageState = PageState.init});

  @override
  @JsonKey()
  final bool emailValid;
  @override
  @JsonKey()
  final PageState pageState;

  @override
  String toString() {
    return 'EmailInputState(emailValid: $emailValid, pageState: $pageState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EmailInputState &&
            (identical(other.emailValid, emailValid) ||
                other.emailValid == emailValid) &&
            (identical(other.pageState, pageState) ||
                other.pageState == pageState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emailValid, pageState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EmailInputStateCopyWith<_$_EmailInputState> get copyWith =>
      __$$_EmailInputStateCopyWithImpl<_$_EmailInputState>(this, _$identity);
}

abstract class _EmailInputState implements EmailInputState {
  const factory _EmailInputState(
      {final bool emailValid, final PageState pageState}) = _$_EmailInputState;

  @override
  bool get emailValid;
  @override
  PageState get pageState;
  @override
  @JsonKey(ignore: true)
  _$$_EmailInputStateCopyWith<_$_EmailInputState> get copyWith =>
      throw _privateConstructorUsedError;
}
