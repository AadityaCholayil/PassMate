import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:passmate/model/password/password.dart';
import 'package:passmate/model/payment_card/payment_card.dart';
import 'package:passmate/model/secure_notes/secure_note.dart';

part 'folder.freezed.dart';
part 'folder.g.dart';

@freezed
class Folder with _$Folder {
  const Folder._();

  const factory Folder(
    String folderName,
    String path,
    List<String> subFolderList,
    List<Password> passwordList,
    List<PaymentCard> paymentCardList,
    List<SecureNote> secureNotesList,
  ) = _Folder;

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

  // factory Folder.fromDoc(DocumentSnapshot doc) {
  //   Folder password =
  //       Folder.fromJson(doc.data() as Map<String, dynamic>? ?? {});
  //   return password.copyWith(id: doc.id);
  // }

  // Map<String, dynamic> toDoc() {
  //   Map<String, dynamic> map = toJson();
  //   map.remove('id');
  //   return map;
  // }
}
