import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
import 'package:passmate/model/payment_card.dart';
import 'package:passmate/model/secure_note.dart';
import 'package:passmate/model/user.dart';

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
    //TODO ADD SAFETY
    UserData userDataNew = await usersRef
        .doc(uid)
        .get()
        .then((value) => value.data() ?? UserData.empty);
    return userDataNew;
  }

  Future<void> updateUserData(UserData userData) async {
    await usersRef.doc(uid).set(userData);
  }

  Future<void> deleteUser() async {
    await usersRef.doc(uid).delete();
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

  CollectionReference<FolderData> get foldersRef =>
      db
          .collection('users')
          .doc(uid)
          .collection('folders')
          .withConverter<FolderData>(
        fromFirestore: (snapshot, _) => FolderData.fromDB(snapshot.data()!),
        toFirestore: (folderData, _) => folderData.toJson(),
      );

  CollectionReference<Password> get passwordsRef =>
      db
          .collection('users')
          .doc(uid)
          .collection('passwords')
          .withConverter<Password>(
        fromFirestore: (snapshot, _) =>
            Password.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (password, _) => password.toJson(),
      );

  Future<List<Password>> getPasswords() async {
    List<QueryDocumentSnapshot<Password>> list = [];
    list = await passwordsRef.get().then((snapshot) => snapshot.docs);
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPassword(Password password) async {
    try {
      final res = await passwordsRef.add(password);
      FolderData data = await foldersRef
          .doc(password.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.passwordList.add(res.id);
      await foldersRef.doc(password.path).set(data);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePassword(Password password, String oldPath) async {
    try {
      await passwordsRef.doc(password.id).set(password);
      if (password.path != oldPath) {
        FolderData data = await foldersRef
            .doc(oldPath)
            .get()
            .then((value) => value.data() ?? FolderData());
        data.passwordList.remove(password.id);
        await foldersRef.doc(oldPath).set(data);
        FolderData data2 = await foldersRef
            .doc(password.path)
            .get()
            .then((value) => value.data() ?? FolderData());
        data2.passwordList.add(password.id);
        await foldersRef.doc(password.path).set(data2);
      }
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePassword(Password password) async {
    try {
      await passwordsRef.doc(password.id).delete();
      FolderData data = await foldersRef
          .doc(password.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.passwordList.remove(password.id);
      await foldersRef.doc(password.path).set(data);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  CollectionReference<PaymentCard> get paymentCardsRef =>
      db
          .collection('users')
          .doc(uid)
          .collection('paymentCards')
          .withConverter<PaymentCard>(
        fromFirestore: (snapshot, _) =>
            PaymentCard.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (paymentCard, _) => paymentCard.toJson(),
      );

  Future<List<PaymentCard>> getPaymentCards() async {
    List<QueryDocumentSnapshot<PaymentCard>> list = [];
    list = await paymentCardsRef.get().then((snapshot) => snapshot.docs);
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPaymentCard(PaymentCard paymentCard) async {
    try {
      final res = await paymentCardsRef.add(paymentCard);
      FolderData data = await foldersRef
          .doc(paymentCard.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.paymentCardList.add(res.id);
      await foldersRef.doc(paymentCard.path).set(data);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePaymentCard(PaymentCard paymentCard,
      String oldPath) async {
    try {
      await paymentCardsRef.doc(paymentCard.id).set(paymentCard);
      if (paymentCard.path != oldPath) {
        FolderData data = await foldersRef
            .doc(oldPath)
            .get()
            .then((value) => value.data() ?? FolderData());
        data.paymentCardList.remove(paymentCard.id);
        await foldersRef.doc(oldPath).set(data);
        FolderData data2 = await foldersRef
            .doc(paymentCard.path)
            .get()
            .then((value) => value.data() ?? FolderData());
        data2.paymentCardList.add(paymentCard.id);
        await foldersRef.doc(paymentCard.path).set(data2);
      }
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deletePaymentCard(PaymentCard paymentCard) async {
    try {
      await paymentCardsRef.doc(paymentCard.id).delete();
      FolderData data = await foldersRef
          .doc(paymentCard.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.paymentCardList.remove(paymentCard.id);
      await foldersRef.doc(paymentCard.path).set(data);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  CollectionReference<SecureNote> get secureNotesRef =>
      db
          .collection('users')
          .doc(uid)
          .collection('secureNotes')
          .withConverter<SecureNote>(
        fromFirestore: (snapshot, _) =>
            SecureNote.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (secureNote, _) => secureNote.toJson(),
      );

  Future<List<SecureNote>> getSecureNotes() async {
    List<QueryDocumentSnapshot<SecureNote>> list = [];
    list = await secureNotesRef.get().then((snapshot) => snapshot.docs);
    return list.map((e) => e.data()).toList();
  }

  Future<String> addSecureNote(SecureNote secureNote) async {
    try {
      final res = await secureNotesRef.add(secureNote);
      FolderData data = await foldersRef
          .doc(secureNote.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.secureNotesList.add(res.id);
      await foldersRef.doc(secureNote.path).set(data);
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updateSecureNote(SecureNote secureNote, String oldPath) async {
    try {
      await secureNotesRef.doc(secureNote.id).set(secureNote);
      if (secureNote.path != oldPath) {
        FolderData data = await foldersRef
            .doc(oldPath)
            .get()
            .then((value) => value.data() ?? FolderData());
        data.secureNotesList.remove(secureNote.id);
        await foldersRef.doc(oldPath).set(data);
        FolderData data2 = await foldersRef
            .doc(secureNote.path)
            .get()
            .then((value) => value.data() ?? FolderData());
        data2.secureNotesList.add(secureNote.id);
        await foldersRef.doc(secureNote.path).set(data2);
      }
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<String> deleteSecureNote(SecureNote secureNote) async {
    try {
      await secureNotesRef.doc(secureNote.id).delete();
      FolderData data = await foldersRef
          .doc(secureNote.path)
          .get()
          .then((value) => value.data() ?? FolderData());
      data.secureNotesList.remove(secureNote.id);
      await foldersRef.doc(secureNote.path).set(data);
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<FolderData> getFolder({String path = '/'}) async {
    FolderData data = await foldersRef
        .doc(path)
        .get()
        .then((value) => value.data() ?? FolderData());
    return data;
  }



}
