// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Folder _$$_FolderFromJson(Map<String, dynamic> json) => _$_Folder(
      json['folderName'] as String,
      json['path'] as String,
      (json['subFolderList'] as List<dynamic>).map((e) => e as String).toList(),
      (json['passwordList'] as List<dynamic>)
          .map((e) => Password.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['paymentCardList'] as List<dynamic>)
          .map((e) => PaymentCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['secureNotesList'] as List<dynamic>)
          .map((e) => SecureNote.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_FolderToJson(_$_Folder instance) => <String, dynamic>{
      'folderName': instance.folderName,
      'path': instance.path,
      'subFolderList': instance.subFolderList,
      'passwordList': instance.passwordList,
      'paymentCardList': instance.paymentCardList,
      'secureNotesList': instance.secureNotesList,
    };
