import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passmate/model/user.dart';

class DatabaseRepository {
  final String uid;

  DatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final usersRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson(),
          );



  Future<List<UserData>> getUsers() async {
    final list = await usersRef.get().then((snapshot) => snapshot.docs);
    return list.map((e) => e.data()).toList();
  }

  Future<UserData> getCompleteUserData(UserData userData) async {
    UserData userDataNew = await usersRef
            .doc(userData.uid).get()
            .then((value) => value.data()!);
    return userDataNew;
  }

  Future<void> addUser(UserData userData) async {
    await usersRef.add(userData);
  }

  Future<void> updateUser(UserData userData) async {
    await usersRef.doc(userData.uid).set(userData);
  }

  Future<void> deleteUser(UserData userData) async {
    await usersRef.doc(userData.uid).delete();
  }



}
