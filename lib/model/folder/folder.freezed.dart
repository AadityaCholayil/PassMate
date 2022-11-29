// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Folder _$FolderFromJson(Map<String, dynamic> json) {
  return _Folder.fromJson(json);
}

/// @nodoc
mixin _$Folder {
  String get folderName => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  List<String> get subFolderList => throw _privateConstructorUsedError;
  List<Password> get passwordList => throw _privateConstructorUsedError;
  List<PaymentCard> get paymentCardList => throw _privateConstructorUsedError;
  List<SecureNote> get secureNotesList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FolderCopyWith<Folder> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FolderCopyWith<$Res> {
  factory $FolderCopyWith(Folder value, $Res Function(Folder) then) =
      _$FolderCopyWithImpl<$Res, Folder>;
  @useResult
  $Res call(
      {String folderName,
      String path,
      List<String> subFolderList,
      List<Password> passwordList,
      List<PaymentCard> paymentCardList,
      List<SecureNote> secureNotesList});
}

/// @nodoc
class _$FolderCopyWithImpl<$Res, $Val extends Folder>
    implements $FolderCopyWith<$Res> {
  _$FolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folderName = null,
    Object? path = null,
    Object? subFolderList = null,
    Object? passwordList = null,
    Object? paymentCardList = null,
    Object? secureNotesList = null,
  }) {
    return _then(_value.copyWith(
      folderName: null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      subFolderList: null == subFolderList
          ? _value.subFolderList
          : subFolderList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      passwordList: null == passwordList
          ? _value.passwordList
          : passwordList // ignore: cast_nullable_to_non_nullable
              as List<Password>,
      paymentCardList: null == paymentCardList
          ? _value.paymentCardList
          : paymentCardList // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
      secureNotesList: null == secureNotesList
          ? _value.secureNotesList
          : secureNotesList // ignore: cast_nullable_to_non_nullable
              as List<SecureNote>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FolderCopyWith<$Res> implements $FolderCopyWith<$Res> {
  factory _$$_FolderCopyWith(_$_Folder value, $Res Function(_$_Folder) then) =
      __$$_FolderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String folderName,
      String path,
      List<String> subFolderList,
      List<Password> passwordList,
      List<PaymentCard> paymentCardList,
      List<SecureNote> secureNotesList});
}

/// @nodoc
class __$$_FolderCopyWithImpl<$Res>
    extends _$FolderCopyWithImpl<$Res, _$_Folder>
    implements _$$_FolderCopyWith<$Res> {
  __$$_FolderCopyWithImpl(_$_Folder _value, $Res Function(_$_Folder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? folderName = null,
    Object? path = null,
    Object? subFolderList = null,
    Object? passwordList = null,
    Object? paymentCardList = null,
    Object? secureNotesList = null,
  }) {
    return _then(_$_Folder(
      null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      null == subFolderList
          ? _value._subFolderList
          : subFolderList // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == passwordList
          ? _value._passwordList
          : passwordList // ignore: cast_nullable_to_non_nullable
              as List<Password>,
      null == paymentCardList
          ? _value._paymentCardList
          : paymentCardList // ignore: cast_nullable_to_non_nullable
              as List<PaymentCard>,
      null == secureNotesList
          ? _value._secureNotesList
          : secureNotesList // ignore: cast_nullable_to_non_nullable
              as List<SecureNote>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Folder extends _Folder {
  const _$_Folder(
      this.folderName,
      this.path,
      final List<String> subFolderList,
      final List<Password> passwordList,
      final List<PaymentCard> paymentCardList,
      final List<SecureNote> secureNotesList)
      : _subFolderList = subFolderList,
        _passwordList = passwordList,
        _paymentCardList = paymentCardList,
        _secureNotesList = secureNotesList,
        super._();

  factory _$_Folder.fromJson(Map<String, dynamic> json) =>
      _$$_FolderFromJson(json);

  @override
  final String folderName;
  @override
  final String path;
  final List<String> _subFolderList;
  @override
  List<String> get subFolderList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subFolderList);
  }

  final List<Password> _passwordList;
  @override
  List<Password> get passwordList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_passwordList);
  }

  final List<PaymentCard> _paymentCardList;
  @override
  List<PaymentCard> get paymentCardList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentCardList);
  }

  final List<SecureNote> _secureNotesList;
  @override
  List<SecureNote> get secureNotesList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secureNotesList);
  }

  @override
  String toString() {
    return 'Folder(folderName: $folderName, path: $path, subFolderList: $subFolderList, passwordList: $passwordList, paymentCardList: $paymentCardList, secureNotesList: $secureNotesList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Folder &&
            (identical(other.folderName, folderName) ||
                other.folderName == folderName) &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality()
                .equals(other._subFolderList, _subFolderList) &&
            const DeepCollectionEquality()
                .equals(other._passwordList, _passwordList) &&
            const DeepCollectionEquality()
                .equals(other._paymentCardList, _paymentCardList) &&
            const DeepCollectionEquality()
                .equals(other._secureNotesList, _secureNotesList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      folderName,
      path,
      const DeepCollectionEquality().hash(_subFolderList),
      const DeepCollectionEquality().hash(_passwordList),
      const DeepCollectionEquality().hash(_paymentCardList),
      const DeepCollectionEquality().hash(_secureNotesList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      __$$_FolderCopyWithImpl<_$_Folder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FolderToJson(
      this,
    );
  }
}

abstract class _Folder extends Folder {
  const factory _Folder(
      final String folderName,
      final String path,
      final List<String> subFolderList,
      final List<Password> passwordList,
      final List<PaymentCard> paymentCardList,
      final List<SecureNote> secureNotesList) = _$_Folder;
  const _Folder._() : super._();

  factory _Folder.fromJson(Map<String, dynamic> json) = _$_Folder.fromJson;

  @override
  String get folderName;
  @override
  String get path;
  @override
  List<String> get subFolderList;
  @override
  List<Password> get passwordList;
  @override
  List<PaymentCard> get paymentCardList;
  @override
  List<SecureNote> get secureNotesList;
  @override
  @JsonKey(ignore: true)
  _$$_FolderCopyWith<_$_Folder> get copyWith =>
      throw _privateConstructorUsedError;
}
