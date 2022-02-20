import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';

class Folder {
  String folderName = '';
  String path = '';
  List<String> subFolderList = [];
  List<Password> passwordList = [];
  List<PaymentCard> paymentCardList = [];
  List<SecureNote> secureNotesList = [];

  Folder({
    required this.folderName,
    required this.path,
    required this.subFolderList,
    required this.passwordList,
    required this.paymentCardList,
    required this.secureNotesList,
  });

  // static Folder get empty => Folder(folderName: '',
  //   path: '',
  //   subFolderList: [],
  //   passwordList: [],
  //   paymentCardList: [],
  //   secureNotesList: [],);

  Folder.empty() :
        this(
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
