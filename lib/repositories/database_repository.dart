import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/old_password.dart';
import 'package:passmate/model/old_payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/user.dart';
import 'package:passmate/shared/error_screen.dart';

class DatabaseRepository {
  final String uid;

  DatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
}

class OldDatabaseRepository {
  final String uid;

  OldDatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

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
      await storage.ref('UserProfiles/$uid/profile_pic.png').putFile(_image);
      var result = await storage
          .ref('UserProfiles/$uid/profile_pic.png')
          .getDownloadURL();
      print('profileUrl: $result');
      return result;
    } on Exception catch (e) {
      print('Failed - $e');
      return null;
    }
  }

  Future<String> getFaviconFromStorage(String siteName) async {
    try {
      var result = await storage
          .ref('WebIcons/${siteName[0].toUpperCase()}.png')
          .getDownloadURL();
      return result;
    } on Exception catch (e) {
      print('Failed fetch - $e');
      return 'http://www.trianglelearningcenter.org/wp-content/uploads/2020/08/placeholder.png';
    }
  }

  Future<String> deleteProfilePicFromStorage() async {
    try {
      await storage.ref('UserProfiles/$uid/profile_pic.png').delete();
      return 'Success';
    } on Exception catch (e) {
      print('Failed - $e');
      return 'Failed';
    }
  }

  CollectionReference<OldPassword> get passwordsRef => db
      .collection('users')
      .doc(uid)
      .collection('passwords')
      .withConverter<OldPassword>(
        fromFirestore: (snapshot, _) =>
            OldPassword.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (password, _) => password.toJson(),
      );

  Future<List<OldPassword>> getPasswords({String path = ''}) async {
    List<QueryDocumentSnapshot<OldPassword>> list = [];
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

  Future<String> addPassword(OldPassword password) async {
    try {
      await passwordsRef.add(password);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePassword(OldPassword password, String oldPath) async {
    try {
      await passwordsRef.doc(password.id).set(password);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePassword(OldPassword password) async {
    try {
      await passwordsRef.doc(password.id).delete();
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  CollectionReference<OldPaymentCard> get paymentCardsRef => db
      .collection('users')
      .doc(uid)
      .collection('paymentCards')
      .withConverter<OldPaymentCard>(
        fromFirestore: (snapshot, _) =>
            OldPaymentCard.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (paymentCard, _) => paymentCard.toJson(),
      );

  Future<List<OldPaymentCard>> getPaymentCards({String path = ''}) async {
    List<QueryDocumentSnapshot<OldPaymentCard>> list = [];
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

  Future<String> addPaymentCard(OldPaymentCard paymentCard) async {
    try {
      await paymentCardsRef.add(paymentCard);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePaymentCard(
      OldPaymentCard paymentCard, String oldPath) async {
    try {
      await paymentCardsRef.doc(paymentCard.id).set(paymentCard);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePaymentCard(OldPaymentCard paymentCard) async {
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

  DocumentReference<FolderData> get foldersRef => db
      .collection('users')
      .doc(uid)
      .collection('folders')
      .doc('folderList')
      .withConverter<FolderData>(
        fromFirestore: (snapshot, _) => FolderData.fromDB(snapshot.data()!),
        toFirestore: (folderData, _) => folderData.toJson(),
      );

  Future<FolderData> getFolder() async {
    FolderData data =
        await foldersRef.get().then((value) => value.data() ?? FolderData());
    return data;
  }

  Future addFolder({String folderName = '/'}) async {
    try {
      FolderData data =
          await foldersRef.get().then((value) => value.data() ?? FolderData());
      data.folderList.add(folderName);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future renameFolder({String oldPath = '/', String newPath = '/'}) async {
    try {
      FolderData data =
          await foldersRef.get().then((value) => value.data() ?? FolderData());
      data.folderList.remove(oldPath);
      data.folderList.add(newPath);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  Future deleteFolder({String folderName = '/'}) async {
    try {
      FolderData data =
          await foldersRef.get().then((value) => value.data() ?? FolderData());
      data.folderList.remove(folderName);
      await foldersRef.set(data);
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }
}
