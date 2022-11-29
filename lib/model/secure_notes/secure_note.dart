import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/helper_models.dart';

part 'secure_note.freezed.dart';
part 'secure_note.g.dart';

@freezed
class SecureNote with _$SecureNote {
  const SecureNote._();

  const factory SecureNote(
    String id,
    String path,
    String title,
    String content,
    bool favourite,
    int usage,
    @TimestampConverter() DateTime lastUsed,
    @TimestampConverter() DateTime timeAdded,
  ) = _SecureNote;

  factory SecureNote.fromDoc(DocumentSnapshot doc) {
    SecureNote password =
        SecureNote.fromJson(doc.data() as Map<String, dynamic>? ?? {});
    return password.copyWith(id: doc.id);
  }

  Map<String, dynamic> toDoc() {
    Map<String, dynamic> map = toJson();
    map.remove('id');
    return map;
  }

  factory SecureNote.fromJson(Map<String, dynamic> json) =>
      _$SecureNoteFromJson(json);
}
