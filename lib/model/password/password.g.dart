// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Password _$$_PasswordFromJson(Map<String, dynamic> json) => _$_Password(
      id: json['id'] as String? ?? '',
      path: json['path'] as String? ?? '',
      siteName: json['siteName'] as String? ?? '',
      siteUrl: json['siteUrl'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      note: json['note'] as String? ?? '',
      category:
          $enumDecodeNullable(_$PasswordCategoryEnumMap, json['category']) ??
              PasswordCategory.others,
      favourite: json['favourite'] as bool? ?? false,
      usage: json['usage'] as int? ?? 0,
      lastUsed: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastUsed'], const TimestampConverter().fromJson),
      timeAdded: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['timeAdded'], const TimestampConverter().fromJson),
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
      'lastUsed': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastUsed, const TimestampConverter().toJson),
      'timeAdded': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.timeAdded, const TimestampConverter().toJson),
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

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
