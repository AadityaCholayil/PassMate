// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Password _$$_PasswordFromJson(Map<String, dynamic> json) => _$_Password(
      json['id'] as String,
      json['path'] as String,
      json['siteName'] as String,
      json['siteUrl'] as String,
      json['email'] as String,
      json['password'] as String,
      json['imageUrl'] as String,
      json['note'] as String,
      $enumDecode(_$PasswordCategoryEnumMap, json['category']),
      json['favourite'] as bool,
      json['usage'] as int,
      const TimestampConverter().fromJson(json['lastUsed'] as Timestamp),
      const TimestampConverter().fromJson(json['timeAdded'] as Timestamp),
    );

Map<String, dynamic> _$$_PasswordToJson(_$_Password instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'siteName': instance.siteName,
      'siteUrl': instance.siteUrl,
      'email': instance.email,
      'password': instance.password,
      'imageUrl': instance.imageUrl,
      'note': instance.note,
      'category': _$PasswordCategoryEnumMap[instance.category]!,
      'favourite': instance.favourite,
      'usage': instance.usage,
      'lastUsed': const TimestampConverter().toJson(instance.lastUsed),
      'timeAdded': const TimestampConverter().toJson(instance.timeAdded),
    };

const _$PasswordCategoryEnumMap = {
  PasswordCategory.all: 'all',
  PasswordCategory.social: 'social',
  PasswordCategory.work: 'work',
  PasswordCategory.entertainment: 'entertainment',
  PasswordCategory.finance: 'finance',
  PasswordCategory.education: 'education',
  PasswordCategory.ecommerce: 'ecommerce',
  PasswordCategory.others: 'others',
};
