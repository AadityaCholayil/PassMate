// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentCard _$$_PaymentCardFromJson(Map<String, dynamic> json) =>
    _$_PaymentCard(
      json['id'] as String,
      json['path'] as String,
      json['bankName'] as String,
      json['cardNo'] as String,
      json['holderName'] as String,
      json['expiryDate'] as String,
      json['cvv'] as String,
      json['note'] as String,
      json['color'] as String,
      json['favourite'] as bool,
      json['usage'] as int,
      $enumDecode(_$PaymentCardTypeEnumMap, json['cardType']),
      const TimestampConverter().fromJson(json['lastUsed'] as Timestamp),
      const TimestampConverter().fromJson(json['timeAdded'] as Timestamp),
    );

Map<String, dynamic> _$$_PaymentCardToJson(_$_PaymentCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'bankName': instance.bankName,
      'cardNo': instance.cardNo,
      'holderName': instance.holderName,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'note': instance.note,
      'color': instance.color,
      'favourite': instance.favourite,
      'usage': instance.usage,
      'cardType': _$PaymentCardTypeEnumMap[instance.cardType]!,
      'lastUsed': const TimestampConverter().toJson(instance.lastUsed),
      'timeAdded': const TimestampConverter().toJson(instance.timeAdded),
    };

const _$PaymentCardTypeEnumMap = {
  PaymentCardType.all: 'all',
  PaymentCardType.creditCard: 'creditCard',
  PaymentCardType.debitCard: 'debitCard',
  PaymentCardType.others: 'others',
};
