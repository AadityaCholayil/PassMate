import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/helper_models.dart';
import 'package:passmate/model/password/password_category.dart';

import '../../repositories/encryption_repository.dart';

part 'password.freezed.dart';
part 'password.g.dart';

@freezed
class Password with _$Password {
  const Password._();

  const factory Password({
    @Default('') String id,
    @Default('') String path,
    @Default('') String siteName,
    @Default('') String siteUrl,
    @Default('') String email,
    @Default('') String password,
    @Default('') String imageUrl,
    @Default('') String note,
    PasswordCategory? category,
    bool? favourite,
    int? usage,
    @TimestampConverter() DateTime? lastUsed,
    @TimestampConverter() DateTime? timeAdded,
  }) = _Password;

  factory Password.fromDoc(DocumentSnapshot doc) {
    Password password =
        Password.fromJson(doc.data() as Map<String, dynamic>? ?? {});
    return password.copyWith(id: doc.id);
  }

  Map<String, dynamic> toDoc() {
    Map<String, dynamic> map = toJson();
    map.remove('id');
    return map;
  }

  Future<Password> encrypt(EncryptionRepository encryptionRepository) async {
    return copyWith(
      siteName: await encryptionRepository.encrypt(siteName),
      siteUrl: await encryptionRepository.encrypt(siteUrl),
      email: await encryptionRepository.encrypt(email),
      password: await encryptionRepository.encrypt(password),
      imageUrl: await encryptionRepository.encrypt(imageUrl),
      note: await encryptionRepository.encrypt(note),
    );
  }

  Future decrypt(EncryptionRepository encryptionRepository) async {
    return copyWith(
      siteName: await encryptionRepository.decrypt(siteName),
      siteUrl: await encryptionRepository.decrypt(siteUrl),
      email: await encryptionRepository.decrypt(email),
      password: await encryptionRepository.decrypt(password),
      imageUrl: await encryptionRepository.decrypt(imageUrl),
      note: await encryptionRepository.decrypt(note),
    );
  }

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);
}
