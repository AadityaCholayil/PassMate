import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';

class Folder{

  List<Folder> subFolderList = [];
  List<Password> passwordList = [];
  List<PaymentCard>  paymentCardList = [];
  List<SecureNote> secureNotesList = [];

  // Folder.fromDB(String path, Map<String, dynamic> map){
  //   this.passwordList
  // }

}

class FolderData{

  List<String> passwordList = [];
  List<String>  paymentCardList = [];
  List<String> secureNotesList = [];

  FolderData();

  FolderData.fromDB(Map<String, Object?> json){
    passwordList = List<String>.from(json['passwordList'] as List);
    paymentCardList = List<String>.from(json['paymentCardList'] as List);
    secureNotesList = List<String>.from(json['secureNotesList'] as List);
  }

  Map<String, Object?> toJson(){
    return {
      'passwordList': passwordList,
      'paymentCardList': paymentCardList,
      'secureNotesList': secureNotesList,
    };
  }

}