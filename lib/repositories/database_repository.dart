import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:passmate/model/password.dart';
import 'package:passmate/model/user.dart';

class DatabaseRepository {
  final String uid;

  DatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<UserData> get completeUserData async {
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

  Query<Password> get passwordsRef => FirebaseFirestore.instance
      .collectionGroup('passwords')
      .withConverter<Password>(
        fromFirestore: (snapshot, _) =>
            Password.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (password, _) => password.toJson(uid),
      );

  Future<List<Password>> getPasswords(PasswordCategory passwordCategory) async {
    print('uid: $uid');
    final list = await passwordsRef
        .where('uid', isEqualTo: uid)
        .where('category', isEqualTo: passwordCategory.index)
        .get()
        .then((snapshot) => snapshot.docs);
    print(list);
    return list.map((e) => e.data()).toList();
  }

  Future<String> addPassword(Password password) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('folders')
          .doc(password.path)
          .collection('passwords')
          .add(password.toJson(uid));
      return 'Success';
    } on Exception catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String> updatePassword(Password password) async {
    try {
      await db
          .collection('users')
          .doc(uid)
          .collection('folders')
          .doc(password.path)
          .collection('passwords')
          .doc(password.id)
          .set(password.toJson(uid));
      return 'Success';
    } on Exception catch (_) {
      return 'Failed';
    }
  }

  Future<void> deletePassword(Password password) async {
    await db
        .collection('users')
        .doc(uid)
        .collection('folders')
        .doc(password.path)
        .collection('passwords')
        .doc(password.id)
        .delete();
  }
}
