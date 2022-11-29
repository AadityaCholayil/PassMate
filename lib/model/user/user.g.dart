// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      json['uid'] as String,
      json['email'] as String?,
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['photoUrl'] as String?,
      json['pinSet'] as bool?,
      $enumDecodeNullable(_$SortMethodEnumMap, json['sortMethod']),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoUrl': instance.photoUrl,
      'pinSet': instance.pinSet,
      'sortMethod': _$SortMethodEnumMap[instance.sortMethod],
    };

const _$SortMethodEnumMap = {
  SortMethod.recentlyAdded: 'recentlyAdded',
  SortMethod.frequentlyUsed: 'frequentlyUsed',
  SortMethod.recentlyUsed: 'recentlyUsed',
};
