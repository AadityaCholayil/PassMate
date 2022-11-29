import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/helper_models.dart';
import 'package:passmate/model/password/password_category.dart';

part 'password.freezed.dart';
part 'password.g.dart';

@freezed
class Password with _$Password {
  const Password._();

  const factory Password({
    String? id,
    String? path,
    String? siteName,
    String? siteUrl,
    String? email,
    String? password,
    String? imageUrl,
    String? note,
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

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);
}
