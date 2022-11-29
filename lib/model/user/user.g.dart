// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      pinSet: json['pinSet'] as bool?,
      sortMethod: $enumDecodeNullable(_$SortMethodEnumMap, json['sortMethod']),
      folderList: (json['folderList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'photoUrl': instance.photoUrl,
      'pinSet': instance.pinSet,
      'sortMethod': _$SortMethodEnumMap[instance.sortMethod],
      'folderList': instance.folderList,
    };

const _$SortMethodEnumMap = {
  SortMethod.recentlyAdded: 'recentlyAdded',
  SortMethod.frequentlyUsed: 'frequentlyUsed',
  SortMethod.recentlyUsed: 'recentlyUsed',
};
