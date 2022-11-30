import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/helper_models.dart';
import 'package:passmate/model/payment_card/payment_card_type.dart';
import 'package:passmate/repositories/encryption_repository.dart';

part 'payment_card.freezed.dart';
part 'payment_card.g.dart';

@freezed
class PaymentCard with _$PaymentCard {
  const PaymentCard._();

  const factory PaymentCard({
    @Default('') String id,
    @Default('') String path,
    @Default('') String bankName,
    @Default('') String cardNo,
    @Default('') String holderName,
    @Default('') String expiryDate,
    @Default('') String cvv,
    @Default('') String note,
    @Default('') String color,
    @Default(false) bool favourite,
    @Default(0) int usage,
    @Default(PaymentCardType.others) PaymentCardType cardType,
    @TimestampConverter() DateTime? lastUsed,
    @TimestampConverter() DateTime? timeAdded,
  }) = _PaymentCard;

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

  Future<PaymentCard> encrypt(EncryptionRepository encryptionRepository) async {
    return copyWith(
      bankName: await encryptionRepository.encrypt(bankName),
      cardNo: await encryptionRepository.encrypt(cardNo),
      holderName: await encryptionRepository.encrypt(holderName),
      expiryDate: await encryptionRepository.encrypt(expiryDate),
      cvv: await encryptionRepository.encrypt(cvv),
      note: await encryptionRepository.encrypt(note),
    );
  }

  Future<PaymentCard> decrypt(EncryptionRepository encryptionRepository) async {
    return copyWith(
      bankName: await encryptionRepository.decrypt(bankName),
      cardNo: await encryptionRepository.decrypt(cardNo),
      holderName: await encryptionRepository.decrypt(holderName),
      expiryDate: await encryptionRepository.decrypt(expiryDate),
      cvv: await encryptionRepository.decrypt(cvv),
      note: await encryptionRepository.decrypt(note),
    );
  }

  factory PaymentCard.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardFromJson(json);
}
