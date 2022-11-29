import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/helper_models.dart';
import 'package:passmate/model/payment_card/payment_card_type.dart';

part 'payment_card.freezed.dart';
part 'payment_card.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  const PaymentCard._();

  const factory PaymentCard(
    String id,
    String path,
    String bankName,
    String cardNo,
    String holderName,
    String expiryDate,
    String cvv,
    String note,
    String color,
    bool favourite,
    int usage,
    PaymentCardType cardType,
    @TimestampConverter() DateTime lastUsed,
    @TimestampConverter() DateTime timeAdded,
  ) = _PaymentCard;

  factory PaymentCard.fromDoc(DocumentSnapshot doc) {
    PaymentCard paymentCard =
        PaymentCard.fromJson(doc.data() as Map<String, dynamic>? ?? {});
    return paymentCard.copyWith(id: doc.id);
  }

  Map<String, dynamic> toDoc() {
    Map<String, dynamic> map = toJson();
    map.remove('id');
    return map;
  }

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);
}
