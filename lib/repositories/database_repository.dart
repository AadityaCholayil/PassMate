import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/shared/error_screen.dart';

class DatabaseRepository {
  final String uid;

  DatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference<UserData> get usersRef =>
      db.collection('users').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<UserData> get completeUserData async {
    try {
      UserData userDataNew = await usersRef
          .doc(uid)
          .get()
          .then((value) => value.data() ?? UserData.empty);
      return userDataNew;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future<void> updateUserData(UserData userData) async {
    try {
      await usersRef.doc(uid).set(userData);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future<void> deleteUserData() async {
    try {
      await usersRef.doc(uid).delete();
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future<String?> uploadFile(File _image) async {
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('UserProfiles/$uid/profile_pic.png')
          .putFile(_image);
    } on Exception catch (e) {
      print('Failed - $e');
      return null;
    }
    try {
      var result = await firebase_storage.FirebaseStorage.instance
          .ref('UserProfiles/$uid/profile_pic.png')
          .getDownloadURL();
      print('profileUrl: $result');
      return result;
    } on Exception catch (e) {
      print('Failed - $e');
      return null;
    }
  }

  DocumentReference<FolderData> get foldersRef => db
      .collection('users')
      .doc(uid)
      .collection('folders')
      .doc('folderList')
      .withConverter<FolderData>(
        fromFirestore: (snapshot, _) => FolderData.fromDB(snapshot.data()!),
        toFirestore: (folderData, _) => folderData.toJson(),
      );

  CollectionReference<Password> get passwordsRef => db
      .collection('users')
      .doc(uid)
      .collection('passwords')
      .withConverter<Password>(
        fromFirestore: (snapshot, _) =>
            Password.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (password, _) => password.toJson(),
      );

  Future<List<Password>> getPasswords({String path = ''}) async {
    List<QueryDocumentSnapshot<Password>> list = [];
    if (path == '') {
      list = await passwordsRef.get().then((snapshot) => snapshot.docs);
    } else {
      list = await passwordsRef
          .where('path', isEqualTo: path)
          .get()
          .then((snapshot) => snapshot.docs);
    }
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPassword(Password password) async {
    try {
      await passwordsRef.add(password);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePassword(Password password, String oldPath) async {
    try {
      await passwordsRef.doc(password.id).set(password);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePassword(Password password) async {
    try {
      await passwordsRef.doc(password.id).delete();
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  CollectionReference<PaymentCard> get paymentCardsRef => db
      .collection('users')
      .doc(uid)
      .collection('paymentCards')
      .withConverter<PaymentCard>(
        fromFirestore: (snapshot, _) =>
            PaymentCard.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (paymentCard, _) => paymentCard.toJson(),
      );

  Future<List<PaymentCard>> getPaymentCards({String path = ''}) async {
    List<QueryDocumentSnapshot<PaymentCard>> list = [];
    if (path == '') {
      list = await paymentCardsRef.get().then((snapshot) => snapshot.docs);
    } else {
      list = await paymentCardsRef
          .where('path', isEqualTo: path)
          .get()
          .then((snapshot) => snapshot.docs);
    }
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPaymentCard(PaymentCard paymentCard) async {
    try {
      await paymentCardsRef.add(paymentCard);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePaymentCard(
      PaymentCard paymentCard, String oldPath) async {
    try {
      await paymentCardsRef.doc(paymentCard.id).set(paymentCard);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePaymentCard(PaymentCard paymentCard) async {
    try {
      await paymentCardsRef.doc(paymentCard.id).delete();
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  CollectionReference<SecureNote> get secureNotesRef => db
      .collection('users')
      .doc(uid)
      .collection('secureNotes')
      .withConverter<SecureNote>(
        fromFirestore: (snapshot, _) =>
            SecureNote.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (secureNote, _) => secureNote.toJson(),
      );

  Future<List<SecureNote>> getSecureNotes({String path = ''}) async {
    List<QueryDocumentSnapshot<SecureNote>> list = [];
    if (path == '') {
      list = await secureNotesRef.get().then((snapshot) => snapshot.docs);
    } else {
      list = await secureNotesRef
          .where('path', isEqualTo: path)
          .get()
          .then((snapshot) => snapshot.docs);
    }
    return list.map((e) => e.data()).toList();
  }

  Future<String> addSecureNote(SecureNote secureNote) async {
    try {
      await secureNotesRef.add(secureNote);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updateSecureNote(SecureNote secureNote, String oldPath) async {
    try {
      await secureNotesRef.doc(secureNote.id).set(secureNote);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deleteSecureNote(SecureNote secureNote) async {
    try {
      await secureNotesRef.doc(secureNote.id).delete();
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<FolderData> getFolder() async {
    FolderData data = await foldersRef
        .get()
        .then((value) => value.data() ?? FolderData());
    return data;
  }

  Future addFolder({String folderName = '/'}) async {
    try {
      FolderData data = await foldersRef
          .get()
          .then((value) => value.data() ?? FolderData());
      data.folderList.add(folderName);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future renameFolder({String oldPath = '/', String newPath = '/'}) async {
    try {
      FolderData data = await foldersRef
          .get()
          .then((value) => value.data() ?? FolderData());
      data.folderList.remove(oldPath);
      data.folderList.add(newPath);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future deleteFolder({String folderName = '/'}) async {
    try {
      FolderData data = await foldersRef
          .get()
          .then((value) => value.data() ?? FolderData());
      data.folderList.remove(folderName);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }
}
