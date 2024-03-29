// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get uid => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  bool? get pinSet => throw _privateConstructorUsedError;
  SortMethod? get sortMethod => throw _privateConstructorUsedError;
  List<String>? get folderList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? firstName,
      String? lastName,
      String? photoUrl,
      bool? pinSet,
      SortMethod? sortMethod,
      List<String>? folderList});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? photoUrl = freezed,
    Object? pinSet = freezed,
    Object? sortMethod = freezed,
    Object? folderList = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinSet: freezed == pinSet
          ? _value.pinSet
          : pinSet // ignore: cast_nullable_to_non_nullable
              as bool?,
      sortMethod: freezed == sortMethod
          ? _value.sortMethod
          : sortMethod // ignore: cast_nullable_to_non_nullable
              as SortMethod?,
      folderList: freezed == folderList
          ? _value.folderList
          : folderList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String? email,
      String? firstName,
      String? lastName,
      String? photoUrl,
      bool? pinSet,
      SortMethod? sortMethod,
      List<String>? folderList});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? photoUrl = freezed,
    Object? pinSet = freezed,
    Object? sortMethod = freezed,
    Object? folderList = freezed,
  }) {
    return _then(_$_User(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      pinSet: freezed == pinSet
          ? _value.pinSet
          : pinSet // ignore: cast_nullable_to_non_nullable
              as bool?,
      sortMethod: freezed == sortMethod
          ? _value.sortMethod
          : sortMethod // ignore: cast_nullable_to_non_nullable
              as SortMethod?,
      folderList: freezed == folderList
          ? _value._folderList
          : folderList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User extends _User {
  const _$_User(
      {this.uid = '',
      this.email,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.pinSet,
      this.sortMethod,
      final List<String>? folderList})
      : _folderList = folderList,
        super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @JsonKey()
  final String uid;
  @override
  final String? email;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? photoUrl;
  @override
  final bool? pinSet;
  @override
  final SortMethod? sortMethod;
  final List<String>? _folderList;
  @override
  List<String>? get folderList {
    final value = _folderList;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, photoUrl: $photoUrl, pinSet: $pinSet, sortMethod: $sortMethod, folderList: $folderList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.pinSet, pinSet) || other.pinSet == pinSet) &&
            (identical(other.sortMethod, sortMethod) ||
                other.sortMethod == sortMethod) &&
            const DeepCollectionEquality()
                .equals(other._folderList, _folderList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      firstName,
      lastName,
      photoUrl,
      pinSet,
      sortMethod,
      const DeepCollectionEquality().hash(_folderList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User extends User {
  const factory _User(
      {final String uid,
      final String? email,
      final String? firstName,
      final String? lastName,
      final String? photoUrl,
      final bool? pinSet,
      final SortMethod? sortMethod,
      final List<String>? folderList}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get uid;
  @override
  String? get email;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get photoUrl;
  @override
  bool? get pinSet;
  @override
  SortMethod? get sortMethod;
  @override
  List<String>? get folderList;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
