// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SecureNote _$$_SecureNoteFromJson(Map<String, dynamic> json) =>
    _$_SecureNote(
      json['id'] as String,
      json['path'] as String,
      json['title'] as String,
      json['content'] as String,
      json['favourite'] as bool,
      json['usage'] as int,
      const TimestampConverter().fromJson(json['lastUsed'] as Timestamp),
      const TimestampConverter().fromJson(json['timeAdded'] as Timestamp),
    );

Map<String, dynamic> _$$_SecureNoteToJson(_$_SecureNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'title': instance.title,
      'content': instance.content,
      'favourite': instance.favourite,
      'usage': instance.usage,
      'lastUsed': const TimestampConverter().toJson(instance.lastUsed),
      'timeAdded': const TimestampConverter().toJson(instance.timeAdded),
    };
