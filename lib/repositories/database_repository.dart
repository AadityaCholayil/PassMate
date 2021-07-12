import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:passmate/model/folder.dart';
import 'package:passmate/model/password.dart';
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

  CollectionReference<FolderData> get foldersRef => db
      .collection('users')
      .doc(uid)
      .collection('folders')
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

  Future<List<Password>> getPasswords(PasswordCategory passwordCategory) async {
    List<QueryDocumentSnapshot<Password>> list = [];
    if (passwordCategory == PasswordCategory.all) {
      list = await passwordsRef.get().then((snapshot) => snapshot.docs);
    } else {
      list = await passwordsRef
          .where('category', isEqualTo: passwordCategory.index)
          .get()
          .then((snapshot) => snapshot.docs);
    }
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

  CollectionReference<Password> get paymentCardsRef => db
      .collection('users')
      .doc(uid)
      .collection('paymentCards')
      .withConverter<Password>(
        fromFirestore: (snapshot, _) =>
            Password.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (password, _) => password.toJson(),
      );

  Future<List<Password>> getPaymentCards(
      PasswordCategory passwordCategory) async {
    List<QueryDocumentSnapshot<Password>> list = [];
    if (passwordCategory == PasswordCategory.all) {
      list = await passwordsRef.get().then((snapshot) => snapshot.docs);
    } else {
      list = await passwordsRef
          .where('category', isEqualTo: passwordCategory.index)
          .get()
          .then((snapshot) => snapshot.docs);
    }
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPaymentCard(Password password) async {
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

  Future<String> updatePaymentCard(Password password, String oldPath) async {
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

  Future<String> deletePaymentCard(Password password) async {
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
}
