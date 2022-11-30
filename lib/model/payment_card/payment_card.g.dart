// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentCard _$$_PaymentCardFromJson(Map<String, dynamic> json) =>
    _$_PaymentCard(
      id: json['id'] as String? ?? '',
      path: json['path'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      cardNo: json['cardNo'] as String? ?? '',
      holderName: json['holderName'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      cvv: json['cvv'] as String? ?? '',
      note: json['note'] as String? ?? '',
      color: json['color'] as String? ?? '',
      favourite: json['favourite'] as bool? ?? false,
      usage: json['usage'] as int? ?? 0,
      cardType:
          $enumDecodeNullable(_$PaymentCardTypeEnumMap, json['cardType']) ??
              PaymentCardType.others,
      lastUsed: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['lastUsed'], const TimestampConverter().fromJson),
      timeAdded: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['timeAdded'], const TimestampConverter().fromJson),
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
      'lastUsed': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.lastUsed, const TimestampConverter().toJson),
      'timeAdded': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.timeAdded, const TimestampConverter().toJson),
    };

const _$PaymentCardTypeEnumMap = {
  PaymentCardType.all: 'all',
  PaymentCardType.creditCard: 'creditCard',
  PaymentCardType.debitCard: 'debitCard',
  PaymentCardType.others: 'others',
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
