import 'package:passmate/model/old_password.dart';
import 'package:passmate/model/old_payment_card.dart';
import 'package:passmate/model/old_secure_note.dart';

class OldFolder {
  String folderName = '';
  String path = '';
  List<String> subFolderList = [];
  List<OldPassword> passwordList = [];
  List<OldPaymentCard> paymentCardList = [];
  List<OldSecureNote> secureNotesList = [];

  OldFolder({
    required this.folderName,
    required this.path,
    required this.subFolderList,
    required this.passwordList,
    required this.paymentCardList,
    required this.secureNotesList,
  });

  OldFolder.empty()
      : this(
          folderName: '',
          path: '',
          subFolderList: const [],
          passwordList: const [],
          paymentCardList: const [],
          secureNotesList: const [],
        );
}

class FolderData {
  List<String> folderList = [];

  FolderData();

  FolderData.fromDB(Map<String, Object?> json) {
    folderList = List<String>.from(json['folderList'] as List);
  }

  Map<String, Object?> toJson() {
    return {
      'folderList': folderList,
    };
  }
}
