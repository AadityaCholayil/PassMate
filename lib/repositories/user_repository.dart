import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passmate/model/user/user.dart';
import 'package:passmate/repositories/database_repository.dart';

class UserRepository extends DatabaseRepository {
  UserRepository({required User user}) : super(uid: user.uid);

  CollectionReference<User> get usersRef =>
      db.collection('users').withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  Future<User?> get completeUserData async {
    User? userDataNew =
        await usersRef.doc(uid).get().then((value) => value.data());
    return userDataNew;
  }

  Future<void> updateUserData(User userData) async {
    await usersRef.doc(uid).set(userData);
  }

  Future<void> deleteUserData() async {
    await usersRef.doc(uid).delete();
  }
}
