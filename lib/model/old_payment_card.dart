import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:passmate/repositories/encryption_repository.dart';

class OldPaymentCard {
  String id;
  String path;
  String bankName;
  String cardNo;
  String holderName;
  String expiryDate;
  String cvv;
  PaymentCardType cardType;
  String note;
  bool favourite;
  int usage;
  String color;
  Timestamp? lastUsed;
  Timestamp? timeAdded;

  OldPaymentCard({
    this.id = '',
    this.path = '',
    this.bankName = '',
    this.cardNo = '',
    this.holderName = '',
    this.expiryDate = '',
    this.cvv = '',
    this.cardType = PaymentCardType.creditCard,
    this.note = '',
    this.favourite = false,
    this.usage = 0,
    this.color = '',
    this.lastUsed,
    this.timeAdded,
  });

  OldPaymentCard.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          path: json['path']! as String,
          bankName: json['bankName']! as String,
          cardNo: json['cardNo']! as String,
          holderName: json['holderName']! as String,
          expiryDate: json['expiryDate']! as String,
          cvv: json['cvv']! as String,
          cardType: PaymentCardType.values[json['cardType']! as int],
          note: json['note']! as String,
          favourite: json['favourite']! as bool,
          usage: json['usage']! as int,
          color: json['color']! as String,
          lastUsed: json['lastUsed'] as Timestamp,
          timeAdded: json['timeAdded'] as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'path': path,
      'bankName': bankName,
      'cardNo': cardNo,
      'holderName': holderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'cardType': cardType.index,
      'note': note,
      'favourite': favourite,
      'usage': usage,
      'color': color,
      'lastUsed': lastUsed,
      'timeAdded': timeAdded
    };
  }

  Future encrypt(EncryptionRepository encryptionRepository) async {
    bankName = await encryptionRepository.encrypt(bankName);
    cardNo = await encryptionRepository.encrypt(cardNo);
    holderName = await encryptionRepository.encrypt(holderName);
    expiryDate = await encryptionRepository.encrypt(expiryDate);
    cvv = await encryptionRepository.encrypt(cvv);
    note = await encryptionRepository.encrypt(note);
  }

  Future decrypt(EncryptionRepository encryptionRepository) async {
    bankName = await encryptionRepository.decrypt(bankName);
    cardNo = await encryptionRepository.decrypt(cardNo);
    holderName = await encryptionRepository.decrypt(holderName);
    expiryDate = await encryptionRepository.decrypt(expiryDate);
    cvv = await encryptionRepository.decrypt(cvv);
    note = await encryptionRepository.decrypt(note);
  }

  @override
  String toString() {
    return '$path - $bankName: $cardNo, $holderName, $cvv, $expiryDate, Type: $cardType, isFav: $favourite';
  }
}

enum PaymentCardType { all, creditCard, debitCard, others }

Map<String, IconData> paymentCardCategoryIcon = {
  'Favourites': Icons.favorite_border_rounded,
  'All': Icons.favorite_border_rounded,
  'Credit Card': Icons.credit_card_outlined,
  'Debit Card': Icons.credit_card_outlined,
  'Others': Icons.more_horiz
};

String getPaymentCardTypeStr(PaymentCardType type) {
  String label = '';
  switch (type) {
    case PaymentCardType.all:
      label = 'All';
      break;
    case PaymentCardType.creditCard:
      label = 'Credit Card';
      break;
    case PaymentCardType.debitCard:
      label = 'Debit Card';
      break;
    case PaymentCardType.others:
      label = 'Others';
      break;
    default:
      break;
  }
  return label.replaceRange(0, 1, label.substring(0, 1).toUpperCase());
}
