// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'secure_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SecureNote _$SecureNoteFromJson(Map<String, dynamic> json) {
  return _SecureNote.fromJson(json);
}

/// @nodoc
mixin _$SecureNote {
  String get id => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get favourite => throw _privateConstructorUsedError;
  int get usage => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get lastUsed => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timeAdded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecureNoteCopyWith<SecureNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecureNoteCopyWith<$Res> {
  factory $SecureNoteCopyWith(
          SecureNote value, $Res Function(SecureNote) then) =
      _$SecureNoteCopyWithImpl<$Res, SecureNote>;
  @useResult
  $Res call(
      {String id,
      String path,
      String title,
      String content,
      bool favourite,
      int usage,
      @TimestampConverter() DateTime lastUsed,
      @TimestampConverter() DateTime timeAdded});
}

/// @nodoc
class _$SecureNoteCopyWithImpl<$Res, $Val extends SecureNote>
    implements $SecureNoteCopyWith<$Res> {
  _$SecureNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? title = null,
    Object? content = null,
    Object? favourite = null,
    Object? usage = null,
    Object? lastUsed = null,
    Object? timeAdded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      favourite: null == favourite
          ? _value.favourite
          : favourite // ignore: cast_nullable_to_non_nullable
              as bool,
      usage: null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as int,
      lastUsed: null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      timeAdded: null == timeAdded
          ? _value.timeAdded
          : timeAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SecureNoteCopyWith<$Res>
    implements $SecureNoteCopyWith<$Res> {
  factory _$$_SecureNoteCopyWith(
          _$_SecureNote value, $Res Function(_$_SecureNote) then) =
      __$$_SecureNoteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String path,
      String title,
      String content,
      bool favourite,
      int usage,
      @TimestampConverter() DateTime lastUsed,
      @TimestampConverter() DateTime timeAdded});
}

/// @nodoc
class __$$_SecureNoteCopyWithImpl<$Res>
    extends _$SecureNoteCopyWithImpl<$Res, _$_SecureNote>
    implements _$$_SecureNoteCopyWith<$Res> {
  __$$_SecureNoteCopyWithImpl(
      _$_SecureNote _value, $Res Function(_$_SecureNote) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? path = null,
    Object? title = null,
    Object? content = null,
    Object? favourite = null,
    Object? usage = null,
    Object? lastUsed = null,
    Object? timeAdded = null,
  }) {
    return _then(_$_SecureNote(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      null == favourite
          ? _value.favourite
          : favourite // ignore: cast_nullable_to_non_nullable
              as bool,
      null == usage
          ? _value.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as int,
      null == lastUsed
          ? _value.lastUsed
          : lastUsed // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == timeAdded
          ? _value.timeAdded
          : timeAdded // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SecureNote extends _SecureNote {
  const _$_SecureNote(
      this.id,
      this.path,
      this.title,
      this.content,
      this.favourite,
      this.usage,
      @TimestampConverter() this.lastUsed,
      @TimestampConverter() this.timeAdded)
      : super._();

  factory _$_SecureNote.fromJson(Map<String, dynamic> json) =>
      _$$_SecureNoteFromJson(json);

  @override
  final String id;
  @override
  final String path;
  @override
  final String title;
  @override
  final String content;
  @override
  final bool favourite;
  @override
  final int usage;
  @override
  @TimestampConverter()
  final DateTime lastUsed;
  @override
  @TimestampConverter()
  final DateTime timeAdded;

  @override
  String toString() {
    return 'SecureNote(id: $id, path: $path, title: $title, content: $content, favourite: $favourite, usage: $usage, lastUsed: $lastUsed, timeAdded: $timeAdded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecureNote &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.favourite, favourite) ||
                other.favourite == favourite) &&
            (identical(other.usage, usage) || other.usage == usage) &&
            (identical(other.lastUsed, lastUsed) ||
                other.lastUsed == lastUsed) &&
            (identical(other.timeAdded, timeAdded) ||
                other.timeAdded == timeAdded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, path, title, content,
      favourite, usage, lastUsed, timeAdded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecureNoteCopyWith<_$_SecureNote> get copyWith =>
      __$$_SecureNoteCopyWithImpl<_$_SecureNote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecureNoteToJson(
      this,
    );
  }
}

abstract class _SecureNote extends SecureNote {
  const factory _SecureNote(
      final String id,
      final String path,
      final String title,
      final String content,
      final bool favourite,
      final int usage,
      @TimestampConverter() final DateTime lastUsed,
      @TimestampConverter() final DateTime timeAdded) = _$_SecureNote;
  const _SecureNote._() : super._();

  factory _SecureNote.fromJson(Map<String, dynamic> json) =
      _$_SecureNote.fromJson;

  @override
  String get id;
  @override
  String get path;
  @override
  String get title;
  @override
  String get content;
  @override
  bool get favourite;
  @override
  int get usage;
  @override
  @TimestampConverter()
  DateTime get lastUsed;
  @override
  @TimestampConverter()
  DateTime get timeAdded;
  @override
  @JsonKey(ignore: true)
  _$$_SecureNoteCopyWith<_$_SecureNote> get copyWith =>
      throw _privateConstructorUsedError;
}
